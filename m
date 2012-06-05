From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 13:29:55 +0200
Message-ID: <vpq4nqqj8ss.fsf@bauges.imag.fr>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
	<7vhauqsue3.fsf@alter.siamese.dyndns.org>
	<CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
	<7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
	<vpqpq9ejnxs.fsf@bauges.imag.fr>
	<CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
	<20120605075614.GE25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbrxp-0006Dq-0q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 13:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933945Ab2FELaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 07:30:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50224 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933944Ab2FELaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 07:30:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55BLLMB023844
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 13:21:21 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbrxU-0007Sf-L2; Tue, 05 Jun 2012 13:29:56 +0200
In-Reply-To: <20120605075614.GE25809@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 5 Jun 2012 03:56:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 13:21:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55BLLMB023844
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339500084.73241@EYz5eLXYe61O7CfwWypcFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199231>

Jeff King <peff@peff.net> writes:

> Subject: t1304: improve setfacl prerequisite setup

> +test_expect_success 'checking for a working acl setup' '
> +	if setfacl -m u:root:rwx . &&
> +	   getfacl . | grep user:root:rwx
> +	then
> +		test_set_prereq SETFACL
> +	fi
> +'

Excellent. Thanks.

Tested-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
