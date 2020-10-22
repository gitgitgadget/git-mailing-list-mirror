Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086CCC388F9
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB0A24656
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509912AbgJVT0J convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Oct 2020 15:26:09 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23774 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507583AbgJVT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 15:26:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 09MJPwoa021782
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Oct 2020 15:25:59 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        "'Frank Illenseer'" <illenseer@altair.de>
Cc:     <git@vger.kernel.org>
References: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com> <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com> <20200925222801.GC1392312@camp.crustytoothpaste.net> <DM5PR03MB28262362A9D3B0EDECBE6106B50A0@DM5PR03MB2826.namprd03.prod.outlook.com> <DM5PR03MB2826382CD1A5AA8F3ED60FD9B51D0@DM5PR03MB2826.namprd03.prod.outlook.com> <CAPig+cSbUjb0=TRGdpdTV9XyVbRad-f-_Ypw72wVE0OBR6TaQg@mail.gmail.com>
In-Reply-To: <CAPig+cSbUjb0=TRGdpdTV9XyVbRad-f-_Ypw72wVE0OBR6TaQg@mail.gmail.com>
Subject: RE: Git Alias not working in worktree
Date:   Thu, 22 Oct 2020 15:25:52 -0400
Message-ID: <005c01d6a8a9$2b7007b0$82501710$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJWIoyk1x1jwCRvZzYMkKlQaXQlxwE1S9JlAeadExACswOMwQLfa3zYA2yMwTOoRDU5oA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 22, 2020 3:07 PM, Eric Sunshine wrote:
> To: Frank Illenseer <illenseer@altair.de>
> Cc: git@vger.kernel.org
> Subject: Re: Git Alias not working in worktree
> 
> On Thu, Oct 22, 2020 at 8:06 AM Frank Illenseer <illenseer@altair.de> wrote:
> > Does anyone have any idea as to why the alias definitions from the
> > config of a worktree is not working? - I would still be interested in
> > a solution to get this working.
> 
> For reference, the original question was posted in[1], and brian
> mentioned[2] that he would take a look at it. brian, did happen to investigate
> this at all?
> 
> [1]:
> https://lore.kernel.org/git/DM5PR03MB2826C04CC5AAF3B61BDDAFE2B536
> 0@DM5PR03MB2826.namprd03.prod.outlook.com/
> [2]:
> https://lore.kernel.org/git/20200925222801.GC1392312@camp.crustytooth
> paste.net/

Does the alias work in your main working directory and but not in the worktree? I'm trying to figure out how you would specify a worktree-specific alias in the first place since it is shared with all worktrees of the main clone.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



