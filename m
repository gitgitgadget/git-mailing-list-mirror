Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9308720954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdKVQxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:53:36 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41221 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdKVQxf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:53:35 -0500
Received: by mail-wr0-f179.google.com with SMTP id z14so15120992wrb.8
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HXANwHtesNU7NLmhfUT9NFPJWBBGuwx8ys+GyQ2t+HE=;
        b=tQyPXzFc4YgUASX9OJuDGI+HjvbXVicd2lDyDyhNMjbOCv/sUdkzxtlCDOpScL9Fp9
         1r6G21t6nFzkgz5Gq6n9/R90tZvEN+cpcSmrsus68YDNFnRgrJFf5wcKiE6xbhqZAvgw
         jEP068xhF9jTG1ejGTnnd5mkWy6POpI0/TYqn8WGsIcjPm2sxtXQmFTly2M49mmy0b9N
         JetX8Epa0FFLhyA9vnzQXA/SzsOHM0ZyTozAEIc7BtMW6BzrTMWuV8FXX5TjP99UNv7+
         y2piYfd8KjqDxsIifrW0KpKryqlmLMMC4AWDmnuC8joWOks/3kJcpoSpyGaq7Q4vCWRD
         gX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HXANwHtesNU7NLmhfUT9NFPJWBBGuwx8ys+GyQ2t+HE=;
        b=pqkWk4kOZ6k4dOYyz6oO78fbrJ2dLrXU8GUSDL9E8LX3zhHzocCSnKIlJkVGn24BP6
         ZVekX8yBOJYDZeDOxeX3O6RQQYRItgZnzkDC2VHBLxxw9+H/YX1+2/dXtAAi0KEUXw/i
         uDSX++xJd1V8ReqeBxVtj1rnjGpgl0Z4z8TrgOKL3ioOGGRKeSXIks5f1DNrY8E30fXf
         4PNUngMHkz84rKa+Ze+S8ZiHY25UzLEf5qwK+NvcHBhkC4UY011//EdVIfDmlSLkseQL
         O+TK+mX19kd1boq8HjymkDmWyrZDEde/wte71utNwFz10QZnZKZkGo69NMPMe5JpO7RJ
         NyTw==
X-Gm-Message-State: AJaThX7VqcULIPs+JRAWPN75rMmM3lPFHMjdZssEwlcHbjaelFpScbBG
        lRVEF56g5JZawdqD2+gYTYA=
X-Google-Smtp-Source: AGs4zMa/psjice+4Aq/HaYu7cblmNOWNALJ5WemY+Q3o5r/5oEBCFdrGQilZ3HDOt8n2poodsJuGFQ==
X-Received: by 10.223.185.3 with SMTP id k3mr12694095wrf.40.1511369613823;
        Wed, 22 Nov 2017 08:53:33 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id q13sm8620254wrg.97.2017.11.22.08.53.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Nov 2017 08:53:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
Date:   Wed, 22 Nov 2017 17:53:32 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <919EA31C-FDC5-4694-9614-157042D2DA82@gmail.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com> <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Nov 2017, at 20:41, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Fri, Nov 17, 2017 at 8:51 AM,  <lars.schneider@autodesk.com> wrote:
>=20
>> +                       char *term =3D getenv("TERM");
>> +
>> +                       if (term && strcmp(term, "dumb"))
>> +                               /*
>> +                                * go back to the beginning and erase =
the
>> +                                * entire line if the terminal is =
capable
>> +                                * to do so, to avoid wasting the =
vertical
>> +                                * space.
>> +                                */
>> +                               close_notice =3D "\r\033[K";
>> +                       else
>> +                               /* otherwise, complete and waste the =
line */
>> +                               close_notice =3D "done.\n";
>> +               }
>> +
>> +               if (close_notice) {
>> +                       fprintf(
>> +                               stderr,
>> +                               "Launched your editor ('%s'). Adjust, =
save, and close the "
>> +                               "file to continue. Waiting for your =
input... ", editor
>> +                       );
>=20
> Here's what this looks like for me:
>=20
> --- 8< ---
> Launched your editor
> ('/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'). Adjust,
> save, and close the file to continue. Waiting for your input...
> Waiting for Emacs...
> --- 8< ---
>=20
> Very, very noisy, so much so that it's almost unreadable. There are at
> least three reasons for the noise:
>=20
> * The raw message itself is already overly long. Do we really need to
> assume that newcomers are so clueless that they need it spelled out to
> such a level of detail? "Launched editor" should be enough for most
> people, and one would hope that "Launched editor; waiting for
> input..." would be enough for the rest.
>=20
> * Does not take into consideration that EDITOR might be very long;
> perhaps you could just print the basename and strip arguments (i.e.
> "/my/long/path/edit -x --foo --zap" becomes "edit"). Or, just omit the
> editor altogether.

Agreed already in another reply here:
=
https://public-inbox.org/git/0DD1EE8A-47F1-41AA-8F86-C9FDF99D22A0@gmail.co=
m/

>=20
> * emacsclient already prints its own message ("Waiting for Emacs...",
> which runs together with Git's message). Perhaps treat emacsclient as
> a special case and skip printing this message if emacsclient is in
> use: if (strstr(...,"emacsclient"))

If Junio et al. are ok with the special handling of emacs, then I am =
happy=20
to add this change in v3. If we look for "emacsclient", then would this=20=

cover emacs on Linux and Windows, too? (I am no emacs user)


>=20
> And, of course, with a "dumb" terminal, it's even noisier with the
> extra "done." at the end:
>=20
> --- 8< ---
> Launched your editor
> ('/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'). Adjust,
> save, and close the file to continue. Waiting for your input...
> Waiting for Emacs...
> done.
> --- 8< ---
>=20
> As Junio pointed out in [1], emacsclient has already emitted a
> newline, so the clear-line sequence is ineffective; likewise, for a
> dumb terminal, "done." ends up on its own line. Aside from the noise,
> this also suggests making a special case for emacsclient.
>=20
> And, as Junio pointed out in [2], with a message so long, once it has
> wrapped, the clear-line sequence does not work as intended. For those
> of us with 80-column terminals, we're left with a bunch of noise on
> the screen.
>=20
>> +                       fflush(stderr);
>> +               }
>>=20
>>                p.argv =3D args;
>>                p.env =3D env;
>> @@ -53,11 +79,14 @@ int launch_editor(const char *path, struct strbuf =
*buffer, const char *const *en
>>                sig =3D ret - 128;
>>                sigchain_pop(SIGINT);
>>                sigchain_pop(SIGQUIT);
>> +
>>                if (sig =3D=3D SIGINT || sig =3D=3D SIGQUIT)
>>                        raise(sig);
>>                if (ret)
>>                        return error("There was a problem with the =
editor '%s'.",
>>                                        editor);
>> +               if (close_notice)
>> +                       fputs(close_notice, stderr);
>=20
> Should printing of close_notice be done before the error()? Otherwise,
> you get this:
>=20
> --- 8< ---
> Launched your editor (...) ...There was a problem...
> --- 8< ---

I think we should keep it as I agree with Junio's argument here:
=
https://public-inbox.org/git/xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com/=


- Lars=
