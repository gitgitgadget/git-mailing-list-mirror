From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Forgotten declaration of function path_name() in revision.h?
Date: Wed, 16 Mar 2016 14:52:03 -0400
Message-ID: <CAPig+cReEC1swN8oyD68SqHAJhV2i1_CGEO25sJfA-4gA7jP0w@mail.gmail.com>
References: <56E9A07D.3080508@redhat.com>
	<20160316184853.GA32615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Petr Stodulka <pstodulk@redhat.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:52:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agGYE-0006a6-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbcCPSwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:52:06 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36387 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcCPSwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:52:05 -0400
Received: by mail-vk0-f54.google.com with SMTP id c3so73785882vkb.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=6u3hT7jbXqwUDuVw/MtGzL7ggco3kMJTBky+T9cfnRU=;
        b=ixlMJdLNScMqnRnmuBDCUhgvW7+hRu/XsPVsHlsOrhe3JS0NPtFUlg/MzemZ8GN3yM
         KVNq6OTLdmzlbeA41e2YUqPLiXti0oYKmd6DyznVxHAId8pBU50NZnTFM915PJtRCRBB
         Sk17KUafFbnpVNYNCxpNpni3sZWSXwvNkf3Ya7/SzyEAE6BAwCRuMFp742hW1QFyRPtI
         z0xrZqLPvOlHwLfLVBAM9iyOQH69RIF9gPk+VqADaXNMjr5Wf8ERCfMJgsWtEiepEdfk
         FFIZR7tGTYLZKLQOUNvcVaF489r68jrpOalNO9VmQak5+N5UOoAKc7Ido/OAsULIv/6/
         BSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6u3hT7jbXqwUDuVw/MtGzL7ggco3kMJTBky+T9cfnRU=;
        b=iE4NsOAKfK10DmhCiZpvbsej+QHZ9uXmyNO5sL+gTy0aM/nJghOyUiK67QovHrXgZ4
         UEhPPUqM1wWVUH9xgW+mvwfg7p/NzOHwA3smN/qplYBS0KUsTnmPBXlTfdVSy3Ftsy/Q
         nePCOTTmokXiwyHluDJvXOkj/02aJkZRjz02ezZk/U1GQ0Nd+TfjgPnsSg69TDGestxJ
         nKi1EGitcmpfHG6GbUnp4Wc5RlF+0NQHv7cGvYZofy+/kf90g3hYpRfRHfg5CzKi/p7P
         Jnweq76u/baCdL3cNuB3nGt//mq7Q6lOQPxdj+qamkqQzsC2GTGnuG5heglW/UxhqGgM
         avXQ==
X-Gm-Message-State: AD7BkJJWJtlTxZZHe13nLqkkVm8zdH/JlwisraSxTtztcMPfLAaPChLW5s+0NzjIFjRiB4f2H0NiAB7NpDdOSA==
X-Received: by 10.31.150.76 with SMTP id y73mr6657755vkd.84.1458154323455;
 Wed, 16 Mar 2016 11:52:03 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 16 Mar 2016 11:52:03 -0700 (PDT)
In-Reply-To: <20160316184853.GA32615@sigill.intra.peff.net>
X-Google-Sender-Auth: Fl-1WQYfvNraY5RJdHyfpt2D1Ek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289017>

On Wed, Mar 16, 2016 at 2:48 PM, Jeff King <peff@peff.net> wrote:
> It makes things easier on the maintainer if you format your patch such
> that "git am" can apply it directly. Use scissors like:
>
> -- >8 --
>
> to separate the patch from anything that should not go into the commit
> message (rather than "=====..." as you have here).
>
> Drop the "From " line which says nothing (it is an mbox separator, but
> we are already inside a message).
>
> The rest of the headers do not hurt, but are generally redundant with
> what is in your email header (though in this case, the Subject is
> different, so you would want to retain that).

Also, Signed-off-by: is missing.
