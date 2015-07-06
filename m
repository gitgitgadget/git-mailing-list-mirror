From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Mon, 06 Jul 2015 10:54:28 -0700
Message-ID: <xmqqfv5118a3.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<xmqqa8v92qdf.fsf@gitster.dls.corp.google.com>
	<CAPig+cTfkDqSDRqDjA=CNkT1c7Fo0zaLiwi2bAbCLZxPHi5=Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAbD-0004T5-7C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbbGFRyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:54:31 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38822 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbGFRya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:54:30 -0400
Received: by igrv9 with SMTP id v9so121547786igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kAmlFoVLQ4FhHviefXhcCDWG28+igWhYKOReMRdYhpA=;
        b=F/E4qWefakDSluLB8UDnxqO8jyy7+SkuahP7CTKO1GN7/kXrgkM5wStyQniv5uz29m
         KAIw777p+MF5J+4YwCZ8f9TzLWmG0lzINP938M7lBH3mZm9ZcarAurAWWk+86p358tUy
         2mVh17brb+bxcGudJpvI48giR15Yd3HsXlB2x10DzvEk8nFJRlrhvqQMG3ctB2+YpbCF
         42qCSEvpGDF35y5828ZA7SIOmG0TVWzRbsBf9iJL//Ku/fnPvhajO58Fxu73QJUqhntU
         DeMgO6z6iibIbTqNHL2ApAAxnmyhm+odPwu7OOewOfsZ+l9UfQMKgwp+DU7BDzSe6sG2
         ewLg==
X-Received: by 10.107.12.143 with SMTP id 15mr79865iom.75.1436205270286;
        Mon, 06 Jul 2015 10:54:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id rr5sm10125150igb.7.2015.07.06.10.54.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:54:29 -0700 (PDT)
In-Reply-To: <CAPig+cTfkDqSDRqDjA=CNkT1c7Fo0zaLiwi2bAbCLZxPHi5=Bg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 6 Jul 2015 13:24:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273442>

Eric Sunshine <sunshine@sunshineco.com> writes:

> How about this instead: prefixing with "As originally implemented",
> with a couple s/is/was/ thrown in...
>
>     As originally implemented, creation of linked-worktrees was
>     accomplished via `git checkout --to <path> <branch>`, and cleanup
>     of leftover administrative files, after `<path>` is deleted, was
>     done with `git prune --worktrees`. However, a recent unrelated
>     change to `git prune` led to a discussion that concluded that
>     worktree-related maintenance functionality didn't belong in `git
>     prune`.
>
> Is that sufficient to clue in the reader that "checkout --to" is not
> final form,...

Yeah, I think that is a good way to address my concern.

The current draft release notes to 2.5 mentions this feature as
experimental and warns that its UI is bound to change.  We will
ship the upcoming release with "checkout --to" and the more places
we advise the users that this UI is not final, the better.
