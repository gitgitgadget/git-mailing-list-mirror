From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] diff-no-index.c read_directory() use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 16:21:18 +0100
Message-ID: <vpqfvmefc41.fsf@anie.imag.fr>
References: <1395242180-4559-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 16:21:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQIJ6-0005J7-UH
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbaCSPVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:21:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55464 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965001AbaCSPVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 11:21:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2JFLG8Q006609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2014 16:21:16 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2JFLILs003239;
	Wed, 19 Mar 2014 16:21:18 +0100
In-Reply-To: <1395242180-4559-1-git-send-email-mandrei.dinu@gmail.com> (Andrei
	Dinu's message of "Wed, 19 Mar 2014 17:16:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Mar 2014 16:21:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2JFLG8Q006609
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395847279.27639@u/7dqr2dzujEGGfRJtak2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244453>

> Subject: Re: [PATCH 1/3]
                      ^^^
I guess you meant PATCH v3. 1/3 means that this is the first patch out
of 3.

Andrei Dinu <mandrei.dinu@gmail.com> writes:

> Implement read_directory() to use is_dot_or_dotdot() function from dir.h
> instead of strcmp().
>
> Rename read_directory() in read_directory_path() to avoid conflicting with
> read_directory() from dir.h.

Ideally, these should be two distinct patches. One to rename
read_directory (no real change), and the next one to use
is_dot_or_dotdot.

You may want to take this as an exercice to learn how to split a patch,
but I won't insist on that.

Other than that, the patch looks good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
