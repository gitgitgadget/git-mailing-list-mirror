From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3 2/2] Warnings before amending published history
Date: Tue, 12 Jun 2012 09:34:18 +0200
Message-ID: <vpqvcixyoed.fsf@bauges.imag.fr>
References: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339451781-29324-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 09:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeLcV-0006fJ-FN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 09:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab2FLHeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 03:34:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42666 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab2FLHeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 03:34:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5C7POXU013629
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 09:25:24 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeLcJ-0003FH-Ns; Tue, 12 Jun 2012 09:34:19 +0200
In-Reply-To: <1339451781-29324-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Lucien Kong's message of "Mon, 11 Jun 2012 23:56:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 09:25:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5C7POXU013629
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340090724.80703@fV7gA/SgfIgqAdspXO93NA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199767>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

>  builtin/commit.c              |   82 ++++++++++++++++++++++++++
>  sha1_name.c                   |   95 +++++++-----------------------
>  sha1_name.h                   |  130 +++++++++++++++++++++++++++++++++++++++++

I'm surprised that you need such a big patch. Basically, you're making
all static functions in sha1_name.c public. If you really need such
intrusive change, then you should at least explain why in the commit
message, and most preferably split the patch into one refactoring patch
to expose the functions and one to use them.

But I suspect what you're looking for is already in cache.h.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
