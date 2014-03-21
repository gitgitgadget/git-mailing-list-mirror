From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC 2014]idea:Git Configuration API Improvement
Date: Fri, 21 Mar 2014 14:42:42 +0100
Message-ID: <vpqfvmb3bxp.fsf@anie.imag.fr>
References: <vpqd2hh5j7k.fsf@anie.imag.fr>
	<1395350103-4899-1-git-send-email-zhaox383@umn.edu>
	<vpqob10dko5.fsf@anie.imag.fr>
	<CAP4BmmHAuWYgeMvk11ywJ5eXQunCWPepGEE3UTKfiVn60RQVrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQzip-0000FY-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 14:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbaCUNmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2014 09:42:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35240 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbaCUNms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 09:42:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2LDgfuk028134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Mar 2014 14:42:41 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2LDggXt004379;
	Fri, 21 Mar 2014 14:42:42 +0100
In-Reply-To: <CAP4BmmHAuWYgeMvk11ywJ5eXQunCWPepGEE3UTKfiVn60RQVrw@mail.gmail.com>
	(Mustafa Orkun Acar's message of "Fri, 21 Mar 2014 15:39:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 21 Mar 2014 14:42:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2LDgfuk028134
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396014165.08825@4ZUX3dbyXINuDVeBLbBCwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244688>

Mustafa Orkun Acar <mustafaorkunacar@gmail.com> writes:

> Hi,=A0
> I have completed my proposal about this project. But in one of the pr=
evious emails; it says that the aim of the project is not storing confi=
guration data in the memory instead of making multiple git_config() cal=
ls. I
> also understand the project in this way. I need a clarification about=
 it. Thanks.

See my explanations at the bottom of

http://article.gmane.org/gmane.comp.version-control.git/244522

The goal _is_ to keep the configuration in memory, inside a single git
process. Not to maintain it in memory when the process dies (this would
require an additional daemon, which would be really overkill in our
case).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
