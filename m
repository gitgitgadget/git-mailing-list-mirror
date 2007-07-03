From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 03 Jul 2007 15:40:12 +0200
Message-ID: <vpqir91hagz.fsf@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<vpq7ipittl2.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707022205210.4071@racer.site>
	<vpqoditkc23.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707031308170.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 15:40:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5icT-00031R-3C
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 15:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbXGCNkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 09:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbXGCNki
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 09:40:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:44038 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660AbXGCNki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 09:40:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l63DeDsP011369
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 15:40:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I5ic0-0007ki-SE; Tue, 03 Jul 2007 15:40:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I5ic0-00037O-Pe; Tue, 03 Jul 2007 15:40:12 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0707031308170.4071@racer.site> (Johannes Schindelin's message of "Tue\, 3 Jul 2007 13\:09\:59 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 03 Jul 2007 15:40:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51492>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 3 Jul 2007, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > What's so wrong with our man pages? You know, there have been man 
>> > hours invested in them, and they are exclusively meant for consumption 
>> > by people who do not know about the usage of the commands...
>> 
>> What's wrong is just that I shouldn't have to read a man page to avoid
>> data-loss.
>
> Okay, Mr Moy.

Glad to be called by my name. Is it a tradition here, or a way to make
fun of me?

> How did you learn that "rm" leads to data-loss? Because it does.

It obviously does, and I can't imagine any other behavior than
deleting the file for a command like "rm".

> Hmm. How did you expect then, that git-rm does _not_ lead to data
> loss? 

Because there are tons of possible behaviors for "$VCS rm", and I'd
expect it to be safe even if VCS=git, since it is with all the other
VCS I know.

What's wrong with the behavior of "hg rm"?
What's wrong with the behavior of "svn rm"?
What's wrong with the behavior of "bzr rm"?
(no, I won't do it with CVS ;-) )

None of these commands have the problem that git-rm has.

-- 
Matthieu
