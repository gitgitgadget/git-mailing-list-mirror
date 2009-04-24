From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: Manual pages (from archive): no hyphenation
Date: Fri, 24 Apr 2009 14:35:01 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49F1CE18.15665.63CB41A@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49F1BD06.32347.5FA078F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49F1A44A.1080008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 14:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxKeX-0000gs-Mn
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 14:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbZDXMfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 08:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbZDXMfj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 08:35:39 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:29829 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752934AbZDXMfi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 08:35:38 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id EA067C56C4;
	Fri, 24 Apr 2009 14:35:41 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 45899C56AA;
	Fri, 24 Apr 2009 14:35:40 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3OCZUlK010559;
	Fri, 24 Apr 2009 14:35:30 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    24 Apr 09 14:35:27 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 24 Apr 09 14:35:10 +0100
In-reply-to: <49F1A44A.1080008@drmicha.warpmail.net>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=590375@20090424.122231Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117431>

On 24 Apr 2009 at 13:36, Michael J Gruber wrote:

> Ulrich Windl venit, vidit, dixit 24.04.2009 13:22:
> > Hello!
> > 
> > When using the manual pages that are shipped as archive, I noticed that some of 
> > them look a bit ugly, mostly because of the lack of hyphenation. If that wasn't 
> > intentional, could the proper commandy be added to the manual pages?
> 
> Do you mean line wrap by any chance ("Zeilenumbruch")? None of the
> manual pages use hyphenation ("Silbentrennung").

Hi,

no, I meant what I write. Here "man bash" shows (the hypenation character is odd 
somehow):
-----snip---
DESCRIPTION
       Bash  is  an  sh-compatible  command language interpreter that executes
       commands read from the standard input or from a file.  Bash also incor-
       porates useful features from the Korn and C shells (ksh and csh).
-------snip------

So "incor-porates" is hyphenated, right. Maybe it's a default if groff somewhere.

> 
> > 
> > Also I've noticed that a signle quote is displayed (on my UTF-8 system) as "Z with 
> > an inverted roof" (i.e. a 'Z' with a vertically mirrored circumflex on top). That 
> > slooks somewhat strange.
> 
> Which "archive" do you use? Where do you see the quote (if your system
> displays a cech z)?

I don't have access to it right now, but I got it for git-1.6 from kernel.org 
about two weeks ago. I also cannot tell you where I saw that character, but it 
occurred many times; otherwise I wouldn't care.

> 
> > 
> > Furthermose  In oticed that there is no manual page for git-status in the archive.
> 
> Which...

The same as the one above ;-)

Regards,
Ulrich
