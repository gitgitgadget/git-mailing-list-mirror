Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF952018B
	for <e@80x24.org>; Mon, 18 Jul 2016 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbcGRQvq (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 12:51:46 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35039 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbcGRQvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 12:51:45 -0400
Received: by mail-qt0-f181.google.com with SMTP id x25so14869387qtx.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 09:51:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pTA+Zs6/jkZLIMo4ePWd7ioes/yuioAZycTVln4jy28=;
        b=dJWdM+aLFNNT2MHiotwCFfQ+qP9qTQ1pEdxrXHlk4MIPKrE9qeAi1yf7hXWnbryrDv
         t+tO32Et+sq7znD3PB+IPuq6zudoa7G9Fr7ncCeY9TTvoDIMcy/HrKufhnb1SDQXgqU2
         +2oNRmT7KWEPEDEW/q+CDElKLtm4zG9nTynjqCzt2e1ChndcEo5fRtncQvbZvfjhedr/
         e8Y0ogm5sgs5fnludi1aWVGQUGOYsopr6CIBI6z389Fzw7KR6UmNPSd+l1f5fvEEL7Lq
         MqjwbdZJMuBl7TBk6ciJQpXus+nc1V4WKO0DBHfX1Y+BV0EKSYuMxM3hXrRbeU/s1jkr
         yPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pTA+Zs6/jkZLIMo4ePWd7ioes/yuioAZycTVln4jy28=;
        b=cV+6hP015g8tXSMPAiWpyqYXs85BAO4oBjYHnaeXj4OulLo7NkruoYk29OBSlfLxLX
         p1YZOMMiiScJafs4dZRYp6rHxRfLSgulEp4pvrfiyTaSSx7SRW5sT6gxnZzfGIpwP+s1
         b2xJXv8LybBrs2buA3vyLi+Ixa8uZF5R7Th1bR9+LpO3jGQyRHQPzS6i4+ZnPVsS3HCv
         mlgs+FXEqyOhurhJfWge/x/Nu8c/pPiJ6CFjbuIF4kJwDDWj+LiEoskSrIuW2T9vYOAR
         fUaAflBSnYiWxst352choTKa+ojAuFK0TYgdJSLNy+ICdUEUzXeSUmUu0Y7e2bzj8C3I
         DI0w==
X-Gm-Message-State: ALyK8tJ7FjMluhGwZHk+gEKabJHM9W2jAFI4sBUwl6F1/6UkT3AN4Q/iBGAjD5U9g2zN93fcKAKLC086YVvW6g==
X-Received: by 10.237.36.38 with SMTP id r35mr54201772qtc.3.1468860703241;
 Mon, 18 Jul 2016 09:51:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Mon, 18 Jul 2016 09:51:23 -0700 (PDT)
In-Reply-To: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Mon, 18 Jul 2016 18:51:23 +0200
Message-ID: <CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Herczeg Zsolt <zsolt94@gmail.com>
Cc:	Git <git@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 3:48 PM, Herczeg Zsolt <zsolt94@gmail.com> wrote:
> I would like to discuss an old topic from 2006. I understand it was
> already discussed. The only reason i'm sending this e-mail is to talk
> about a possible solution which didn't show up on this list before.

You mention the 2006 discussion, but I wonder if you've read the more
recent discussion from April on the subject.

> I think we all understand that SHA-1 is broken. It still works perfect
> as a storage key, but it's not cryptographically secure anymore. Git
> is not moving away from SHA-1 because it would break too many
> projects, and cryptographic security is not needed but git if you have
> your own repository.
>
> However I would like to show some big problems caused by SHA-1:
>  - Git signed tags and signed commits are cryptographically insecure,
> they're useless at the moment.
>  - Git Torrent (https://github.com/cjb/GitTorrent) is also
> cryptographically broken, however it would be an awesome experiment.
>  - Linus said: "You only need to know the SHA-1 of the top of your
> tree, and if you know that, you can trust your tree." That's not true
> anymore. You have to trust your computer, you servers, your git
> provider in a way that no-one can maliciously modify your data.

In particular, as far as I know and as Theodore Ts'o's post describes
better than I could[1], you seem to be confusing preimage attacks with
collision attacks, and then concluding that because SHA1 is vulnerable
to collision attacks that use-cases that would need a preimage attack
to be compromised (which as far is I can tell, includes all your
examples) are also "broken".

1. http://thread.gmane.org/gmane.comp.version-control.git/291305/focus=291511
