From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 20:07:24 -0700
Message-ID: <4F75236C.4050703@gmail.com>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com> <1333062296-27823-1-git-send-email-haircut@gmail.com> <7vboneq1vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBB7D0FCDCEA972DA05EDBBF7"
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 05:13:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDSHZ-0006a9-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 05:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759815Ab2C3DNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 23:13:40 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:44858 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759709Ab2C3DNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 23:13:39 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2012 23:13:38 EDT
Received: by qafi29 with SMTP id i29so200864qaf.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=FWQQwJSCFJtciRuEzwi3kB4sblnJujOt+XHIMY3Xb48=;
        b=FPyV763qGsgxrXOLn+9mYF/IGlza99kLa4v5WZw7ctEUDANIvezUuimvHoejYt9E5e
         C8drRDQiDkUhEfFGLn+0xjoxvXJBOPB3HHpVRJCpqeaFaFVaLna4fyrDIdHzhKH2YGhE
         7TDf/y8thz+FYi5qqoRmd5/MVvo06xs5hATfzq0Woq0GT/CCXiBLse1iuWDoiTV/foWi
         rSh+jlcicA7fJsZDslmIlKRPTjulUEAlHsTw7MGj1odVhrLdahh55RZTFCAkLiHtttdW
         JVjljCh8zuIYoBPokEdrUz8YHGx0v6+y2rqsesPBhXaSjNOEIL4Vco53TuIEzcmHTTiz
         +xiw==
Received: by 10.224.180.206 with SMTP id bv14mr3417103qab.56.1333076847209;
        Thu, 29 Mar 2012 20:07:27 -0700 (PDT)
Received: from [192.168.13.92] (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id er10sm553056qab.16.2012.03.29.20.07.25
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 20:07:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <7vboneq1vs.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194318>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB7D0FCDCEA972DA05EDBBF7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Junio C. Hamano wrote:
> First, think of template not as the "initial version" but as "a form
> that needs to be filled"

Ah, that clarifies for me what the authors had in mind when
implementing this feature.

I was hoping to use this feature to pre-populate the commit message
in my editor and have the option to edit it or leave it as-is. This
is what the word "template" means for me. For example: if I open a
"template" in LibreOffice, I can make changes or not, and
LibreOffice still lets me print or save at any point.

Now that I know it's not that at all, but rather something more like
a mandatory fillable form, I'll find another way to achieve my need.
Since git really wants me to enter *something* for a commit message,
I understand why git "templates" work differently than LibreOffice
"templates".

It's getting a little wordy, but here's an attempt to work in the
"form" concept:

~~~
Use the contents of the given file as the initial version of the
commit message. Think of this initial version as a mandatory
fillable form. The editor is invoked so you can fill in the form. If
you do not fill in the form (if you make no changes), the message is
considered empty and the commit is aborted. If a message is
specified using the `-m` or `-F` options, this option has no effect.
This overrides the `commit.template` configuration variable.
~~~

Thoughts?


--------------enigBB7D0FCDCEA972DA05EDBBF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPdSNsAAoJEJtdmT+DbynA5WsH/122JBEY+FhTAiLn+FPmY/PV
hcI8W7FnvlwDkkMBWxJjjqU5+VxFSdt3TpXR/5C2oc1e8QmeSQcAv3sDHmf6hLPW
E1wURw4zbbBPJQLpqvGclGllQwKpKuZ313RmMc+vPDTZV2V9r6nu9ARrD50VKqWg
eqOO5rKjDD2UQBWXbQcE5JUwjFdWrZ5Cn8DAXYR7lKqy9Huk791754uNFAYqvGYy
hwtgVQeDFZUCi1oRL3CN9I17YUtUD1oWU8bbOhnPS55eVv6x+mcWVvusxhErdY6O
hpoHY26pDxI0bS3VHxKNB1E7mmQAQ4nzPHCzTWk52dShio9n8nLGuuVpShq8wnA=
=qz2I
-----END PGP SIGNATURE-----

--------------enigBB7D0FCDCEA972DA05EDBBF7--
