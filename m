Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3AF1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 01:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeIQGwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 02:52:22 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45866 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeIQGwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 02:52:22 -0400
Received: by mail-ed1-f48.google.com with SMTP id p52-v6so11487270eda.12
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMNrM9KqpgauDjLYXHxDV6XEbwskQbZ4dTMr0Z8tdTQ=;
        b=t33gesGERYFSas4eMeWRLpG6cSMDmOdSx2bkjUVtwWl+GFW9IYIRNG7RLzAHCbzKbK
         7azWGs6lsmtPS2wCT4rpvoMj2xlmgz6jU6HzF3ftvbca9OoD2DELzkWMt/igpapREcgP
         12I8wksAi0WVZ7khDjexhXmSXf2BhdtUilrKcq7INiC36L1dl6dgsy7BEnA1ch6/9EOs
         6RFdlAJkFxUexS9mmQqhb/BbRagq1uY1GKF1u/hRXSDI6DPl8yrYOF1eJ96Ax73ARjCF
         5XaJHGRbMdohUfFsLHMlDYMF5BPfoUZsRrCYph/+AKmQiFVOL6O/IqRQJTB+z8NyH/Jt
         3N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMNrM9KqpgauDjLYXHxDV6XEbwskQbZ4dTMr0Z8tdTQ=;
        b=R025vNLyrJBqDid6DkZ6VxgG1NnG+1GyOBWeaxQQUiho4Xj7j0fK393BG1gpQhESLc
         CCZuss5w5fvmEXjhWNSiWFtQ7+/q+toYqrRpiCudtLmGchi4Q9wyausOpwWZQD8i474v
         Ig/rSLlORnDfgOTi+1VYfiNy8d2Aebs9y9z5TuI/C0XVPGQNe2zhitYhd7M9lL7+P7Ht
         A7YceYKTh+V0ot880qrwPRACnem84umdffTwFPt7dGLvB8SKZD3kURnPu6QpRBnJcGWA
         RzfGBPgkHzk8+emBbvtGtYCbUgzGQ0Efh98DZpSIe+ZZK/F3dw9+13iaXK56PTfVoQm4
         z6FA==
X-Gm-Message-State: APzg51AC0jNXOU5gDMchGtne+9xxCR82yqoyuyrpywCiN3/xQiSKeqTs
        Ser8N688df4Noe0601sM5pRWTZbcWsc=
X-Google-Smtp-Source: ANB0Vdax0O0PCECqo0eBoSh9OKXI7O6+RqnNUSMtmwesKIAIulrNoJJZGQFolVXjgjByt/MOjaiYRA==
X-Received: by 2002:aa7:c358:: with SMTP id j24-v6mr39706565edr.100.1537147642668;
        Sun, 16 Sep 2018 18:27:22 -0700 (PDT)
Received: from localhost (92-109-79-134.cable.dynamic.v4.ziggo.nl. [92.109.79.134])
        by smtp.gmail.com with ESMTPSA id s7-v6sm6699380eda.19.2018.09.16.18.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 18:27:21 -0700 (PDT)
Date:   Mon, 17 Sep 2018 03:27:21 +0200
From:   Chris Coutinho <chrisbcoutinho@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question - no space in smtp-server-option
Message-ID: <20180917012721.akyclbcmeqw5dv3x@tumbleweed>
References: <20180917010244.btmlczam5m75rmto@tumbleweed>
 <20180917011657.GD154643@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o7cr3gryf7bnh75e"
Content-Disposition: inline
In-Reply-To: <20180917011657.GD154643@aiede.svl.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o7cr3gryf7bnh75e
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep-16-18, Jonathan Nieder wrote:
>Hi,
>
>Chris Coutinho wrote:
>
>> Currently my gitconfig contains the following line:
>>
>> 	sendemail.smtpserveroption=3D-a<myaccount>
>>
>> Whereas, the following results in an 'account' not found error:
>>
>> 	sendemail.smtpserveroption=3D-a <myaccount>
>
>Do you mean that your ~/.gitconfig literally contains that exact line?
>I would be surprised to hear that syntax works --- see [1] for the
>syntax I would expect to work.
>
>If you have more details, that would help.
>
>Thanks,
>Jonathan
>
>[1] https://www.kernel.org/pub/software/scm/git/docs/git-config.html

Yes that's the exact line in my gitconfig file, which correctly mails=20
using the non-default account I'm after - I'm assuming you're noticing=20
the lack of camelCase? To be honest, that came from zsh autosuggestions,=20
which are all lower-case for some reason.

My question is just regarding the syntax of the smtp server option,=20
namely about the (lack of a) space

--o7cr3gryf7bnh75e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgByWpgIJZOpMvgTGINFyBbymYXQFAlufAvgACgkQINFyBbym
YXQ97w//QAtKt4YfKid/RSDWRghbMjpWBG2+Mzr9b8Z9TC+L3BI4STbWdtnfLJ5h
xgu4/Sobnw+p93GNXCjvKP+uu+M+njB3h5x9EtqYnxTWY7JDoYHhcUntctwVeprn
9xDln8hlvTHHY4AwWd974QCc2KTw2OdnE5jtXFw0ux2r6jidAAwrsOU0e6wW49t1
z4SPgRD5sFGI2+a85/fMx9djeRzyxWuGB/WB7JVAzoCcrMJ0Bf4is181sTXRvffk
vxAxha506/29zSb6ALzROoeR2A+VZ1JEFwhFriT15gDHZyOebBK4X2g45pw72SxT
b4PMaqs2Xr8XjB/+QiQlDLd3MHrVXB4pKQBLckNvtcQEdqTSjZ1OGDHfahP6RZSE
Kq20Trnr5UcIc4QPQHFjfExWNXefiHsGMGZNO81JU5nrsQfOpPTgOmAX/CriyWOO
g2mJi1UfOw4YeJaZ9K0xlsqUQefew6GrRKBDYpTfq7iG4E7xGcAxRyyIgOp0OG7F
qxb+tqr9OgBqZ1yDNzRGXZslzoe5U3TDrecN2zapJA5u2K8TXZSQ2NvJ2ZbFS3z8
9UO4VUAKB4KDwxnHJgZ+jWoN2Cpk21aju/nS4ptWb6uCbW599rlxQKxz92OOmrIe
fQPsRgb7WZsbJwRrJBP8I6tdBxy1Byc3V2/NRGc8BIRTabvXcsY=
=hQHo
-----END PGP SIGNATURE-----

--o7cr3gryf7bnh75e--
