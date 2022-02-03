Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10931C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 13:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbiBCN1R convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Feb 2022 08:27:17 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34047 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiBCN1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 08:27:15 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 213DRDtw045875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Feb 2022 08:27:13 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "=?UTF-8?Q?'Jean-No=C3=ABl_Avila'?=" <avila.jn@gmail.com>
Cc:     <git@vger.kernel.org>
References: <016401d81547$728834e0$57989ea0$@nexbridge.com> <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com> <220203.86sft05kzm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86sft05kzm.gmgdl@evledraar.gmail.com>
Subject: RE: [Question] Translation Dictionary
Date:   Thu, 3 Feb 2022 08:27:08 -0500
Organization: Nexbridge Inc.
Message-ID: <02f101d81901$c1ac8400$45058c00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHny4N9HGuOldLgj1yDpZlahXxp4QKviEmMAKay+umsR7NUYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 3, 2022 4:55 AM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Feb 03 2022, Jean-Noël Avila wrote:
> > I guess not all git translators are subscribed to the mailing list, as
> > they mostly interact with Jiang. I put them in cc.
> >
> > For French, I try to maintain a glossary of terms in the header of the
> > `fr.po` file, available here:
> > https://github.com/git/git/blob/master/po/fr.po
> 
> I started trying to come up with something similar for the Icelandic translation I
> plan on getting to any day now (for ~11 years and counting).
> 
> I think it would be a really good addition to git to move this list into a built-in or an
> option for "git help", something like:
> 
>     git i18n-terms
> 
> Or:
> 
>     git help --common-terms
> 
> It would help users that use a non-English a lot, since they could use it as a
> reliable cheatsheet, and it would clearly help translators, since it could be one of
> the first things they'd translate, to anchor themselves when it comes to
> translating blob/tree/commit/tag etc.
> 
> If you're interested I can help you come up with that. Basically it would be some
> "static" array with that table as C code with strings marked with N_(). We could
> then add optional explanations as in
> gitglossary(7) (and even eventually generate that documentation from that
> code).

Yes, I would like to investigate doing this. I have some experience with different translation approaches, so it does make sense to me. The question is where to start. From a framework standpoint, it would be nice to have the terms externalized and searchable (as in git glossary [term]... or perhaps more completely git glossary --grep=term --language=fr --iso=fr_CA [term]...). I can also see some provisioning for phrases, "upstream remote" comes to mind as one that gave me a headache earlier in the week, and potentially usage - in Jean-Noël list, prefacing "to" to a term implies it is a verb rather than a noun but we might want to consider a more normalized approach to managing usage, bearing in mind that this is a very large "rabbit hole". I would even suggest that gitglossary(7) might ultimately be deprecated particularly on systems without 'man(1)'.

Help would definitely be appreciated in getting this started. I have a topic branch at github where I am planning on keeping this stuff visible.

> 
> > Le 29/01/2022 à 20:35, rsbecker@nexbridge.com a écrit :
> >> To the git translators.
> >>
> >> I was wondering whether there is an official translation dictionary
> >> for git-related terms. At times, I am asked to provide presentations
> >> with an initial translation to companies in various parts of the
> >> world. It would be nice to be able to follow the official set of
> >> terms used in git translations. Does such a thing exist?

Regards,
Randall

