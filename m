From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Mon, 04 Mar 2013 09:56:26 +0100
Message-ID: <vpqhakrtuf9.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu> <vpqfw0rb25c.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 04 09:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCRCl-00087r-UA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 09:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab3CDI4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 03:56:41 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36191 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab3CDI4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 03:56:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r248uQDC020056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Mar 2013 09:56:26 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UCRC6-000740-V8; Mon, 04 Mar 2013 09:56:27 +0100
In-Reply-To: <vpqfw0rb25c.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 20 Feb 2013 13:28:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Mar 2013 09:56:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r248uQDC020056
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362992189.44794@x0Xn/EBLLNRHvgL0WZkUyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217394>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> A few more random thoughts (not on my personal todo-list):

One more:

When sending commit emails, it may help to ensure that the dates are
strictly monotonic, so that the thread is seen in the right order.

IIRC, "git send-email" does this by tweaking the Date: field to make
sure there is at least one second between two emails (although they may
be actually sent at the same second). It would be cool to have the same
for git multimail.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
