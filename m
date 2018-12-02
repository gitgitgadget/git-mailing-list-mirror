Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01DF211B4
	for <e@80x24.org>; Sun,  2 Dec 2018 17:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbeLBRha convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 2 Dec 2018 12:37:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:30990 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLBRha (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 12:37:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wB2HbQv6056470
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Dec 2018 12:37:27 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Cameron Boehmer'" <cameron.boehmer@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com> <87woosukkm.fsf@evledraar.gmail.com>
In-Reply-To: <87woosukkm.fsf@evledraar.gmail.com>
Subject: RE: [RFC] git clean --local
Date:   Sun, 2 Dec 2018 12:37:18 -0500
Message-ID: <004101d48a65$afb0da40$0f128ec0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJ1hCP017+SZX+FjnjTbXBWN6TbuAEzMJ4GpCAosSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 2, 2018 8:26, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Dec 01 2018, Cameron Boehmer wrote:
> 
> > 1) add a new flag
> > -l, --local
> >     Do not consult git config --global core.excludesFile in
> > determining what files git ignores. This is useful in conjunction with
> > -x/-X to preserve user files while removing build artifacts.
> 
> Or perhaps a general flag to ignore configuration would be useful for such
> cases, see https://public-
> inbox.org/git/87zhtqvm66.fsf@evledraar.gmail.com/

Would something like git clean --exclude=file-pattern work as a compromise notion? Files matching the pattern would not be cleaned regardless of .gitignore or their potential preciousness status long-term. Multiple repetitions of the --exclude option might be supportable. I could see that being somewhat useful in scripting.

Cheers,
Randall


