From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/4] list-object: add get_commit_count function
Date: Fri, 03 Jul 2015 10:59:12 +0200
Message-ID: <vpq7fqh4nxb.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-2-git-send-email-lawrencesiebert@gmail.com>
	<vpqlhex66v6.fsf@anie.imag.fr>
	<CAKDoJU6DdSc2ux5vEJu2risW9a-cgJ7e5xBxysTFdYGMd+77Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 10:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAwp4-0005mo-Po
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 10:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbbGCI7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 04:59:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52439 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbbGCI7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 04:59:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t638xBOY008234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 10:59:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t638xCZK025053;
	Fri, 3 Jul 2015 10:59:12 +0200
In-Reply-To: <CAKDoJU6DdSc2ux5vEJu2risW9a-cgJ7e5xBxysTFdYGMd+77Kw@mail.gmail.com>
	(Lawrence Siebert's message of "Fri, 3 Jul 2015 01:09:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Jul 2015 10:59:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t638xBOY008234
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436518752.47441@av3EqdJDXmsFe6gf+u2rpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273287>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> Mattieu,
>
> Understood. I don't suppose there is any commonly code formatting tool
> to automate formatting in the git style, is there?

IIRC, someone posted a configuration file for clang-format that
essentially matches the Git coding style.

You can read Documentation/CodingGuidelines. Unsurprisingly, Git uses a
coding style similar to the Linux kernel, so anything you find about the
kernel essentially applies here too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
