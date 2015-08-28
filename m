From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Fri, 28 Aug 2015 17:26:51 -0400
Message-ID: <CAPig+cSr75EQxhSgxMAnTT-L7T=nXUNSSk6vL+gT1HVYWU7J9Q@mail.gmail.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 23:26:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVRAl-0003Vp-OF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 23:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbbH1V0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 17:26:53 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33320 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbbH1V0w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 17:26:52 -0400
Received: by ykdz80 with SMTP id z80so28418397ykd.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=a/PFwDi8B/3p7w820dmB4X/vaUaZjIhJY1H8XitBPfo=;
        b=Dfll14sydNkALaFjYT5UaE6YlnZBaucd5ir4yD35QnUZweXnyv/40E3a3Wh6ZzIz0+
         4dWLsN257BdGhrT4mYZ6ct2J8K+q7IinCVLE9oAT6qgj6Jp+elErzGnVUMMLZ60m6HOx
         sy6Ph9pcAKQHSo8lvDwvG04iIrpUwWCq4R2+EU5rZzYwVbFwhCNlOKQ4nlWnLpKEI3eb
         tW3JMPjzFiqvMx6ZidHgsIH9+XQxaCpHZ0L9GW5m9i1WmdjEWibGr48Os3lUDHX8VrJp
         8u81BWJ9zc8j0+PHHl153Yxnw/x+nux2lb1FFen0Y1rlD/ON0VbYMqzYbkwyx8SOnZta
         52Og==
X-Received: by 10.129.134.3 with SMTP id w3mr10485414ywf.48.1440797211400;
 Fri, 28 Aug 2015 14:26:51 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 28 Aug 2015 14:26:51 -0700 (PDT)
In-Reply-To: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: R_jRqcslrmw3LaAy8ZwOn65c-QE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276762>

On Fri, Aug 28, 2015 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [New Topics]

Hmm, Duy's patch series to fix "git clone foo" when 'foo' is a linked
worktree[1] doesn't seem to have been picked up. Was it lost in the
shuffle?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/273982/focus=276346
