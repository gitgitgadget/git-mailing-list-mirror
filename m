From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv6 3/4] status: don't suggest "git rm" or "git add" if not appropriate
Date: Sun, 03 Jun 2012 21:34:46 +0200
Message-ID: <vpq396cxk89.fsf@bauges.imag.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338748217-16440-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 03 21:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbGZo-0006Zd-3U
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 21:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab2FCTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 15:34:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41568 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077Ab2FCTey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 15:34:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q53JQGds030217
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 21:26:17 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbGZb-0001ck-64; Sun, 03 Jun 2012 21:34:47 +0200
In-Reply-To: <1338748217-16440-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Sun, 3 Jun 2012 20:30:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jun 2012 21:26:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53JQGds030217
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339356381.66689@leVvi/Vlti3P6csWRfbDxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199096>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +test_expect_success 'status when conflicts with only rm advice (both deleted)' '
> +	test_when_finished "cd ../ && rm -rf git" &&

Is it intentional that you kept this potentially dangerous "cd ../ && rm
-rf git"? I saw you rewrote some instances in other patches, but not all
of them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
