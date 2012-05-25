From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Fri, 25 May 2012 21:01:33 +0200
Message-ID: <vpqipfkozjm.fsf@bauges.imag.fr>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
	<CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
	<7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
	<20120525182558.GC4491@burratino>
	<7vsjeortwu.fsf@alter.siamese.dyndns.org>
	<20120525184408.GA4740@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 21:03:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXznC-0001tD-8U
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201Ab2EYTDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:03:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53267 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085Ab2EYTDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:03:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4PIrVXa032013
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 20:53:31 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXzlW-0005ck-IC; Fri, 25 May 2012 21:01:34 +0200
In-Reply-To: <20120525184408.GA4740@burratino> (Jonathan Nieder's message of
	"Fri, 25 May 2012 13:44:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 May 2012 20:53:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PIrVXa032013
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338576812.77326@/EYF4XTilPhLnrwegwCtEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198508>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> If I understand correctly, the proposal that started this thread was
>>> to give people a chance to tidy their HOME directory by moving
>>> personal git configuration under ~/.config/git/.  
>>
>> So it is exactly "I do not want ~/.gitconfig, I want ~/.config/git", no?
>>
>> That is something distro should be able to decide.
>
> Except that there is nothing distro-specific about it.  Do you really
> want the config file to have a different name depending on whether one
> is using Debian, Fedora, Mac OS X, Gentoo, one of the various builds of
> git on Windows, Solaris, ...?

I agree. Please don't encourage distro to make incompatible
configuration changes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
