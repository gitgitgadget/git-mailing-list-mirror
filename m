Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73392018B
	for <e@80x24.org>; Wed, 22 Jun 2016 23:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbcFVXt2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 19:49:28 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32872 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcFVXt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 19:49:28 -0400
Received: by mail-vk0-f48.google.com with SMTP id d185so83689136vkg.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 16:49:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P5KkTQm7+cAGEyIBK8CN8NOYpPJCDrHsum6tsRQVOYU=;
        b=yBuNQX+XSTnwu4rIMUgN4hBJCeqoPGUTToLWvtvTPCiuRuqKSh1AFZUx330QP5cu6d
         cZVYN24hiGjNiaAsooR1MH8Onh1W8Dp9/Yu2UwEq4zI3OBDu3cS+JRnuc7xdLaFlKycg
         1BfZ/mvi+HlpguysPBCYlYyjpiH9oSiO4wz6xLfAlxS4RD6mDIi6kKS8MHi8eDQX7vgf
         MBtLMhL/FJnqAqehSCxFtHp0r84SgIeloKPOXYHh8ZdFzSvaKve5jST6k1Fr3gXhl4s6
         PqN5WixFxj20RawgjmtJ1nuDsDduDRT99mp3fMayIvzgOr9aiTcnxbHq23ZnxTvBaN0Y
         1e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P5KkTQm7+cAGEyIBK8CN8NOYpPJCDrHsum6tsRQVOYU=;
        b=SI0xm6SktwPLPjCrGB4FRnjP0yKZn2An4ffOFNEvoCj0zHluKEE4W0hVuzIiRuv97x
         h/bRTryqfrL3ZwtBh94EtT0TcTCbzNacKr2xq0p1TaWknlyVjsLJY8uwbuNkQ0S21U9z
         dHy0w3LdtPPyb4b47jbuUvUySUPNyHVBrJTiPVXQKAfBfL6OihVwFclJJrATxHbmUCTf
         9P+ZyESzKNW9WJfhNSBfvyt7npRovq0mjYRxH12Wuxd/wBShdiz1uDpBlvUkisTFTSSs
         dv1vm1xxcUux/i1MNbRCp+syZXf8/bunr21gp6EWglii7pbR0ZZ7RakALN9Uxv7Eu14p
         w/0Q==
X-Gm-Message-State: ALyK8tKb4IR9N1/tCjb0oeN/viScmGlojWg1N0W0DZKOuiXYTyzW6BehC9eIX+EgcggOG4GS3xusfGC2JcJEbg==
X-Received: by 10.31.7.78 with SMTP id 75mr14972464vkh.74.1466639367131; Wed,
 22 Jun 2016 16:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.15.65 with HTTP; Wed, 22 Jun 2016 16:48:47 -0700 (PDT)
In-Reply-To: <xmqqmvmckebv.fsf@gitster.mtv.corp.google.com>
References: <20160622230024.24034-1-emilyxxie@gmail.com> <xmqqmvmckebv.fsf@gitster.mtv.corp.google.com>
From:	Emily Xie <emilyxxie@gmail.com>
Date:	Wed, 22 Jun 2016 19:48:47 -0400
Message-ID: <CAAin2AQR3yP7X=NLQ=9+0QGJZMCN7=xbpZ=H7r56RvvBfLJSEg@mail.gmail.com>
Subject: Re: [PATCH] pathspec: warn on empty strings as pathspec
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Awesome. Thanks, Junio---this is exciting!

As for step 2: do you have a good sense on the timing? Around how long
should I wait to submit the patch for it?

Otherwise, let me know if there is anything else that I need to do!

- Emily
