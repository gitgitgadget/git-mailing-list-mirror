Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F35420282
	for <e@80x24.org>; Tue, 20 Jun 2017 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbdFTMq0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 08:46:26 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33206 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTMqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 08:46:25 -0400
Received: by mail-wr0-f173.google.com with SMTP id r103so91302585wrb.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4A8dmLBnpjrTLf8WEkfFiMClnD5Ck7KbUc8lRCl+fBQ=;
        b=XUSF0ZSmE7QAeyqhDmKh1ghWmiQRGTwhy+o3biaMLjKCkxoVRZ/TLbwE3QJAmYQkFW
         LYG37gLpkIVr80fDlzhpy9l0v5SeKOkOPUcRjIhNVOliZhGCoFufB8aLqWgiiwHrz2x6
         igKt24euGH0ChS955VWFePOMTAtzv8niTLgtVvEzKVeTU89PY7iA0abfMzyJOxSuKwlF
         /J1kjImddAk4dgwKeR2W7IWK2Ayr3NaJKaosPydHc3LfbF6eT3DFbcJh22kCErV9+1U/
         8RdWcHKtfJX4dDCyamCjwt4CJ1JM6JA7DUKDEWK952l/kl0IPP0hRPFyETrq+PaNEKnq
         6ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4A8dmLBnpjrTLf8WEkfFiMClnD5Ck7KbUc8lRCl+fBQ=;
        b=USAX6wVr7j7nxp//gOLAMN1j9xlHr/20S036DRhETjEj0hKDkP0x1+oXvU9Hm4XCS5
         +WZVfe1f/8z3Mdr5WGiTTnGGpYR8ZKJFRefu7cf+8waxm9at1GYNQ0F2vaw5x/yodg8Z
         pQrVILTroE5T1osJBencMcPJrZO6IqBeNwTi1X18yAYHgEqIXppqq9ONFtdsgTs5BYxR
         FQR9mIgKLYcS9yeOwglCk7RVd4za1nF7q0QYtI7PWgAyLjeftLsdp1Ys3sGSuHDfEvUk
         pjFpTf4trNLLa2FUnbmQhNfnG5mWL4Q89yTXIARXnHqhBE+8EpJagkJa75gGjXi6Zq2u
         ig8Q==
X-Gm-Message-State: AKS2vOzEVYqu1fPGTjUzrEI6sPhBr+3nCywMbqVtUukbKMOE/K6QPmqP
        Cw/gnewIZQvDRZfXkhY=
X-Received: by 10.223.163.85 with SMTP id d21mr6136431wrb.95.1497962783372;
        Tue, 20 Jun 2017 05:46:23 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i5sm7513669wmc.0.2017.06.20.05.46.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 05:46:22 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Transform log message during migration svn -> git (using git-svn)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <90ee80a910884e1e98fa8a5001ae850c@GTLBML3EX0005.bagmail.net>
Date:   Tue, 20 Jun 2017 14:46:22 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDA6D349-0DF9-49F3-B2B6-0B1AE3BBD052@gmail.com>
References: <8ce2bf074fcf4d6181a29eb3e7fff132@GTLBML3EX0005.bagmail.net> <EAA4B747-FA00-4A3B-88CD-AF8EBE1F8586@gmail.com> <90ee80a910884e1e98fa8a5001ae850c@GTLBML3EX0005.bagmail.net>
To:     paul.mattke@s4m.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20 Jun 2017, at 14:32, <paul.mattke@s4m.com> <paul.mattke@s4m.com> =
wrote:
>=20
> Well this is a possibility, of course. Our problem is that our SVN
> repository contains about 220.000 revisions currently. As a colleague =
of
> mine said that the command you suggest might take about 4 seconds per
> revision, it would take about 10 days to do this for our whole =
repository.
> So of course it could save a lot of time generally if such operation =
could
> be done immediately during git-svn.

You colleague is most likely correct. I suggested it as this is a one =
time
operation and therefore still somewhat practical from my point of view.

If you don't like the solution then you need to change the git-svn code.
Probably here somewhere (I am not familiar with this code):
https://github.com/git/git/blob/master/git-svn.perl#L1836

- Lars

PS: Please don't top post on this mailing list :-)
https://en.wikipedia.org/wiki/Posting_style#Top-posting



>=20
> Paul Mattke
> Software Developer
> -------------------------------------------------
> Arvato Systems S4M GmbH
> Am Coloneum 3
> 50829 K=F6ln
> =20
> Phone: +49 221 28555-443
> Fax: +49 221 28555-210
> E-Mail: paul.mattke@s4m.com
> www.s4m.arvato-systems.com
>=20
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: Lars Schneider [mailto:larsxschneider@gmail.com]=20
> Gesendet: Dienstag, 20. Juni 2017 11:32
> An: Mattke, Paul, NMM-BPDD <paul.mattke@s4m.com>
> Cc: git@vger.kernel.org
> Betreff: Re: Transform log message during migration svn -> git (using
> git-svn)
>=20
>=20
>> On 20 Jun 2017, at 09:32, paul.mattke@s4m.com wrote:
>>=20
>> Hi there,
>>=20
>> this is actually not really a bug report, but much more a feature=20
>> request (if I did not oversee an already existing feature like this):
>>=20
>> We want to migrate our SVN repository to GIT and will be using =
git-svn=20
>> for that of course. Currently in SVN, all our commit log messages=20
>> start either
>> with:
>>=20
>> 123456 (a number, representing the Bug Id in our old legacy bug=20
>> tracker)
>>=20
>> or
>>=20
>> T123456 (a number, but prefixed with T, referring a TFS item in this=20=

>> case)
>>=20
>> During conversion to GIT, we want to replace the T in such log=20
>> messages with a #, so commits, referring a TFS item will start with
> #123456 in the future.
>> We don=92t care about log messages which do not start with a T, only =
the=20
>> TXXXXXX messages need to be transformed here.
>>=20
>> I guess an operation like this is currently not possible with =
git-svn,=20
>> isn=92t it? So it would be nice, if a feature could be implemented =
that=20
>> gives the user the possibility to specify some kind of script file =
for=20
>> example, which transforms the log message in any way we want it.
>=20
> You can migrate your repo from SVN to Git as is. Afterwards you can =
fix up
> the commit messages with the following command:
>=20
> git filter-branch -f --msg-filter 'perl -lape "s/^T(\d+)/#\$1/"'
>=20
> (this might take a while on a large repo)
>=20
> - Lars

