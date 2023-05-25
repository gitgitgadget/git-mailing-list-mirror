Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75640C77B7A
	for <git@archiver.kernel.org>; Thu, 25 May 2023 16:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjEYQip (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjEYQin (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 12:38:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3C2195
        for <git@vger.kernel.org>; Thu, 25 May 2023 09:38:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA24119C6D;
        Thu, 25 May 2023 12:38:39 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=1hoXMy77LJD8FxbLQwvsoCnStrrtx6Nl3hUEEsf
        Ppq4=; b=NC+Yds434kHsOmxMy6YOXOMEarmL6YewiY4HIxhljnZHjp3on1awcwa
        pIvy0I/NGLaweh83cvg5FZVDH8ToLA8pvbfGfEho6gDHgwx3gVWxrm/WYdgQzqyH
        9tItAeHRGU3o4cshsv9IiWNIs5UOR90grtHrbGtL84AkrUeq5zX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1F7B19C6C;
        Thu, 25 May 2023 12:38:39 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B450719C6B;
        Thu, 25 May 2023 12:38:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 25 May 2023 12:38:32 -0400
From:   'Todd Zullinger' <tmz@pobox.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.41.0-rc2
Message-ID: <ZG-PCFEIDURrRVLe@pobox.com>
References: <xmqqedn5fluv.fsf@gitster.g>
 <022501d98e94$68c671c0$3a535540$@nexbridge.com>
 <ZG6gbN04DfldoadD@pobox.com>
 <025c01d98f17$f4b3bca0$de1b35e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025c01d98f17$f4b3bca0$de1b35e0$@nexbridge.com>
X-Pobox-Relay-ID: 982B5FC8-FB1A-11ED-97E3-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rsbecker@nexbridge.com wrote:
> Setting NO_TCLTK=NoThanks inhibits processing of some .po files. I do not
> know whether that is intended. Can you advise

I don't used the option, as the systems I build for have
tcl/tk, but I don't see where setting that would have an
effect on .po files (apart from those in git-gui or
gitk-git, of course).

-- 
Todd
