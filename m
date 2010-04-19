From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 15:14:49 +0200
Message-ID: <vpqsk6rmvna.fsf@bauges.imag.fr>
References: <201004180246.18263.jnareb@gmail.com>
	<20100418021223.GP10939@machine.or.cz>
	<n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	<20100418223120.GB3563@machine.or.cz>
	<u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
	<vpqeiicey0d.fsf@bauges.imag.fr>
	<7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
	<v2me72faaa81004190038y4aeefa80g9f60bb3b1e795e4b@mail.gmail.com>
	<20100419090734.GA10939@machine.or.cz>
	<vpq8w8j1vb7.fsf@bauges.imag.fr>
	<p2we72faaa81004190557t240823bcu63f95b0f8a885cbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 15:15:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3qow-0006Qx-7J
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 15:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab0DSNPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 09:15:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33593 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab0DSNPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 09:15:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o3JD9eMK012191
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Apr 2010 15:09:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O3qoL-0002pv-IN; Mon, 19 Apr 2010 15:14:49 +0200
In-Reply-To: <p2we72faaa81004190557t240823bcu63f95b0f8a885cbb@mail.gmail.com> (Pavan Kumar Sunkara's message of "Mon\, 19 Apr 2010 05\:57\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 19 Apr 2010 15:09:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3JD9eMK012191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1272287382.33469@gMurL83Off099D1DazR1vQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145296>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> All of us are supporting using GET parameters rather than sessions for
> project name and others which is fine for me as the reasons are valid.
> But I would like to develop sessions manager incase they want to use
> authentication support.
>
> What do you say ?

That doesn't seem contradictory. You can have login/password as
cookies or session variables, and other parameters within the URL.

Then, if I send you a URL pointing to a write-enabled page which
requires authentication, and you click it, you'll be prompted for your
login/password before you can proceed, but after that, you'll still be
redirected to the right page.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
