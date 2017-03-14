Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5A6202C1
	for <e@80x24.org>; Tue, 14 Mar 2017 07:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdCNHpA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 03:45:00 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:35739 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdCNHo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 03:44:59 -0400
Date:   Tue, 14 Mar 2017 08:44:50 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
        <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <tskgutqgpyszzedvyfra@prol>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1489477491;
        bh=bEBFvQVhQHlrHgh1I+mQTAdvxDaF9cipXbsLKrQGyks=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=G5SxjzM3PlcLTksedqGv5u6kOdetEzJrCa6GJEXK1g7OOzUUMbwa+jm/jSL+dI/Jv
         4tTj94S3Gk48+9Pa1pbMNJ3+xS7TElcLxsiZGYdqLGYCxIshpAptxhv/Tghk99BJty
         MQi4QMqc9iF72S+mwA8jj8QsTQNzxvmvo7ixGGXM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 22:31 Poniedzia=C5=82ek 2017-03-13
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 13.03.2017 um 14:23 schrieb Zenobiusz Kunegunda:
>> Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> [a26bc613a64ac2c7ee69a50675e61b004a26382d] pretty.c: make git_pretty_for=
mats_config return -1 on git_config_string failure
>>
>> This is what I found with git bisect
>=20
> Strange, I don't think git_pretty_formats_config() is even called by git=20
> status.
>=20
> Ren=C3=A9
>=20
>=20


a26bc613a64ac2c7ee69a50675e61b004a26382d - is actually working revision

The question is - is git history linear enough for git bisect to produce an=
y useful result? Gitk produces rather complicated diagram. Especially for y=
ear 2014. I'm not sure about reliability of this method. Or maybe it should=
 be used in a specific way I'm not aware of. If you have any advices how to=
 use it in this specific case, please let me know.=20=
