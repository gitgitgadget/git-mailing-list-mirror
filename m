From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 10/11] ref-filter: implement '--contains' option
Date: Thu, 02 Jul 2015 19:12:23 +0200
Message-ID: <vpqr3oq7abs.fsf@anie.imag.fr>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
	<1435850470-5175-1-git-send-email-karthik.188@gmail.com>
	<1435850470-5175-10-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:12:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAi2O-000670-Cz
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbbGBRMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:12:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38214 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbbGBRMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:12:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t62HCLQa030597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 19:12:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t62HCN7D013249;
	Thu, 2 Jul 2015 19:12:23 +0200
In-Reply-To: <1435850470-5175-10-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 2 Jul 2015 20:51:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 Jul 2015 19:12:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t62HCLQa030597
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436461944.28015@dGcPcbbqm9xypSRizPZd4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273250>

Karthik Nayak <karthik.188@gmail.com> writes:

> 'tag -l' and 'branch -l' have two different ways of finding
> out if a certain ref contains a commit. Implement both these
> methods in ref-filter and give the caller of ref-filter API
> the option to pick which implementation to be used.

You are reusing some code, but unlike the other patches you are not
marking the old code as duplicated. The "duplicate code" comment both
acts as a reminder for later, and as an indication for reviewers of
where the code comes from.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
