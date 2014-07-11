From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 1/2] add `config_set` API for caching config-like files
Date: Fri, 11 Jul 2014 18:59:21 +0200
Message-ID: <vpqwqbjvnkm.fsf@anie.imag.fr>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
	<1405049655-4265-2-git-send-email-tanayabh@gmail.com>
	<vpqlhs02cz7.fsf@anie.imag.fr> <53C0116D.3010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eB6-0002wq-Io
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbaGKRAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:00:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51270 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbaGKQ77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 12:59:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6BGxKN7006610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2014 18:59:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6BGxLJV025773;
	Fri, 11 Jul 2014 18:59:21 +0200
In-Reply-To: <53C0116D.3010404@gmail.com> (Tanay Abhra's message of "Fri, 11
	Jul 2014 22:01:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Jul 2014 18:59:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6BGxKN7006610
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405702764.48781@pLuDWJPBCjZXshINJrA/tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253293>

Tanay Abhra <tanayabh@gmail.com> writes:

> I had seen that there were checks for Syntax error or Non-existant files in
> t1300-repo-config, for example,

The code raising the syntax error is there, and tested. But the way the
error code (eg. return -1 from git_config) is handled by your code is
not.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
