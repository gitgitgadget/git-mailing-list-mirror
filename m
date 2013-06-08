From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v2 16/22] git-remote-mediawiki: Modify strings for a better
 coding-style
Date: Sat, 08 Jun 2013 22:32:37 +0200
Message-ID: <51B394E5.8040104@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr> <1370641344-4253-17-git-send-email-celestin.matte@ensimag.fr> <CAPig+cT6Qw1w4x95oT7PctMz_HnpU0Vwv5Bh=n-uqZQWJjFnBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 22:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlPoc-0002r1-CP
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 22:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab3FHUcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 16:32:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45632 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab3FHUcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 16:32:42 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r58KWY3D000450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 22:32:34 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r58KWa3o018291;
	Sat, 8 Jun 2013 22:32:36 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r58KWZFS000786;
	Sat, 8 Jun 2013 22:32:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAPig+cT6Qw1w4x95oT7PctMz_HnpU0Vwv5Bh=n-uqZQWJjFnBw@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 22:32:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58KWY3D000450
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371328356.06189@pIA5i0XJUtD9pWH03rQxxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226861>

Le 08/06/2013 02:39, Eric Sunshine a =E9crit :
> On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
> <celestin.matte@ensimag.fr> wrote:
>> - strings which don't need interpolation are single-quoted for more =
clarity and
>> slight gain of performance
>> - interpolation is preferred over concatenation in many cases, for m=
ore clarity
>> - variables are always used with the ${} operator inside strings
>> - strings including double-quotes are written with qq() so that the =
quotes do
>> not have to be escaped
>=20
> Distinct changes could (IMHO) be split into separate patches for easi=
er review.

This commit is a real pain to cut into 3 distinctive ones. Is this
really necessary?
I will do it if it is, of course.


--=20
C=E9lestin Matte
