From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Question about removing changes from the index
Date: Fri, 06 Feb 2009 15:11:19 +0100
Message-ID: <vpqprhvbqpk.fsf@bauges.imag.fr>
References: <a1e915350902060557m5a67eba0q819c2ba2a0a49c21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gustav =?iso-8859-1?Q?H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRVh-0000NP-2o
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbZBFOPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 09:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbZBFOPW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:15:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:43564 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbZBFOPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:15:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n16EBK8P001530
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Feb 2009 15:11:20 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LVRQN-000060-Ld; Fri, 06 Feb 2009 15:11:19 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LVRQN-0003wM-JQ; Fri, 06 Feb 2009 15:11:19 +0100
In-Reply-To: <a1e915350902060557m5a67eba0q819c2ba2a0a49c21@mail.gmail.com>
 ("Gustav =?iso-8859-1?Q?H=E5llberg=22's?= message of "Fri\, 6 Feb 2009
 14\:57\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 06 Feb 2009 15:11:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108714>

Gustav H=E5llberg <gustav@gmail.com> writes:

> I'm wondering if there's anyone who can recommend a smart way to
> "reset" the index entry for individual files to the contents of HEAD,
> in effect, removing any previous change between HEAD and the index
> (for those files).

Isn't "git reset -- path" what you want? Or perhaps "git checkout HEAD
-- path" if you also want to reset the file content.

--=20
Matthieu
