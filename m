From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git add -i: allow list (un)selection by regexp
Date: Tue, 2 Dec 2014 19:08:46 -0500
Message-ID: <CAPig+cSAUkG7APutRcb3AG1hLCBQACThfDBi-p75CSk_UsSK7Q@mail.gmail.com>
References: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
	<xmqqiohvqqqv.fsf@gitster.dls.corp.google.com>
	<DB3PR04MB2509E51F1DE708549483845EB7A0@DB3PR04MB250.eurprd04.prod.outlook.com>
	<xmqq8uiqm081.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Aarni Koskela <aarni.koskela@andersinnovations.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"akx@iki.fi" <akx@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:08:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxUy-0005Z6-77
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 01:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933509AbaLCAIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 19:08:48 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:47009 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933489AbaLCAIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 19:08:47 -0500
Received: by mail-yh0-f52.google.com with SMTP id z6so6513078yhz.39
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FcnS4rJPG0RSToXnu4ZYJjRcm/xMNR9gSMZsHWmpMdg=;
        b=MVUHMBm61gxUgx/HjToiyw1RbJdo7PNQ3PkEEyVFC138eKZyeV/KyQ2C27CrLgPGYK
         saIxxAdDk1+tdDk6rNtNuCaH0n4Aei/O8m0zinZNn/SSsBMxU10Zo0ul0T/0Pzk6WJ2H
         fwVtz07fy2pK8PhfGaWoLOZlIF/Q5qgh6ozGuKm+9UHDkpZGwlOkwFnUickd0JIbeFWS
         85se+/BrgYuI6VyQWW/mkp37G2XoVZnGFiSAvvLTYZuyXWkSggiFDPL3mB4L/fu9ikrd
         WI+paCj3F8Oa7c3TAGIOlWXqRsLbdD+YUVqGjLIK8xHJyuacrywX20M3DlGzilMYuIoq
         J8Zg==
X-Received: by 10.170.134.72 with SMTP id a69mr2950269ykc.103.1417565326716;
 Tue, 02 Dec 2014 16:08:46 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 2 Dec 2014 16:08:46 -0800 (PST)
In-Reply-To: <xmqq8uiqm081.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: wW_4_2QHr0v5qMMZqDAvXe_DFzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260606>

On Tue, Dec 2, 2014 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Aarni Koskela <aarni.koskela@andersinnovations.com> writes:
>
>> From 9096652a71666920ae8d59dd4317d536ba974d5b Mon Sep 17 00:00:00 2001
>> From: Aarni Koskela <akx@iki.fi>
>> Date: Tue, 2 Dec 2014 13:56:15 +0200
>> Subject: [PATCH] git-add--interactive: allow list (un)selection by regular
>>  expression
>
> Remove the three lines from the top, move the content on Subject: to
> the subject of the e-mail.
>
> Other than that, everything I see in this message is very well
> done.
>
> Thanks, will queue.

This change deserve a documentation update
(Documentation/git-add.txt), does it not?

Tests too, perhaps (assuming other git-add--interactive selections
selection modes are already tested)?
