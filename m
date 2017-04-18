Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D616B1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbdDRM0Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 08:26:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33707 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbdDRM0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 08:26:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so14367563wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRa3T9o2MYfKUM6ce3RFDddDUJZHvX+FcJqO5Kw+DuU=;
        b=tFqBZVcbj2DDv0fvfcLybva6J02yldvhvqJQbNVqzIksFI7L2g26m+ecCdyqNzg1hR
         sAAxEn6Ox9roHu1Ot4GoxxghU6PP0EbIoTi0t8mf7RMa1wKboX9ELK0kjzFQZDLV+Lho
         seT3eq4aCqPYuwZikzeeTQffrdVqElLMrOiybiXfF7aLn9kl7URKg+nPiu0e0y1gQzVH
         uyKEyoz1gozhBiytOtqgXOcOw/8SxvXZqp/7kDd8p1ZJPLMCUtpDrcieoweWfXKOXqsa
         XpbCWbJKLgNZyqSCvo2lL5dsPA625BTS32JH3eJxNXRWUHve14Gkh3K7vw1aIsEZuVPe
         7kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRa3T9o2MYfKUM6ce3RFDddDUJZHvX+FcJqO5Kw+DuU=;
        b=pmmfKqP/jKW0yO1j0OuvLyIvvBcTI3igA7YLERLesMdNMhgiDwuvHcj0MCwSTOr2KZ
         QfSYTvR3aBhSQ8mceDByqycHTIC/QcfLznpq4+oHcmefl7Nc5++mu5vp65Q9vtoBk3eW
         8nIRL1r7CGHfk2pWxB7eaC9qKGfeYG3NZAUdamkkgf0FMf5VZpD9WtPWTPLQzajvwrWu
         RS+6OnSMPLyBdH+RiL31Ug4jAEGmQ6psCD3vDylepiWaogfP9ga1hfn8b8pqDlpx4eME
         BKj1ETmOWziGYPRw0u0TgFc5xGdqzLghdpUvz7apZ8c+CfIaJ572a84Am3l0GjJd2Toz
         FfaA==
X-Gm-Message-State: AN3rC/7KHsa/j1MUdEwh6XoddvmZtXUDm8MjRDfpIriurn9XGq7L6/2P
        7Zu0lQ42k3+Diw==
X-Received: by 10.28.178.17 with SMTP id b17mr12601896wmf.23.1492518380803;
        Tue, 18 Apr 2017 05:26:20 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box (p5DD30C29.dip0.t-ipconnect.de. [93.211.12.41])
        by smtp.googlemail.com with ESMTPSA id p26sm14780130wmi.18.2017.04.18.05.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 05:26:19 -0700 (PDT)
Message-ID: <1492518377.5720.47.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Tue, 18 Apr 2017 14:26:17 +0200
In-Reply-To: <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
References: <1492287435.14812.2.camel@gmail.com>
         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
         <1492347718.19687.14.camel@gmail.com>
         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
         <1492368692.22852.9.camel@gmail.com>
         <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
         <1492380399.19991.13.camel@gmail.com>
         <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
         <1492452173.11708.22.camel@gmail.com>
         <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley>
         <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-04-17 at 17:31 -0700, Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> > 
> > > 
> > > > 
> > > > If we'd created and added a file d just before the checkout,
> > > > what
> > > > should
> > > > have happened to d, and why?
> > > I understand what the command does. It behaves perfectly as I
> > > expected
> > > it to. I did not find this script but wrote it to demonstrate that
> > > what
> > > the documentation says is different from how it behaves after
> > > having
> > > read what the documentation says it should do and noticing that
> > > that's
> > > not how I expected it to work from experience.
> > > 
> > > What it really does is to copy all files described by the given
> > > paths
> > > from the given tree-ish to the working directory. Or at least
> > > that's my
> > > expectation of what it does.
> > > 
> > > The documentation, however, says that the given paths are
> > > *restored*.
> > > This is different.
> > I don't see that difference in the phrase *restored*, compared to
> > your
> > 'copy all files described by the given paths'. Could you explain a
> > little more?
> I am obviously not Christoph, and I was the one that defined how
> "checkout <tree> -- <pathspec>" should work, but when you say
> "restore" (which is not what I wrote ;-)) it is fair to expect lack
> of 'd' could also be "restored", in addition to path that was in the
> directory.

Yes, you didn't write "restore" but you wrote: "It updates the named
paths in the working tree from the index file or from a named <tree-ish> 
(most often a commit)."

I suppose that from reading this, some people will assume that `d` is
gone after the command was executed because the folder to which the
given path leads is updated "in the working tree from the index file or
from a named <tree-ish>", and others will not be sure what happens. But
I doubt that a lot of people guess the behavior correctly and are sure
about them being correct.

Note that for the first group of people, it doesn't matter that git
doesn't track folders. You can restore a folder "in the working tree
from the index file or from a named <tree-ish>" without tracking folders
because there only is one property of a folder git cares about, apart
from it itself being able to access files in that folder: Its name. And
it can get that name from the paths of the files in that folder. If
there are no files in that folder, there isn't a contradiction, either,
because then there is no folder in the index or tree-ish which can
possibly be restored.


> Obviously, "grab all paths that match <pathspec> out of <tree>, add
> them to the index and copy them out to the working tree" will never
> be able to _restore_ the lack of 'd', even it may match the
> <pathspec> being used to do this checkout, by removing it from the
> current index and the working tree.

Exactly. "grab all paths that match <pathspec> out of <tree>, add them
to the index and copy them out to the working tree" is a more accurate
description of what the command does (but it might need some rewording
;-) ).
