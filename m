Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7A51F667
	for <e@80x24.org>; Sat, 19 Aug 2017 18:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdHSSYY (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 14:24:24 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37374 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdHSSYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 14:24:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id i66so21083218wmg.0
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9we9k1h7t59bzIE0tujNsI+zJw2kfYf0727OFy0a42Y=;
        b=GfVlX7pnpo50lzLCaGhlZx+yYq9b/lK2rj8ZW7jQrezVWSvX9YeYopR8b60DC0t+0J
         2NIq+b9HHeERFZ186Oav2KMXiO82TCXCV5VZtZ/rxGseqxxsE4MvH06NT8bAYx3akgQ5
         7T10rWrRTHU4UaTMYxwOe3WLl1VRl15/Ecv2TTvzdxtam0FdR5e7bToNqN6Pjkb2JT83
         7U/RtIEUAK5ZtCuItXv0ZiLO/KVoKOLdPIz5twoyBgP/TePyk1/mbHnIxCg37xGEQwda
         03WmxiAiRjnr7y9ua2c88GgS+4DxejrT4YzyjrnbJ7rz66kcKNjC/rsjoiw88JCGbjCZ
         fJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9we9k1h7t59bzIE0tujNsI+zJw2kfYf0727OFy0a42Y=;
        b=a0uWKKeLwQPSjwqINdv+u2X4NTcGXCYym04E1dkvcdkx4pQ0ZbnJmISDwQna2IrwWB
         IAtlbOlLYe0NbBaCe7XNUNn4d5VbvEnT+lUD1samwlKVvR1lI+AZIerYSaOIdYqGWKdq
         5VCjwnIhg9OPK/3MlnVMVJwtxX0jj8tguG5UnN40X2oPq+LKQqjYASHgzjWe20q5vHOH
         CoHvjI2tWT3cI9vJ5zjt3hIiazO8GPP5PMomhXntFe+R+VCsDG7gVz6ijet8XWrS1FMy
         zrow2yCBtX7FxwmSGsH9phes5SFu63zPCt+IAYK6SgyW0JfYqArmcVI7TG+s8k1szgbZ
         ALTw==
X-Gm-Message-State: AHYfb5iXxFC3xqyk2LD5hwe4XZjlTGuuCsfwvUm892Vn8exGyZgnNuHk
        QoGtWT89gRUHGQ==
X-Received: by 10.28.57.4 with SMTP id g4mr3239173wma.170.1503167062705;
        Sat, 19 Aug 2017 11:24:22 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB70A1.dip0.t-ipconnect.de. [93.219.112.161])
        by smtp.gmail.com with ESMTPSA id p65sm3614648wmg.10.2017.08.19.11.24.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Aug 2017 11:24:21 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Submodule regression in 2.14?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kaC-rtfp-AMdpkpCycgk568eU2y-JDGwdoSK_E=oUJo-w@mail.gmail.com>
Date:   Sat, 19 Aug 2017 20:24:20 +0200
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89AB8AA3-8E19-46BA-B169-D1EA4CF4ABE7@gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com> <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com> <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com> <D784E926-9FC7-4508-9632-225138679CDF@gmail.com> <CAGZ79kaC-rtfp-AMdpkpCycgk568eU2y-JDGwdoSK_E=oUJo-w@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Aug 2017, at 19:16, Stefan Beller <sbeller@google.com> wrote:
>=20
>> In the past "submodule.<name>.update=3Dnone" was an easy way
>> to selectively disable certain Submodules.
>>=20
>> How would I do this with Git 2.14?
>=20
>    submodule.<name>.active =3D false

That's what I thought after your first response. However,
this test case fails for me, too:


diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dcac364c5f..24f9729015 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1289,4 +1289,19 @@ test_expect_success 'init properly sets the =
config' '
	test_must_fail git -C multisuper_clone config --get =
submodule.sub1.active
'

+test_expect_success 'submodule update and git pull with disabled =
submodule' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=3D$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git config --local submodule.sub0.update none &&
+		git config --local submodule.sub0.active false &&
+		git submodule update --init --recursive &&
+		git pull --recurse-submodules &&
+		git submodule status | cut -c 1,43- >actual
+	) &&
+	ls &&
+	test_cmp expect multisuper_clone/actual
+'
+
test_done


Here is the relevant part of the Git config:

	[submodule "sub0"]
		update =3D none
		active =3D false

Is this a bug?


>> My gut feeling is that all commands should respect the
>> "submodule.<name>.update=3Dnone" setting.
>=20
> Well my gut feeling was that the "update" part of the name
> reponds to the subcommand, not the generic action.

I see. But wouldn't that be inconsistent with the config
"active" then? Following that logic "active" would only
respond to the (non-existent) "active" subcommand, no?


> For example when you set update=3Dnone, git-status,
> recursive git-diff still reported the submodule.

My understanding is this:

(1) "active" controls if a submodule is considered by
    Git at all.

(2) "update" controls how and if the submodule pointer
    modified

Is this your intention? What would be the use case for
"active=3Dtrue" and "update=3Dnone"?=20


- Lars=
