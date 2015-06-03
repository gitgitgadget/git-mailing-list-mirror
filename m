From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSoC] Week 1: Unification of 'for-each-ref', 'tag -l' and 'branch -l'
Date: Wed, 03 Jun 2015 18:08:50 +0200
Message-ID: <vpqh9qoepv1.fsf@anie.imag.fr>
References: <556DDC21.5050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:09:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0BE0-0002NK-QF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbbFCQJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:09:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59690 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbbFCQI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 12:08:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t53G8nCf031824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 18:08:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53G8oIT010008;
	Wed, 3 Jun 2015 18:08:50 +0200
In-Reply-To: <556DDC21.5050801@gmail.com> (Karthik Nayak's message of "Tue, 02
	Jun 2015 22:08:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Jun 2015 18:08:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53G8nCf031824
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433952534.24603@GAdsNu04TfOcUqZXvliuIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270692>

Karthik Nayak <karthik.188@gmail.com> writes:

> Matthieu Moy suggested that I work on the unification of these
> commands let both the implementations stay where the user can select
> the implementation to be used

Just to be clear: my advice is the above with "user" = "caller of the
API", not "human being using Git". In other words, "git branch
--contains" and "git tag --contains" would still be using two different
algorithms, but the user wouldn't notice (except for performance).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
