From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 05/11] ref-filter: add parse_opt_merge_filter()
Date: Thu, 02 Jul 2015 19:06:22 +0200
Message-ID: <vpq7fqi8p69.fsf@anie.imag.fr>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
	<1435850470-5175-1-git-send-email-karthik.188@gmail.com>
	<1435850470-5175-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:06:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAhwU-000329-Ff
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbbGBRG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:06:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50658 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbbGBRGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:06:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t62H6Kj2020485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 19:06:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t62H6MN1013157;
	Thu, 2 Jul 2015 19:06:22 +0200
In-Reply-To: <1435850470-5175-5-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 2 Jul 2015 20:51:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Jul 2015 19:06:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t62H6Kj2020485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436461580.68423@WrTkF8mMsf3H7LqnhG1LCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273248>

Karthik Nayak <karthik.188@gmail.com> writes:

> +/*  Macros for checking --merged and --no-merged options */
> +#define _OPT_MERGED_NO_MERGED(option, filter, h)				\

Detail: there's a weird large space before \. Is it an attempt to align
the \ with a non-standard tab-width?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
