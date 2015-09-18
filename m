From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Fri, 18 Sep 2015 17:44:51 +0200
Message-ID: <vpqmvwjivf0.fsf@anie.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
	<20150917213619.GI17201@serenity.lan>
	<xmqq37ycitps.fsf@gitster.mtv.corp.google.com>
	<vpqoah0kxtb.fsf@anie.imag.fr> <20150918084208.GJ17201@serenity.lan>
	<CAOLa=ZQmGD2vo1B2K21-f_2RZRXduFt4VNKq2Pp9B_5bO=8=+w@mail.gmail.com>
	<vpq8u83kb5d.fsf@anie.imag.fr>
	<CAOLa=ZRPwoNJv9kG7GfG4ZyjHAoPa7h2PDXErZbV1_B1_ipZ7g@mail.gmail.com>
	<vpqr3lviw38.fsf@anie.imag.fr>
	<CAOLa=ZQbrE9vuES=DwO0wArdt8F_LUdFdzxggEkHFz4BB=O1OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 17:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcxqt-0007Kp-PS
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbIRPpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:45:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50793 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101AbbIRPpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:45:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8IFinkH032571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 17:44:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IFipv2015774;
	Fri, 18 Sep 2015 17:44:51 +0200
In-Reply-To: <CAOLa=ZQbrE9vuES=DwO0wArdt8F_LUdFdzxggEkHFz4BB=O1OQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 18 Sep 2015 21:08:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Sep 2015 17:44:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IFinkH032571
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443195891.40815@jiyZWrGFxTrX3SCFf4WjVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278206>

Karthik Nayak <karthik.188@gmail.com> writes:

> About the issue at hand, we should probably squash this in

Looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
