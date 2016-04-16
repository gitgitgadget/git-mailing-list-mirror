From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: possible to checkout same branch in different worktree
Date: Sat, 16 Apr 2016 07:51:48 +0700
Message-ID: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
References: <CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com>
 <xmqqk2jydgu8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:52:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arETJ-0005Z6-1t
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbcDPAwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 20:52:20 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34017 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbcDPAwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 20:52:19 -0400
Received: by mail-lf0-f51.google.com with SMTP id j11so163121623lfb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LLLcOjRM/rmWu85+AR6QhwMZzd8wymvh2xqTiHGaS3U=;
        b=Qq1OLct1JdZGXs4Z3ftRh79a2hhiE8cvJWtyLhetNhhXmNJYfcrNVIRzWnRasI/rYQ
         2Os9DCUrK7I+Xa8BH8U1nxm6z8WxEgPEh07eiQsogN9H92RN4i5i3mPfkJIO5DaUCYLw
         U69N7G5L+MQ6ZWdHzYpm+a/qdXO4eDx0q9VllxqIbyCJZ/oyedeNUj1sZbQanRr8Qm8S
         fHWAVyhMK2xwJSIbmuFMSYk5fvl3rPMk8S9UOP+RaQLMEhzLVRHDf355FcILZlNT9Hm7
         +0RrzKD4hJw2fE1/NruMGAqSQsInoUvZVRyxkmg0EqUQNdqu1qEOA7BLww/fxTLW8Jio
         /QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LLLcOjRM/rmWu85+AR6QhwMZzd8wymvh2xqTiHGaS3U=;
        b=Zjk2SM9BKdRKtCJWvu7nfco4pZ0/llEEui/qouV7dNtyBTxbrL0dil0mxifXNY538c
         RTn3yKWSPAU1o2Vx/UxL0hEfOtXNqENjdYVmOhHMmyOHA5gnM1xrjXYJRjkxGUQgHLN2
         L735IB+cLa2IHXcXqHozgOx4trKz7EqWR8Li2t2UcKZIGUANSThiKCSghpSCAyPZaMQ8
         aAxPzGd2wQhMsQ8PaZSXCo95HmROwOZBpJzSsWQV4DhBj70FtcXqmtUTxc5WOT9bLMpj
         /0foSovj/rabpCxZca1TcfT7VshsUMKibe6IR6SIyAb6dftxmkKdqNPxOp68Ehjcv4kz
         4HeA==
X-Gm-Message-State: AOPr4FUDco0tMml4wLrAOX2ySfSsn6Tx0glac2YnzIWf0hT8uK4wQJ19ZYp1qHh+xayMk3hFKcAO8d5sKNxgKw==
X-Received: by 10.25.152.147 with SMTP id a141mr10163973lfe.83.1460767937922;
 Fri, 15 Apr 2016 17:52:17 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 17:51:48 -0700 (PDT)
In-Reply-To: <xmqqk2jydgu8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291712>

On Fri, Apr 15, 2016 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Reto Habl=C3=BCtzel <rethab.ch@gmail.com> writes:
>
>> the checkout command prevents me from checking out a branch in the
>> current worktree if it is already checked out in another worktree.
>>
>> However, if I rebase the branch in the current worktree onto the
>> branch in the other worktree, I end up in a situation where the same
>> branch is checked out twice in the two worktrees.
>
> I agree that any end-user facing subcommand like "git rebase", even
> if it is not "git checkout", should refuse to work on and update a
> branch that is checked out elsewhere.  Otherwise it will end up
> causing confusion.

I agree. I suppose we need same treatment for git-push? A push can be
rejected if the pushed ref is being checked out. Suppose HEAD is in
the middle of a rebase (or am), it fails to detect ref name (and thus
checkout state) the same way here and we definitely do not want "git
rebase" to simply overwrite whatever is updated by the push request.
--=20
Duy
