From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Fri, 25 May 2012 21:29:51 +0200
Message-ID: <vpqvcjknjo0.fsf@bauges.imag.fr>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
	<CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
	<7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
	<20120525182558.GC4491@burratino>
	<7vsjeortwu.fsf@alter.siamese.dyndns.org>
	<20120525184408.GA4740@burratino>
	<7vobpcrstn.fsf@alter.siamese.dyndns.org>
	<20120525191701.GA4944@burratino>
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
X-From: git-owner@vger.kernel.org Fri May 25 21:30:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0Di-0000WB-3H
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153Ab2EYTai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:30:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54840 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553Ab2EYTah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:30:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4PJLnVt006221
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 21:21:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SY0Cv-0005rt-08; Fri, 25 May 2012 21:29:53 +0200
In-Reply-To: <20120525191701.GA4944@burratino> (Jonathan Nieder's message of
	"Fri, 25 May 2012 14:17:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 May 2012 21:21:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PJLnVt006221
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338578515.46671@kN9dJR9Ig9eraDc59Ap/aw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198512>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I am guessing
> that putting all user git configuration in one directory is part of
> the goal, and separating temporary files like ~/.fontconfig/*.cache*
> from configuration files like ~/.mutt/muttrc is another part.

That's another good thing with XDG (~/.config Vs ~/.cache/ for example),
but I don't think Git would have anything user-wide that would not be
configuration.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
