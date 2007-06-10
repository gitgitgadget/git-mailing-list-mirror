From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 00:58:51 +0200
Message-ID: <20070610225851.GA5761@steel.home>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:59:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWNB-0000wX-P6
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758851AbXFJW6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759215AbXFJW6z
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:58:55 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:54944 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758851AbXFJW6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:58:55 -0400
Received: from tigra.home (Faacf.f.strato-dslnet.de [195.4.170.207])
	by post.webmailer.de (mrclete mo11) (RZmta 7.2)
	with ESMTP id 801404j5AIVlMM ; Mon, 11 Jun 2007 00:58:52 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 44F47277BD;
	Mon, 11 Jun 2007 00:58:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DCA2CD258; Mon, 11 Jun 2007 00:58:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706091854330.4059@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtopI9Dg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49784>

Johannes Schindelin, Sat, Jun 09, 2007 19:55:10 +0200:
> +MESSAGE="$GIT_DIR"/COMMIT_ANNOTATION.$$
> +git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
> +
> +GIT_INDEX_FILE="$MESSAGE".idx

Because of pid in the filenames, you probably want to cleanup after
the annotation is commited.
