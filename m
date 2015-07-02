From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 04/11] for-each-ref: add '--points-at' option
Date: Thu, 02 Jul 2015 19:05:11 +0200
Message-ID: <vpqegkq8p88.fsf@anie.imag.fr>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
	<1435850470-5175-1-git-send-email-karthik.188@gmail.com>
	<1435850470-5175-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAhvQ-0002Tb-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbbGBRFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:05:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38051 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbbGBRFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:05:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t62H597K028872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 19:05:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t62H5Bjo013139;
	Thu, 2 Jul 2015 19:05:11 +0200
In-Reply-To: <1435850470-5175-4-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 2 Jul 2015 20:51:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 Jul 2015 19:05:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t62H597K028872
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436461513.24252@aE8PqgznpfvnISV+OEW0wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273246>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add the '--points-at' option provided by 'ref-filter'. The
> option lets the user to list only refs which pertain to the
> given object.

You are using "pertain to" (here, in git-for-each-ref.txt and in the
docstring), while the common use it to talk about "point to" or "point
at". I find "point" clearer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
