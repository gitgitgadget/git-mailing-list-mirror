From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 06 Mar 2006 00:40:55 -0500
Message-ID: <440BCB67.4070406@michonline.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com> <20060306024353.GA23001@mythryan2.michonline.com> <440BC92E.4060306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0821A9F9942FD85570AF84D"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 06:50:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG8bu-0004Dr-FE
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 06:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWCFFlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 00:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCFFlM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 00:41:12 -0500
Received: from mail.autoweb.net ([198.172.237.26]:46015 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751275AbWCFFlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 00:41:11 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FG8Sy-0006cC-77; Mon, 06 Mar 2006 00:41:09 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG8So-00069R-Ss; Mon, 06 Mar 2006 00:40:59 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG8So-0003rt-Gl; Mon, 06 Mar 2006 00:40:58 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: gitzilla@gmail.com
In-Reply-To: <440BC92E.4060306@gmail.com>
X-Enigmail-Version: 0.93.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17274>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0821A9F9942FD85570AF84D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A Large Angry SCM wrote:

> Ryan Anderson wrote:
> ...
>
>>
>> For annotate, the syntax I was using was:
>>     git annotate Makefile headname
>>
>> I'm not married to it, so please, send a patch to change it if you want
>> (Please fix up the test case I'm sending in this patch, as well.)
>>
>
> Wouldn't
>     git annotate <headname> <filename(s?)>
> be more consistent with other git commands?
>
Yes, but <headname> (really, a commitish) needs to be optional.

I should probably switch to:
    git annotate [-c|--commit <committish>] <filename>
but that's partly why I'm asking for feedback.


-- 

Ryan Anderson
  sometimes Pug Majere


--------------enigE0821A9F9942FD85570AF84D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEC8tqfhVDhkBuUKURAlodAJ0VF50T3CHQyA07tbb1FPXDID5PwACdFWjY
GNFM3XGzYirVHblafeH30zI=
=4WjF
-----END PGP SIGNATURE-----

--------------enigE0821A9F9942FD85570AF84D--
