From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to combine git repos with similar code and keep all branches and tags?
Date: Tue, 14 Apr 2015 19:09:17 +0200
Message-ID: <vpqr3rm8wn6.fsf@anie.imag.fr>
References: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jose de Leon <jdeleon@ensim.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4L4-0007rW-PX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbbDNRJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 13:09:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43727 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722AbbDNRJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 13:09:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3EH9FP0029885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 19:09:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EH9HRW020800;
	Tue, 14 Apr 2015 19:09:17 +0200
In-Reply-To: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
	(Jose de Leon's message of "Tue, 14 Apr 2015 16:44:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 14 Apr 2015 19:09:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3EH9FP0029885
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429636156.93774@JwbZnTXfAcvV0Aq1yfieUA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267148>

Jose de Leon <jdeleon@ensim.com> writes:

> For some unknown reason to me, our developers started a git project,
> called Ver1, this was the first version. Then sometime later, they
> created a new git repository called Ver2, the initial commit for Ver2
> was essentially a copy of the code in Ver1 from the master. They
> didn't clone it, they just copied the code at the latest point.

This is why "graft points" were created, and then superseeded by "git
replace".

See http://git-scm.com/blog/2010/03/17/replace.html and
http://git-scm.com/docs/git-replace

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
