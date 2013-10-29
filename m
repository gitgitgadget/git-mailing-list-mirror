From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Limiting disk usage
Date: Tue, 29 Oct 2013 09:21:21 +0100
Message-ID: <vpqob68ebcu.fsf@anie.imag.fr>
References: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 09:21:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb4YU-0007s4-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 09:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab3J2IVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 04:21:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57246 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab3J2IVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 04:21:30 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r9T8LORs003355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Oct 2013 09:21:24 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9T8LLkO001286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Oct 2013 09:21:25 +0100
In-Reply-To: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com> (Piotr
	Krukowiecki's message of "Tue, 29 Oct 2013 07:22:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Oct 2013 09:21:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9T8LORs003355
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1383639686.33485@2xKOXqJDnQuHIPcF7Ozyew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236911>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Hi, 
>
> What can be done to limit amount of space occupied on clone and
> checkout? I know about shallow clone and sparse checkout, anything
> else?

Sorry if I'm stating the obvious, but "git gc" is a good start. If you
did something wrong with your repo before, maybe "git gc --aggressive"
can help.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
