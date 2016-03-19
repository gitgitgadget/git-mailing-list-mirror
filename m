From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHV2 0/2] Decouple rebase --exec from --interactive
Date: Sat, 19 Mar 2016 11:43:17 +0100
Message-ID: <vpqbn6an3y2.fsf@anie.imag.fr>
References: <1458251060-311-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, johannes.schindelin@gmail.com,
	gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 11:43:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahELy-00059C-Mx
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 11:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbcCSKn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 06:43:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46164 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbcCSKnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 06:43:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2JAhGQS019138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 19 Mar 2016 11:43:16 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2JAhHpV031049;
	Sat, 19 Mar 2016 11:43:17 +0100
In-Reply-To: <1458251060-311-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 17 Mar 2016 14:44:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sat, 19 Mar 2016 11:43:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2JAhGQS019138
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1458988997.90516@NkdsoWXEyFFsfxlUdB7omQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289301>

Stefan Beller <sbeller@google.com> writes:

>> What happens if the user asks --exec --preserve-merges?
>
> We're fine. When parsing `--preserve-merges`:
> 	--preserve-merges)
> 		preserve_merges=t
> 		test -z "$interactive_rebase" && interactive_rebase=implied

Perfect, thanks for checking (which I couldn't do myself from a phone).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
