From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] difftool/mergetool: make the form of yes/no questions
 consistent
Date: Tue, 12 Apr 2016 18:25:01 -0700
Message-ID: <20160413012501.GA32611@gmail.com>
References: <1460472260.3214.23.camel@redhat.com>
 <xmqqegaapm02.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikola =?utf-8?B?Rm9ycsOz?= <nforro@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:25:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9YS-0003xC-1l
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699AbcDMBZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 21:25:09 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33664 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643AbcDMBZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:25:05 -0400
Received: by mail-pf0-f177.google.com with SMTP id 184so24183213pff.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z4brChIhxK0TqZnYo0kzKgbYRKMQYyiCGMz/HOIOd04=;
        b=Nhqk1rm3VRmmqgIusC7ZFepTNN+GX2IOn6AjILoR0Pk2akp5gMacxh8uXxddfg5UGC
         Bf93yG8rw8Q+45u50ABtBoHJTfeejMz+jhU1AglKN9JY7I8MhxShBmPXjSAIph7HQkNC
         fNQVLGVjO+TQaHTPE7u0FoMKQdXWuZCIilLZYiPlcAi3r5jIbUCWiimjO2k2Y35S937U
         cxLXlAsZvAx0Tx9vdNZmjLLuIiJpgx95qpsLDJ9pzXzgxtQS+lath12gqYbSw+X/0nEQ
         3AzijLmsQYoGNHKiikwDOsDjvlelTmCj8X5UhBgJAkUrHulj57m/1Kyw3F67sQuCuj3d
         7H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z4brChIhxK0TqZnYo0kzKgbYRKMQYyiCGMz/HOIOd04=;
        b=A6w0t3HsqEkOW6qq97usOLKcmCyvPdoSedIy1cSoR8ZyEY8zhOPtIhmsNKgl5NFFoU
         L3mJw0mvG6jIKtjsgjIhUwOJY76n+Ihjqc5NLA7ZYh/JbG2CBSxnnDlLs+ntHPEW4pAU
         bSqYnCw1DqCZCJtebIXAO+cU2WBvBaN8F6NWTKQNu2i4KplvP2yW2+tlEVXAtBcMNKsk
         GADwjezVal0ZpoxBwwZg+x06SWv0sM3mno93o+WGAuolo6q1MACYggBjMHel6yPCUc8l
         FMi49nTza3ju6psffGz6SKBiQvyLMiGz9h7yEkBFmWONqU8thDanlvOg6fUiUlastx7C
         w/vg==
X-Gm-Message-State: AOPr4FUEMfi+upbr40ecMrGhklCEab7DIH+x6QutdQDujKe2YF23CaKsOoD12PhxOIWXwQ==
X-Received: by 10.98.15.135 with SMTP id 7mr8952494pfp.142.1460510705275;
        Tue, 12 Apr 2016 18:25:05 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by smtp.gmail.com with ESMTPSA id p74sm46413917pfj.22.2016.04.12.18.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2016 18:25:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqegaapm02.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291357>

On Tue, Apr 12, 2016 at 02:15:09PM -0700, Junio C Hamano wrote:
> Nikola Forr=C3=B3 <nforro@redhat.com> writes:
>=20
> > Every yes/no question in difftool/mergetool scripts has slightly
> > different form, and none of them is consistent with the form git
> > itself uses.
> >
> > Make the form of all the questions consistent with the form used
> > by git.
> >
> > Reviewed-by: John Keeping <john@keeping.me.uk>
> > Signed-off-by: Nikola Forr=C3=B3 <nforro@redhat.com>
> > ---
> > Changes in v2: example dropped from the commit message
>=20
> Thanks; have you run the test suite with this patch applied?
>=20
> It is your responsibility to make sure that the expectation by
> existing tests are still satisfied after your change, or update
> their expectation to match the new (and hopefully better) world
> order your patch introduces.
>=20
> I needed to squash this in to make the tests pass, but because I am
> not a difftool user, I do not at all know if the prompt produced
> (and expected by the test) is sensible or not.
>=20
>  t/t7800-difftool.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index ec8bc8c..df9050f 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -20,7 +20,7 @@ difftool_test_setup ()
>  prompt_given ()
>  {
>  	prompt=3D"$1"
> -	test "$prompt" =3D "Launch 'test-tool' [Y/n]: branch"
> +	test "$prompt" =3D "Launch 'test-tool' [Y/n]? branch"
>  }
> =20
>  # Create a file on master and change it on branch

That looks correct to me.  Sorry 'bout that, I'll remember to
run the tests with the patches applied next time.

cheers,
--=20
David
