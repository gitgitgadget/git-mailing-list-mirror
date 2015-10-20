From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Tue, 20 Oct 2015 11:18:19 -0700
Message-ID: <xmqqeggp8kus.fsf@gitster.mtv.corp.google.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
	<xmqqwpumg480.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
	<xmqq4mhqg15y.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeTf93NnqPM+SaxfhsSdMg1HUiVyo5FFdiuGF9o-KQbGog@mail.gmail.com>
	<xmqqbnbu9kzr.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeStjJY2sqGvC0wV_OqFSA3OuzmcDitvr53d=z8+y2dBYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:18:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZobUQ-0006oA-N5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 20:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbbJTSSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 14:18:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35125 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbJTSSV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 14:18:21 -0400
Received: by pasz6 with SMTP id z6so28349645pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pZBImsqyOQAWsn9tdBbeLa/QGlbYmxOMMvARfewgCPI=;
        b=uk/R5/ycLlU9X52wnStLiqa00bQcghRFWbBqqA8jU+10ol/ygdmlU7fmYkYXD3po1D
         dP6rjf5Wd3I1ichSJyuuvPj8H0dfwbCMyulrGeenmnn8czUacaHCXrMYS4b5kVsPTbhj
         zfNJN6U4Hsyf8taw7g4R974s8ZPmXQFvTNjiJg7JW/dUvmfjAMbLM0NrlQ2UYgWFd/wf
         0UOoEbyzI+C4b5pu7WpZYpd2mIytVPB8i9mOTnjv9K04lwVf4NL8ajYZAmIlnzv/19Oy
         QDd82m8L+kdrpPe/1vebaVsO9HSlm5KSS6Cpnyj5ptSVvH5bKWSg5OM5A3jNyvCedf/s
         n1Ig==
X-Received: by 10.68.68.233 with SMTP id z9mr5488103pbt.132.1445365101128;
        Tue, 20 Oct 2015 11:18:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id a17sm4951942pbu.55.2015.10.20.11.18.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 11:18:20 -0700 (PDT)
In-Reply-To: <CAMMLpeStjJY2sqGvC0wV_OqFSA3OuzmcDitvr53d=z8+y2dBYA@mail.gmail.com>
	(Alex Henrie's message of "Tue, 20 Oct 2015 10:54:20 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279930>

Alex Henrie <alexhenrie24@gmail.com> writes:

> I pushed to change [options] to [<options>] because even if the angle
> brackets don't help new users or translators in this particular case,
> the angle brackets encourage Git authors to use angle brackets when
> writing commands that are not so easy to understand. If you think that
> [<option>...] is better because it is even more consistent, I would be
> happy to send a patch to make that change.

I do agree that [<option>...] would make things consistent between
options and non-option arguments.  But I also would expect that
reasonably intelligent readers know that options are special, and
they would understand that [options] and [<options>] mean the same
thing as [<option>...] anyway, so I do not feel too strongly either
way myself (meaning: I wouldn't be motivated to prepare patches for
it myself, I wouldn't jump up and down saying they are wrong and
revert them if such patches were applied by an interim maintainer
while I am on vacation, and I would apply such patches myself only
if they do not overly interfere with topics in flight while
merging).

Thanks.
