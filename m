From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] format-patch: add format.cover-letter configuration
Date: Sat, 06 Apr 2013 19:43:00 +0200
Message-ID: <vpq8v4vimhn.fsf@grenoble-inp.fr>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
	<1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0kMTt6wDv6sUVe9CbX-WSx=XH+PF6eQ6oXYFjcp_Yi+aQ@mail.gmail.com>
	<CAMP44s0Zzdb-1A0ej5Ly_501sv0OOOrHi86GWT9NYkndbiggeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOX9D-0008C9-UP
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab3DFRnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 13:43:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57070 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab3DFRnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:43:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r36Hgx4M030078
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 6 Apr 2013 19:42:59 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UOX8n-0001rm-7d; Sat, 06 Apr 2013 19:43:01 +0200
In-Reply-To: <CAMP44s0Zzdb-1A0ej5Ly_501sv0OOOrHi86GWT9NYkndbiggeg@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 6 Apr 2013 10:02:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 06 Apr 2013 19:43:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r36Hgx4M030078
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365874981.1019@ZsEBprm5qeCg9EboBil/wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220260>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Perhaps you can clarify this: Controls whether to generate a
>> cover-letter when format-patch is invoked.  Can be true, false, or
>> auto.  "auto" generates a cover-letter only when generating more than
>> one patch.
>
> That's good, but I believe if we say it's a boolean, true and false
> are implied, and then we have an extra "auto".

At the moment, we don't say it's Boolean. I'm not sure it's a good idea
to say Boolean here, since it would also imply that there's no value
other than true and false.

Also, you should mention the default value. Something like "Set to true
to always generate a cover letter. Defaults to false." or so.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
