From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git_config_set(?) adding and removing creates extraneous lines
Date: Fri, 12 Jun 2015 07:49:35 +0200
Message-ID: <vpqwpz9jx1s.fsf@anie.imag.fr>
References: <26A24781-3981-44B6-8174-09532D93774C@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Tanay Abhra <tanayabh@gmail.com>
To: Anish R Athalye <aathalye@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 12 07:49:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Hqf-0003vW-5P
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 07:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbbFLFto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 01:49:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44358 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbFLFto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 01:49:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5C5nZFg029203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Jun 2015 07:49:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5C5nZXA023680;
	Fri, 12 Jun 2015 07:49:35 +0200
In-Reply-To: <26A24781-3981-44B6-8174-09532D93774C@mit.edu> (Anish R.
	Athalye's message of "Fri, 12 Jun 2015 04:59:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 12 Jun 2015 07:49:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5C5nZFg029203
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434692978.9845@CRaiLD7N60ZMuKtpNneXHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271471>

Anish R Athalye <aathalye@mit.edu> writes:

> Now, when running `tail -n 3 .git/config`, you see:
>
>     [branch "master"]
>     [branch "master"]
>             description = asdf\n

Yes, this is a known bug that no one fixed yet. It was planned for
Tanay's (Cc-ed) GSoC last year, but the project evolved in another
direction.

> Is this something that we want to fix?

Patches welcome ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
