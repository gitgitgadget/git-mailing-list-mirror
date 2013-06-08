From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 14/22] git-remote-mediawiki: Check return value of open + remove import of unused open2
Date: Sat, 08 Jun 2013 20:41:52 +0200
Message-ID: <vpqd2rwv40f.fsf@anie.imag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com>
	<51B353A7.1090206@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 20:42:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlO5Y-00054s-C1
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 20:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab3FHSmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 14:42:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43682 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab3FHSmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 14:42:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r58Ifpjk012487
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 20:41:51 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlO5J-0001U6-8z; Sat, 08 Jun 2013 20:41:53 +0200
In-Reply-To: <51B353A7.1090206@ensimag.fr> (=?iso-8859-1?Q?=22C=E9lestin?=
 Matte"'s message of
	"Sat, 08 Jun 2013 17:54:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 20:41:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58Ifpjk012487
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371321715.90223@HljGrts+66ZlR6zJ2Lo2wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226855>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> Le 08/06/2013 02:14, Eric Sunshine a =E9crit :
>> These two changes are unrelated and could be split into distinct
>> patches (IMHO, though others may disagree).
>
> Two distinct patches or two distinct commits?

That's the same. You write commits locally, send them as patches, and
Junio uses "git am" to turn the patches back into commits.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
