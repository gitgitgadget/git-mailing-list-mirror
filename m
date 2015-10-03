From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Sat, 03 Oct 2015 14:02:58 +0200
Message-ID: <vpqoagg9n2l.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 14:03:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiLXA-00070o-Jq
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 14:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbbJCMDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 08:03:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53127 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbbJCMDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 08:03:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t93C2vZO005729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 3 Oct 2015 14:02:57 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t93C2wEC003271;
	Sat, 3 Oct 2015 14:02:58 +0200
In-Reply-To: <1443807546-5985-7-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:09:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 03 Oct 2015 14:02:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t93C2vZO005729
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444478582.2808@7qbwagHzem8UZYhXHLOG8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278968>

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce format_ref_array_item() which will output the details of a
> given ref_array_item as per the given format and quote_style to the
> given strbuf.

Why do you need it in this series and you could do without for tag?

Going through PATCH 8/9, I guess there's something related to --column,
but tag also has --column so I'm puzzled.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
