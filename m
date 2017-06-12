Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A5420401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdFLWKL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:10:11 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35355 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdFLWKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:10:10 -0400
Received: by mail-ua0-f171.google.com with SMTP id q15so64850926uaa.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hUO+pQ/cTpOviW79+CdzkS3UTwUE5zcFEUeL3VSU1dg=;
        b=RDnWiyyoDs/T+tNSqHbkO0KatMNteVP28J1iKsSNc9hneDM3MNvd7gvmMtAD5CI6Oi
         N4q9B7l1Yer+vckxF9eaw2rgejQ5js+DAZzBqD9IlZeVqbbX7ye/YcZ6ipZbYJUR100o
         63RZRNGcGsxpjQeHAg5dyxNcFpZXZVXwcaC4tOMRWT9qNeXgGg8g3Aiyqgmi8qKEANvZ
         GhpeK+gTvwmUP39edoTyqf/Fs9CyOu7rA+7al3NSaDqHqXbJ+vjbyg95sSXETcJ4QBUx
         PY1FhqB3TDo4C673a5t2H3sDNNBtliOAv/6l7AvKuFLjrm//4SOfUZ7riCOMwuECCuKo
         uYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hUO+pQ/cTpOviW79+CdzkS3UTwUE5zcFEUeL3VSU1dg=;
        b=ct50iSxNiDaWpHnz64S1MHqN/506Fym8d1GqcHRbgqE8rqlLFIs2O2EQ35z0Ef0c88
         FK+exCFPr/wALPic5e1Nv2AlEgikOjSovJu2m0gZtIV/YqENhnvIazSzXxjbd+3yJwXT
         BVOR3SVMMCHFc4fqHaY4JuSiwth+T0+bSmaaYrps+3Ztg3gEvQT1y+dBcrFMrgg55AYw
         UxWaU0l/sfFLreJCQRRS4lE5/DFBzkRtp8H6rYhBV1QAd+NPPLnvqkhHtNW9a7sb79+v
         LliSC/8cJOEoKAXlJSXmFmAIGqheVGagNG3tzgJoq2V+3xd3DJ5ib939rHg7qDHyuerS
         8hmA==
X-Gm-Message-State: AKS2vOxG8RdoFwh9iSE2vNMuGMGJ0a0ZxzPpOyA/DbEEWyir6dIJBBjV
        x+koT1dgEDwqpctFtIlIGspDhxsujAV+
X-Received: by 10.176.25.99 with SMTP id u35mr756592uag.16.1497305409571; Mon,
 12 Jun 2017 15:10:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.81.205 with HTTP; Mon, 12 Jun 2017 15:10:09 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 13 Jun 2017 03:40:09 +0530
Message-ID: <CAME+mvUrzVxpRdPDvA1ZyatNm2R27QGJVjSB3=KX85CEedMaRQ@mail.gmail.com>
Subject: [GSoC] Update: Week 4
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

Following are the updates about my ongoing project:

1. sync and status: The improvisions for the ported functions were
   implemented. I'm planning on floating a series patches,
   containing all the ported functions put together, but
   recently encountered some issue with the get_submodule_displaypath
   function, I haven't yet posted an updated version of the above
   ported function.The issues are now resolved. Hence, soon I plan
   on posting their updated versions.

2. deinit: As planned for the week, this submodule subcommand is
   ported from shell to C. But still, there are some tests, the
   ported functions are failing. Along with the updated versions
   of 'status' and 'sync', I'll also be posting a WIP patch
   about this subcommand ported.

3. summary: Porting of this subcommand is still underway. I choose
   to do the porting of this subcommand after deinit as it was
   smaller and hence porting this subcommand is still left.

4. count_slashes: A function was introduced in dir.h for reducing
   the code-duplication as similar functions exist in apply.c and
   builtin/show-branch.c

PLAN FOR WEEK-5 (13 June 2017 to 19 June 2017):

1. sync and status: Since the changes are ready, I plan to post the
   complete series of the updated version soon as a single series of
   patches.

2. summary: As this is still underway, I'll be finishing this submodule
   subcommand in the following week.

3. foreach: To unblock the conversion of this submodule subcommand,
   I'll be focusing on porting the original cmd_foreach, and
   will not be including the BUG-FIX patch here.
   An additional NEEDSWORK comment will be added to the ported function,
   stating the reported bug, and not resolving the bug in this patch
   series.

4. deinit: As mentioned earlier, there is still some debugging left for
   the ported functions. I plan to debug them and discuss the patch
   for further improvisions this week.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/

Thanks,
Prathamesh Chavan
