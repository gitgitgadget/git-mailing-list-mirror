Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA74C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 23:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhLIXLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 18:11:11 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16626 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhLIXLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 18:11:10 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B9N7Vcw002066
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Dec 2021 18:07:31 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Joel Holdsworth'" <jholdsworth@nvidia.com>
Cc:     <git@vger.kernel.org>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>        <20211209201029.136886-4-jholdsworth@nvidia.com> <xmqqh7bho0to.fsf@gitster.g>
In-Reply-To: <xmqqh7bho0to.fsf@gitster.g>
Subject: RE: [PATCH 3/6] git-p4: Removed support for Python 2
Date:   Thu, 9 Dec 2021 18:07:26 -0500
Organization: Nexbridge Inc.
Message-ID: <01db01d7ed51$8ba5c5f0$a2f151d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGEBha9kcKLYJkBk7w9RvIZH6yURAFlniYEAUh6qhWsvSXTMA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 9, 2021 5:45 PM, Junio C Hamano wrote:
> Joel Holdsworth <jholdsworth@nvidia.com> writes:
> 
> > Subject: Re: [PATCH 3/6] git-p4: Removed support for Python 2
> 
> "Removed" -> "remove".
> 
> Losing unused/no longer usable code is good.
> 
> > Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> > ---
> >  git-p4.py | 89
> > +++++++++++++++++--------------------------------------
> >  1 file changed, 28 insertions(+), 61 deletions(-)
> 
> In these 28 new/replacement lines, there is nothing that deserves any
> mention in the proposed log message?

Just a reminder that Python 2 is the only option available on some older
(still supported) platforms for the next year or so.

Sincerely,
Randall

