From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v2 14/22] git-remote-mediawiki: Check return value of
 open + remove import of unused open2
Date: Sat, 08 Jun 2013 17:54:15 +0200
Message-ID: <51B353A7.1090206@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr> <1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr> <CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 17:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlLTG-0000YF-7M
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 17:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab3FHPyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 11:54:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56823 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab3FHPyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 11:54:21 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r58FsD81028730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 17:54:13 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r58FsFdN012299;
	Sat, 8 Jun 2013 17:54:15 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r58FsEja008482;
	Sat, 8 Jun 2013 17:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jun 2013 17:54:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58FsD81028730
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371311655.14444@NHSZXHnBqVZCaZFZrzRahg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226836>

Le 08/06/2013 02:14, Eric Sunshine a =E9crit :
> These two changes are unrelated and could be split into distinct
> patches (IMHO, though others may disagree).

Two distinct patches or two distinct commits?
I assumed it was two distinct commits, but thinking about it, removing =
a
library could have its own patch.

--=20
C=E9lestin Matte
