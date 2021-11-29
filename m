Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B493C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhK2TaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:30:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:16145 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351341AbhK2T2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:28:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216753170"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="216753170"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:20:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511825428"
Received: from mkabdel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.11.182])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:20:10 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
In-Reply-To: <20211129172618.GA26651@dcvr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
 <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
 <20211127195231.GA4636@dcvr> <xmqqtufx5p19.fsf@gitster.g>
 <87mtlnjhj6.fsf@intel.com> <20211129172618.GA26651@dcvr>
Date:   Mon, 29 Nov 2021 21:20:00 +0200
Message-ID: <877dcqkbvj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 29 Nov 2021, Eric Wong <e@80x24.org> wrote:
> Jani Nikula <jani.nikula@intel.com> wrote:
>> The moral of the story is that you should always offload the header
>> parsing to some tool or library designed to do that.
>
> It's a bit much for common cases with git-send-email and
> reasonable MUAs, I think.

I think you can have unreasonable MDAs in between, though!

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
