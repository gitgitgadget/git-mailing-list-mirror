Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6CE20179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbcFTKHk (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:07:40 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56190 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbcFTKHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:07:39 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4) with SMTP id u2VHm2WD015847;
	Thu, 31 Mar 2016 20:48:03 +0300
Date:	Thu, 31 Mar 2016 20:48:02 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	Zachary Turner <zturner@google.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Message-Id: <20160331204802.375a9614be32168c735a185f@domain007.com>
In-Reply-To: <CAAErz9jeLPU+QocSKNssknoJdZoi4Sq0YfZiNnpf4wD70JKQUQ@mail.gmail.com>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
	<CAAErz9jeLPU+QocSKNssknoJdZoi4Sq0YfZiNnpf4wD70JKQUQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 31 Mar 2016 10:20:28 -0700
Zachary Turner <zturner@google.com> wrote:

> I dug into this some more, and as surprising as it is, I believe the
> release of Git 2.8.0 is just busted.  I had an installer for 2.7.0
> lying around, so after uninstalling 2.8.0 and re-installing 2.7.0,
> everything works fine.
> 
> I'm not terribly active in the Git community so I don't know what the
> procedure is for things like this, but this seems like a fairly
> serious regression.  Suggestions on how to proceed?
[...]

The GfW maintainer had already spotted the bug (in the msys2-runtime,
IUUC) like some two hours ago -- see the bug #711 in the GfW tracker.

I'm pretty sure a fix will result in a corrected installer being
released.  If you can't wait for it for some reason and have to use
2.8.0, you could build GfW from the sources with the commit I mentioned
having been reverted before the build).
