From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Fri, 04 Dec 2009 07:39:59 +0100
Message-ID: <vpq638ntf7k.fsf@bauges.imag.fr>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
	<4B17ABE3.6060003@drmicha.warpmail.net> <m2d42w5fqq.fsf@igel.home>
	<4B17D078.6080000@drmicha.warpmail.net>
	<20091203150323.GI23717@inocybe.localdomain>
	<7viqco54xh.fsf@alter.siamese.dyndns.org>
	<20091203202738.GP23717@inocybe.localdomain>
	<7vfx7r4we7.fsf@alter.siamese.dyndns.org>
	<20091203220020.GS23717@inocybe.localdomain>
	<7vbpif4rn2.fsf@alter.siamese.dyndns.org>
	<76c5b8580912031949k7f4193f9q94f9a2040b877571@mail.gmail.com>
	<7vocmfxnxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, Todd Zullinger <tmz@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 07:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGRq4-0005S7-NY
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 07:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZLDGkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 01:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZLDGkM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 01:40:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35449 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbZLDGkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 01:40:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nB46bpgE010333
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 07:37:51 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NGRpg-0000nX-Vd; Fri, 04 Dec 2009 07:40:01 +0100
In-Reply-To: <7vocmfxnxh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 03 Dec 2009 22\:18\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 04 Dec 2009 07:37:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB46bpgE010333
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260513472.12641@PseeA1T3W/Dvxbeh4c+vHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134493>

Junio C Hamano <gitster@pobox.com> writes:

> Eugene Sajine <euguess@gmail.com> writes:
>
>> We have RH with xmlto 0.0.18. I was getting ready to update our
>> installation to 1.6.5.4, but as i understand the documentation will
>> not be fully available untill this issue is resolved. Could you,
>> please, advise if this is going to be in next 1.6.5.5?
>
> I've applied the patch in the thread you are responding to already on
> 'maint' so it will appear in both 1.6.5.5 and 1.6.6.  In the meantime, if
> you want to run 1.6.5.4 or preferably 1.6.6-rc1, you can locally revert
> 8dd35c7 (Unconditionally set man.base.url.for.relative.links,
> 2009-12-03).

Also, one can download the man pages from git.git :

# in a clone of git://git.kernel.org/pub/scm/git/git.git
git archive --format=tar origin/man | tar -x -C /usr/share/man/ -vf -

(or leave with 1.6.5.5 and the docs of 1.6.5.4 for some time)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
