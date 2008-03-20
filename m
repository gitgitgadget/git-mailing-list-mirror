From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to undo git-rm?
Date: Wed, 19 Mar 2008 17:24:00 -0700
Message-ID: <7v63vi1bvj.fsf@gitster.siamese.dyndns.org>
References: <20080318230441.GA664@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Schemenauer <nas@arctrix.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:25:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8aZ-0004je-9W
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966409AbYCTAYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966407AbYCTAYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:24:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966402AbYCTAYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:24:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5700F2A31;
	Wed, 19 Mar 2008 20:24:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C93072A30; Wed, 19 Mar 2008 20:24:02 -0400 (EDT)
In-Reply-To: <20080318230441.GA664@arctrix.com> (Neil Schemenauer's message
 of "Tue, 18 Mar 2008 17:04:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77594>

Neil Schemenauer <nas@arctrix.com> writes:

> This seemingly simple operation has me stumped.  I removed something
> from my try using "git rm" and now I want it back.  With SVN I would
> use "svn cat <path> > <path>".  After some searching around, I
> though git-cat-file would do the trick.  Alas, it appears as though
> it looks up the SHA for the path in the index and so it too fails.

"git checkout HEAD -- that-path"?
