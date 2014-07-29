From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] GSoC status update (config API improvements)
Date: Tue, 29 Jul 2014 15:11:21 +0200
Message-ID: <vpq7g2w71ja.fsf@anie.imag.fr>
References: <53D79A6A.2090302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7Br-0004UN-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbaG2NLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 09:11:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38968 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaG2NLf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:11:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6TDBKxp008030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2014 15:11:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6TDBLxI029483;
	Tue, 29 Jul 2014 15:11:21 +0200
In-Reply-To: <53D79A6A.2090302@gmail.com> (Tanay Abhra's message of "Tue, 29
	Jul 2014 18:28:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Jul 2014 15:11:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6TDBKxp008030
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407244281.41054@OwNTBmZWMg8MNiJaPjsbIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254431>

Tanay Abhra <tanayabh@gmail.com> writes:

> a> Unsetting previously set values
> Local config files can be used to unset config values previously set in system
> files. The user may not have the privilege to touch the system files so he can
> leverage the new API to unset the previously set values.

I had totally forgotten about this, but this was the initial motivation
to write a config cache, so it would be a good conclusion for your
project.

Thanks to the patches you already wrote, the feature went from
"impossible to implement given the design" to "fairly straightforward to
implement" :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
