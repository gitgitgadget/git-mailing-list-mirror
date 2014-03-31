From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diff-no-index: correctly diagnose error return from diff_opt_parse()
Date: Mon, 31 Mar 2014 12:14:24 -0700
Message-ID: <CA+55aFyLu88bjKuSOrWs5fNX=QsFNo9F1T6wRvp_Ogy+PpX5CQ@mail.gmail.com>
References: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
	<xmqqy4zq5hoq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:14:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhfC-0006lH-MH
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbaCaTO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:14:26 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:51398 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaCaTOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:14:24 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so8581940veb.33
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VcaSVU62ea0S+UbxESPZPulXmUfaVdyS6qBje4bKZ7c=;
        b=q+Yam7GkgR8HKJSVGMioovKRcQIZNL/GYeqVfkgama9tLLlsn2lGgxR0mrLhpTYOpT
         mZ1266MalsYjctwED0sCfCQWMyYK/IUtXCN8EYghQ7XqPnTvARXdhLZfcAIUju+HFfTR
         U4q0OdBvlQdkNfk7VEPxsnZHat3qp6vUqN4GjN55UchQ6YUvD4sMUFt0rWsNySroeth5
         BKQt2wpVs3gYWoA8IiBVfEevLSKjP88UvuvbfJIxGISVkOvLRpO0ws/MLEI/dhVQNsmo
         PmMtFTHMM6YVbwf3WXLzQZFYDpA2hFAAFdCNg7VCMjYOLfB4101Hy5H0Y1kneetWlO5M
         WWKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VcaSVU62ea0S+UbxESPZPulXmUfaVdyS6qBje4bKZ7c=;
        b=ep7cKCOjHo+MaB+c20Nkgu4Ob+s6JTEQqc0TRIXsajWWN6zfyWImc87Q4zJd4BGSlN
         ntNW8Gj9lqv5ANa0u3snICQoeBZlEuGCQgNLMQSLSbM+ptv55yj9xL8rI5hZyPHwA6CF
         ve1O0WM+o/lY1u7kWDLAVn52Ybg98PAArn+bI=
X-Received: by 10.52.241.106 with SMTP id wh10mr20561172vdc.16.1396293264136;
 Mon, 31 Mar 2014 12:14:24 -0700 (PDT)
Received: by 10.220.13.2 with HTTP; Mon, 31 Mar 2014 12:14:24 -0700 (PDT)
In-Reply-To: <xmqqy4zq5hoq.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 3Qk83Ng_pg1W2O7Jby0uA3IDiRs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245513>

On Mon, Mar 31, 2014 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Instead, make it act like so:
>
>         $ git diff --no-index --color=words a b
>         error: option `color' expects "always", "auto", or "never"
>         fatal: invalid diff option/value: --color=words

Thanks,

           Linus
