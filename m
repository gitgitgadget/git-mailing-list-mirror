From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 2/2] t7512-status-warnings.sh: better advices for git status
Date: Mon, 28 May 2012 10:43:31 +0200
Message-ID: <vpqaa0shf0s.fsf@bauges.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon May 28 10:43:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYvYD-0007bM-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 10:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab2E1Inf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 04:43:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48456 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab2E1Ine (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 04:43:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4S8ZLvA002659
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2012 10:35:21 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYvY4-0007Vn-4O; Mon, 28 May 2012 10:43:32 +0200
In-Reply-To: <1338035905-24166-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Sat, 26 May 2012 14:38:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 May 2012 10:35:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4S8ZLvA002659
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338798921.30321@/azHlWufSqwVlZgGESbVXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198636>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +test_expect_success 'status when conflicts unresolved' '
> +	git init --shared --bare conflict_test.git &&
> +	git clone conflict_test.git test1 &&
> +	git clone conflict_test.git test2 &&

I already asked off-list, but why do you need 3 repositories here.
Wouldn't it be simpler to have 2 branches and test conflicts with
"git merge"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
