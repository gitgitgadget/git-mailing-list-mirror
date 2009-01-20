From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 18:10:03 +0100
Message-ID: <vpq4oztgaz8.fsf@bauges.imag.fr>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	<3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
	<c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
	<200901200912.14432.brian.foster@innova-card.com>
	<c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Brian Foster" <brian.foster@innova-card.com>,
	"Reece Dunn" <msclrhd@googlemail.com>,
	"git list" <git@vger.kernel.org>
To: "Dilip M" <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKDs-0006Xg-O9
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbZATRPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 12:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbZATRPn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:15:43 -0500
Received: from imag.imag.fr ([129.88.30.1]:62164 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757297AbZATRPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:15:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n0KHA57c021820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 20 Jan 2009 18:10:05 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LPK72-0006ex-0Y; Tue, 20 Jan 2009 18:10:04 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LPK71-0004sH-Ua; Tue, 20 Jan 2009 18:10:03 +0100
In-Reply-To: <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com> (Dilip M.'s message of "Tue\, 20 Jan 2009 22\:21\:09 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 20 Jan 2009 18:10:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106498>

"Dilip M" <dilipm79@gmail.com> writes:

>>  repeating Reece's question, what is the permissions/owner
>>  _of_the_directory_which_contains_ the '.git/' directory?
>>  I can reproduce this behaviour (git 1.6.0.4) simply by
>>  denying myself search (n=E9e execute) permission on that
>>  directory, for entirely obvious reasons.
>
> It's the same issue....

You didn't answer the question.

> Any ENV variable I can set to debug this...?

GIT_TRACE can help.

--=20
Matthieu
