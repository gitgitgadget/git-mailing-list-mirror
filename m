From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Wed, 19 Aug 2015 17:18:13 +0200
Message-ID: <vpqpp2j2toq.fsf@anie.imag.fr>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
	<1439925345-9969-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:18:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS58L-0005wD-M2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbbHSPSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:18:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50948 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbbHSPSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:18:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7JFIBb3011641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 17:18:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JFID3c020956;
	Wed, 19 Aug 2015 17:18:13 +0200
In-Reply-To: <1439925345-9969-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Wed, 19 Aug 2015 00:45:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Aug 2015 17:18:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JFIBb3011641
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440602293.506@bXMuvjUwvw4kB1jMjKeMMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276183>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	/*
> +	 * First we obtain all regular branch refs and if the HEAD is
> +	 * detached then we insert that ref to the end of the ref_fist
> +	 * so that it can be printed first.
> +	 */

Nit: the end of the sentence reads funny (why put at the end "so that it
can be printed first.").

Perhaps "... so that it can be printed and removed first.".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
