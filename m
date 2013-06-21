From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 16:35:49 +0530
Message-ID: <CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzAu-0007Cw-9y
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049Ab3FULGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:06:30 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54932 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3FULG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:06:29 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so18227852iea.25
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=slhbuyVYYUwswCpQQmQVcU5nXxF4I1xt8JZAiTqtcao=;
        b=D+3eJ5mS6LJtC7hMLcl9E26qKScJFbyu7JrISf1T47Cv/lwbh7CbF9mY0tKAEv8eip
         CMpvwhJ60GJsHgwNQJu3fYFILRrNvVxLXeaO55l4mQH+Dh4S/wTo2KGah5B+Wug5iKC5
         2thhsbqMy0zRJ/7EF+UuRX7Kq/B4LRBgUmRtbcyTpkXX4RjyiwhBj6vBp50xxXq+wcKR
         7ZOmD2eaJpKTu7i65da3XLXQK4AURrTdg+DYVJLFkyHd6oDK18v8jk2mWz5KiPJtxZWO
         RMNjzgIWe2rfrt+QK6vai92aS2PjY89DdzE6BHzAVr0jiv3CmaN8mIKvyIfaUIgqCISK
         QUAQ==
X-Received: by 10.42.190.74 with SMTP id dh10mr5767732icb.35.1371812789548;
 Fri, 21 Jun 2013 04:06:29 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 04:05:49 -0700 (PDT)
In-Reply-To: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228593>

Junio C Hamano wrote:
> * rr/triangle-push-fix (2013-06-20) 9 commits
>  - push: honor branch.*.push
>  - SQUASH??? fix git-config push.default description
>  - SQUASH??? minimum "simple" safety fix-up
>  - t/t5528-push-default: test pushdefault workflows
>  - t/t5528-push-default: generalize test_push_*
>  - push: remove dead code in setup_push_upstream()
>  - push: change `simple` to accommodate triangular workflows
>  - config doc: rewrite push.default section
>  - t/t5528-push-default: remove redundant test_config lines

Give me some more time to perfect this.

> * rr/rebase-checkout-reflog (2013-06-17) 8 commits
>  - SQUASH???
>  - rebase -i: use a better reflog message
>  - rebase: use a better reflog message
>  - checkout: respect GIT_REFLOG_ACTION
>  - status: do not depend on rebase reflog messages
>  - t/t2021-checkout-last: "checkout -" should work after a rebase finishes
>  - wt-status: remove unused field in grab_1st_switch_cbdata
>  - t7512: test "detached from" as well
>
>  Waiting for a reroll.
>  $gmane/228271.

Please pick up $gmane/228371.

--
Four topics are awaiting review (they're important to me in this order):

- rr/for-each-ref-pretty at $gmane/227057.
- rr/describe-contains-all at  $gmane/228278.
- rr/mixed-case-aliases at $gmane/227959.
- rr/completion-word-diff at $gmane/228305.

One topic is stalled:

- rr/pull-autostash at $gmane/227796.
