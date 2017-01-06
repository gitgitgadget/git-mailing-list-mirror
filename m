Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DF81FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937928AbdAFTnz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 14:43:55 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36574 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936528AbdAFTnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 14:43:53 -0500
Received: by mail-qt0-f179.google.com with SMTP id k15so317633114qtg.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OX3IVtxzKN2/DathCd2MUuvQcjiTn0THWwkTsnh3aTk=;
        b=QtPVV5tpGVoIFoRmmHoBnpUQ45hn6x1w6e/VjcJSFRRgJfXdtlTR58ZpN9KS7mrIgz
         7FCWdRCh9ELmckdW7bjAgVKW36weStlzJ7ucvD30TXXcgJV45SK03av71YCtK3rTc042
         PfnhyznN/Yv70LTZBr7HzFbdpUvQJOLvamEYdtdRO5Tm5XbTPOIiM9V3s3dxAkYWwo/+
         KeRkN8+ngZE2CmifyN5ERzOBe77FjNjeNRhzt8nHNUW2XDvQkMnmH+YQu03t6w7OS93h
         qdBekSnpka9yyF7eqtufKYp0oLLLGBWiKKMop6cfCbWhf5rAnqkOKk04QAsh1lUiEJMH
         jSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OX3IVtxzKN2/DathCd2MUuvQcjiTn0THWwkTsnh3aTk=;
        b=haMfmwSbtuHdWjUEvNIcrwPWS6WybIujL5qlwjdSyUCzJmwr14yzbKsa+GlddQM1LA
         Drp9HgUsoOD2G16bowaE87x0oS7v1xdTRSbYZXE19v/IBbKYxJwEb5pagjf8hUUyaVSY
         KQBeTAV4Phcvb6XmcbagLTe+GowqJfWJBLUG/eneegdkVuBTCin8M17NC7OYGkcfmATG
         53ID8T+t2qcJDvDMyEWYWyfTCLiQVbs8k4mZbKqErgsLEVuEaY8KNT0K0dIOCDlWltDl
         lcB3XyCQWxk6GYAIRnLyjfAVgjd5ATDLc+d8kjf+SYZ+XE77FHorPlqbBPiCakBOep28
         0zkQ==
X-Gm-Message-State: AIkVDXJr1L0CO5yZwlL1cFwd1ixSLZtxTo9bhknrUnhNzhRbYjwFxEcgw6kPdy+V+VIkoTM7xO/M/EymvPgRnDwj
X-Received: by 10.200.50.147 with SMTP id z19mr67947184qta.207.1483731832632;
 Fri, 06 Jan 2017 11:43:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Fri, 6 Jan 2017 11:43:52 -0800 (PST)
In-Reply-To: <CAN0XMO+zzYOXF2gwr=0Tu-7T5BH7f_L+FhfD8RUenDeq3xFHjA@mail.gmail.com>
References: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
 <CAGZ79kaz_hS9P7vqV9EhZazM_g0OUdRfMtFPJ7gFu-h-ku=NKw@mail.gmail.com> <CAN0XMO+zzYOXF2gwr=0Tu-7T5BH7f_L+FhfD8RUenDeq3xFHjA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Jan 2017 11:43:52 -0800
Message-ID: <CAGZ79kZOfHWP_pQGN1QcmR71Ft6ib0aPwNKX80YMT7KcK0_Stg@mail.gmail.com>
Subject: Re: git branch --editdescription fatal error
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     Jake Lambert <jake@onahill.co>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 11:31 AM, Ralf Thielow <ralf.thielow@gmail.com> wrot=
e:
> 2017-01-06 18:55 GMT+01:00 Stefan Beller <sbeller@google.com>:
>> On Fri, Jan 6, 2017 at 9:25 AM, Jake Lambert <jake@onahill.co> wrote:
>>> Hello,
>>>
>>> When executing "git branch <branch> --edit-description" on a branch wit=
h no description set, I get "fatal: could not unset 'branch.<branch>.descri=
ption". It would seem that the unsetting piece should occur only after chec=
king if it was set in the first place.
>>
>> That seems strange. Is it possible that your config is not writable?
>> (.git/config, ~/gitconfig, you'd need to find out where the <branch>
>> is configured already via git config --global/--system/--local --list)
>>
>
> Have you actually tried to reproduce this issue? I'm on current next
> and can reproduce the problem.

eh, I was on $random_version that I currently have installed
(with messed up submodule code, but otherwise close to master).

this gives hope that a bisect between master..next will give us a culprit?

>
> I think removing things that don't exist should behave the same like
> removing things that do exist, with
> a success.

I am not sure. Consider the tool "rm"

    $ rm no_exist
    rm: cannot remove =E2=80=98no_exist=E2=80=99: No such file or directory
    $ echo $?
    1

You have to use the --force.

For this specific use case I agree we should then set the force flag
to let the the removal of the config option succeed no matter if it
existed before.

Stefan
