From: aleksi.aalto@iki.fi
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 5 Dec 2010 14:36:01 +0200 (EET)
Message-ID: <alpine.SOC.2.00.1012051420230.18993@kekkonen.cs.hut.fi>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 13:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPDvs-0004sk-OY
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 13:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab0LEMnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 07:43:07 -0500
Received: from dusk.niksula.hut.fi ([130.233.40.6]:39934 "EHLO
	mail.niksula.hut.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab0LEMnG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 07:43:06 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Dec 2010 07:43:06 EST
Received: by mail.niksula.hut.fi (Postfix, from userid 60001)
	id EE51974785; Sun,  5 Dec 2010 14:36:02 +0200 (EET)
X-Spam-Checker-Version: SpamAssassin 3.3.1-niksula20080612 (2010-03-16) on dusk
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled
	version=3.3.1-niksula20080612
X-Spam-Niksula: No
Received: from kekkonen.cs.hut.fi (kekkonen.cs.hut.fi [130.233.41.50])
	by mail.niksula.hut.fi (Postfix) with ESMTP id F29ED74783;
	Sun,  5 Dec 2010 14:36:01 +0200 (EET)
Received: from localhost (ajaalto@localhost)
	by kekkonen.cs.hut.fi (8.14.3+Sun/8.14.3/Submit) with ESMTP id oB5Ca1d3026271;
	Sun, 5 Dec 2010 14:36:01 +0200 (EET)
X-Authentication-Warning: kekkonen.cs.hut.fi: ajaalto owned process doing -bs
X-X-Sender: ajaalto@kekkonen.cs.hut.fi
In-Reply-To: <7voc90wx36.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (SOC 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162947>

On Sat, 4 Dec 2010, Junio C Hamano wrote:
> * aa/status-hilite-branch (2010-11-18) 1 commit
> - status: show branchname with a configurable color
>
> I am indifferent/uninterested; I don't see anything wrong with it, but I
> do not find coloring the field particularly useful myself.

The idea for this patch came from my daywork, where I have lately been 
trying to teach new users effective use of Git. We promote heavy usage of 
"git status" for new users in order for them to understand what all the 
basic commands do. A great amount of users fail to notice in which branch 
they are even when looking at the status message. I think this small tweak 
could help at least some of such new users without causing considerable 
harm for more advanced users.

And as Jeff pointed out, this is already the default beharivour in vim for 
commit messages. I have always found it quite reasonable.

:Aga
