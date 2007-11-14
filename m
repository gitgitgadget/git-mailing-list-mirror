From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to change a submodue as a subdirectory?
Date: Wed, 14 Nov 2007 21:26:51 +0100
Message-ID: <20071114202651.GC3973@steel.home>
References: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOpN-0001T1-S6
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369AbXKNU04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758769AbXKNU0z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:26:55 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:20007 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758369AbXKNU0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:26:55 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (fruni mo28) (RZmta 14.0)
	with ESMTP id 3021b6jAEJdoky ; Wed, 14 Nov 2007 21:26:53 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BD71A277AE;
	Wed, 14 Nov 2007 21:26:52 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7F9DE56D22; Wed, 14 Nov 2007 21:26:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65009>

Ping Yin, Wed, Nov 14, 2007 15:37:57 +0100:
> I have a super project superA, and a submodue subB. Now i decide to
> switch subB from submodule to sub directory. Any good way to do that
> and not losing any history?

$ mv subB sub
$ git add sub
$ git update-index --force-remove subB
$ git commit

Which history were you afraid of losing?
