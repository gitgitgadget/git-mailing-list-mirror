From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Mon, 13 Apr 2015 23:43:56 +0200
Message-ID: <vpqwq1fn1pf.fsf@anie.imag.fr>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 23:44:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhm9F-0006Lh-HM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 23:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbbDMVoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 17:44:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51248 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbbDMVoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 17:44:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3DLhrdt004464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Apr 2015 23:43:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3DLhuBl028500;
	Mon, 13 Apr 2015 23:43:56 +0200
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Sun, 12 Apr 2015 15:46:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 13 Apr 2015 23:43:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3DLhrdt004464
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429566234.44683@RpuUdAMJpV+52/ZSvYbsww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267101>

Paul Tan <pyokagan@gmail.com> writes:

> As such, implement a simpler function xdg_config_home() for constructing
> the XDG base dir spec configuration file path. This function, together
> with expand_user_path(), can replace all uses of home_config_paths().

Indeed. The code looks much better after your patch series than before.

I agree with Dscho's remark that "fn" sounds like "function" more than
"filename". Perhaps just "name" would be better.

Anyway, the series is

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
