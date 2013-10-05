From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Sat, 05 Oct 2013 22:35:13 +0200
Message-ID: <vpqfvsfbgn2.fsf@anie.imag.fr>
References: <201309282137.21802.tboegi@web.de>
	<CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
	<524C6885.8020602@web.de>
	<CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com>
	<20131003013127.GA7917@sigill.intra.peff.net>
	<52506D15.9040206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 05 22:35:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSYZj-0007Rx-AZ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Oct 2013 22:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab3JEUf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Oct 2013 16:35:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59992 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab3JEUf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Oct 2013 16:35:26 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r95KZBGH023732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 Oct 2013 22:35:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r95KZDam020627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 5 Oct 2013 22:35:13 +0200
In-Reply-To: <52506D15.9040206@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Sat, 05 Oct 2013 21:48:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 05 Oct 2013 22:35:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r95KZBGH023732
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1381610113.59045@hQ7QnQ4JveGEoKi3WS/JnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235729>

Torsten B=F6gershausen <tboegi@web.de> writes:

>  test_expect_success 'cloning myhost:src uses ssh' '
>         clear_ssh &&
> -       git clone myhost:src ssh-clone &&
> +       ! git clone myhost:src ssh-clone &&

This succeeds if Git segfaults for example. Please, use test_must_fail
instead of "!".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
