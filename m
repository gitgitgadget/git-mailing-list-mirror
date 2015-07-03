From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/4] list-object: add get_commit_count function
Date: Fri, 03 Jul 2015 09:24:45 +0200
Message-ID: <vpqlhex66v6.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-2-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	gitster@pobox.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 09:25:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAvLG-0006rK-4T
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 09:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbbGCHYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 03:24:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49948 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561AbbGCHYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 03:24:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t637OiD8019967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 09:24:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t637OjlW022580;
	Fri, 3 Jul 2015 09:24:45 +0200
In-Reply-To: <1435881011-13879-2-git-send-email-lawrencesiebert@gmail.com>
	(Lawrence Siebert's message of "Thu, 2 Jul 2015 16:50:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Jul 2015 09:24:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t637OiD8019967
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436513086.29123@hP/AsBy4ytYL/Fk6AUcwog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273281>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> +void get_commit_count(struct rev_info * revs) {

Please, write "struct rev_info *revs" (stick * to revs).

> +void get_commit_count(struct rev_info * revs);

Likewise.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
