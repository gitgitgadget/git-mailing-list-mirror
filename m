Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48CB201A7
	for <e@80x24.org>; Mon, 15 May 2017 21:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdEOViE (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 17:38:04 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35267 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdEOViD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 17:38:03 -0400
Received: by mail-it0-f54.google.com with SMTP id c15so51486142ith.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accedian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r+806xOiqD+/24NRSriHvb6q7VLvSwblx4KgvUggT7g=;
        b=sY8ENrVTPVXsIgkMlr1j9QDZbBMuZK0jWtu4Q2gXRHcQEaad4Gb3XuOA+RF/dNcW76
         CJT0GAWv40uVGGAiVrSHB3r9R+eSOHDzVjCNLGEg34rONaP5mtijedINJh3GnPVyuwxA
         sU88GV4Wi7zZz835JMiqiO4IgAcOm4vvGKTtbUdm5W/avXhxJ/gocwbwq552Q6Rpe2fo
         QMjS3nRRPfNRNuD8Hji0axKh6o5pJi8dSUfvxPNDOjQqqIVG1sTK/sqcpzpiyndiPZEK
         oRU8NoIHXKNCQyUApZYdh0FlXcq/OfpgBkSQmWCYmkOJ0tqlNCsd5a5ANsROmNc9+jnV
         j1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=r+806xOiqD+/24NRSriHvb6q7VLvSwblx4KgvUggT7g=;
        b=XThikZ0bo2bu+YZIn1xcqww96eD6+QxNFxMGo1MErs5eIamwJ0ZLQtkkko4WEcmjwY
         lC5viRu0XVJ2/eVqneZJf5FWVqR2bawGxwmss1T1bhrU5G/eK8URKqtnwnVk7q/xeNBZ
         E1EYPkEDWn+7o15LyhTeZZKiF593Z+F8O0grhHKI0ZDFbHEP4kkHbukkxaFCWVEyiMQj
         cGp7xTWSNi8I+68UVI93dcN7kkEaWpAg3s6XrnvrCoOZHegYzNQ3MtZAMjzzokTPcaRt
         1qmqfys6/Dbu8eeFt7p/fVzhYSLVuLYhpWLRkj03S+RKqqZN0O/lXCEvQYhOUlS/RB7T
         D44Q==
X-Gm-Message-State: AODbwcBI7lxk7kqYfsFakE98faWkRBX7AuioLO2Lxyvk6usBiFKh6bGS
        aDkzog+r+X9L4aN43A8k1R5Ih6ad5xHiFr7RphBti0h6fqNF0QeNvhkTFGoh07Mskd/OArNtsGE
        /PxYcHgHQFbwUBA==
X-Received: by 10.36.25.196 with SMTP id b187mr7460179itb.30.1494884282063;
 Mon, 15 May 2017 14:38:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.123.133 with HTTP; Mon, 15 May 2017 14:38:01 -0700 (PDT)
In-Reply-To: <CAPYmS36e40gb6_2updPKvzo8EJj7+f5npZy9nPDkz1ou8a80_g@mail.gmail.com>
References: <CAPYmS36e40gb6_2updPKvzo8EJj7+f5npZy9nPDkz1ou8a80_g@mail.gmail.com>
From:   Jean-Francois Bouchard <jfbouchard@accedian.com>
Date:   Mon, 15 May 2017 17:38:01 -0400
Message-ID: <CAPYmS37KTeQDM+iugnEpcxFdPdBxEg3Khg8woptGPE7K-nyjGw@mail.gmail.com>
Subject: Re: clone vs submodule operation with HTTP cURL
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Follow-up to this post.

I seems that setting GIT_HTTP_PROXY_AUTHMETHOD=3Danyauth is a workaround
to this issue.

So now the issue is : git is not setting AUTHMETHOD correctly when
doing a submodule update

Note that a user is needed in the URL string. :@ does not work,
empty.auth variable does not work.

Any ideas ?

Thanks,
JF

On Thu, May 11, 2017 at 6:04 PM, Jean-Francois Bouchard
<jfbouchard@accedian.com> wrote:
> Hello everyone,
>
> In our usage of GSSAPI via HTTPS, all our operation with git are very
> well handle, however, when trying to update a submodule, git seems to
> be managing cURL differently. cURL drop the ball quickly.
>
> Example (No other setup needed on the client) :
> git clone HTTPrepo -> GET -> 401 -> GET -> 401 -> GET (this time with
> Authorization: Negotiate)  -> 200 OK
>
> git submodule update -> GET -> 401 -> git prompt for username
>
> Is the codepath for clone regarding cURL is different than with submodule=
 ?
>
> Using : 2.13.0, I have also tried the emptyAuth stuff with no avail.
>
> Thanks,
> JF

--=20


Avis de confidentialit=C3=A9

Les informations contenues dans le pr=C3=A9sent message et dans toute pi=C3=
=A8ce qui=20
lui est jointe sont confidentielles et peuvent =C3=AAtre prot=C3=A9g=C3=A9e=
s par le secret=20
professionnel. Ces informations sont =C3=A0 l=E2=80=99usage exclusif de son=
 ou de ses=20
destinataires. Si vous recevez ce message par erreur, veuillez s=E2=80=99il=
 vous=20
plait communiquer imm=C3=A9diatement avec l=E2=80=99exp=C3=A9diteur et en d=
=C3=A9truire tout=20
exemplaire. De plus, il vous est strictement interdit de le divulguer, de=
=20
le distribuer ou de le reproduire sans l=E2=80=99autorisation de l=E2=80=99=
exp=C3=A9diteur.=20
Merci.

Confidentiality notice

This e-mail message and any attachment hereto contain confidential=20
information which may be privileged and which is intended for the exclusive=
=20
use of its addressee(s). If you receive this message in error, please=20
inform sender immediately and destroy any copy thereof. Furthermore, any=20
disclosure, distribution or copying of this message and/or any attachment=
=20
hereto without the consent of the sender is strictly prohibited. Thank you.
