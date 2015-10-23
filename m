From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] expose parallelism for submodule {update, clone}
Date: Fri, 23 Oct 2015 12:33:27 -0700
Message-ID: <CAGZ79kYwtRwUoiy1=41tAWXXXcE_wxm4LT6uvmT+NJbo8WbQoQ@mail.gmail.com>
References: <1445625879-30330-1-git-send-email-sbeller@google.com>
	<xmqqvb9xo098.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpi5l-00084U-6l
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 21:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbbJWTd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 15:33:29 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36840 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbbJWTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 15:33:28 -0400
Received: by ykba4 with SMTP id a4so124638658ykb.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M01vItTOHiV6qGXG072kst3Wzm2T8W4ze4tNwUUeEBE=;
        b=JwDN0ppip8MoAmrHUcMyO+PLzpaxqoZBFdUxFzESk9nwehf2ip134wAVnBbAe8bOiI
         mL8eyqGMPWAQ1WHtj9cXqRIblhdFwArwSG8vGNSTfwGJNHgrwethTCSxtemO9dj3vnn3
         ssgCyySmTvqHa+adBdFZa16NaZ5HNfECJeApsrgqGyr+ccXqFMGmyzrqujQhvkqgRFK+
         4Vl7/J1/4O/26bkKkbvazlmwwgixNNdXsZ8jSORASodpyKKsxyCXUT3G7UAsZO6bMJnZ
         exEKmKWCfI61EloNHsDwTnZBg0VLSFcdgjxur/LcGIwwaPhPRW1vJVG4dcmEY5zFBV1y
         sWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M01vItTOHiV6qGXG072kst3Wzm2T8W4ze4tNwUUeEBE=;
        b=LLAMxr8MlSglEe2s9LqOMm6B0LgrPZnKqMLejUzchXNphW/impnd9tO7U+Is4QPO0g
         VOMHUUgzh3Eynk3GUryZHJ31dkkV114zwtSvK3liAYIGx8BlFVsF0FLbh57ZtofITUMS
         lr+cdfd+N924zxVJxYw9x66vz6CR/FGl82/9e5zOvyMxLIVFLKtSGzjRUWW31AcLf+Ux
         7aKpD7jcaXQ1rYusuhBjaKtoHlO/DYfOvNHyxQoUDR7sriECpO+MOu2Zco4eY1XL7aP4
         nxv871Hu8r6kvR1nPHPCgI4ZQQx7BQxjk4zGJFywsod7cK2Ctr6LwkjeDL9YJkrDVGrv
         cKHw==
X-Gm-Message-State: ALoCoQlmqeNb6IXWb7Pwehh/3tf8XAZKJr61yuttiTSNRb7H3ZSolfysAT23/TT+8deCJJ68KRU6
X-Received: by 10.129.75.208 with SMTP id y199mr18617294ywa.48.1445628808047;
 Fri, 23 Oct 2015 12:33:28 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 23 Oct 2015 12:33:27 -0700 (PDT)
In-Reply-To: <xmqqvb9xo098.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280109>

On Fri, Oct 23, 2015 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>   submodule update: Expose parallelism to the user
>>   clone: Allow an explicit argument for parallel submodule clones
>
> downcase Expose and Allow, perhaps?

Will do, thanks!


>
>
>
> I was looking at the previous one and I am getting the feeling that
> everything up to "run-command: fix missing output from late callbacks"
> is ready for 'next'.  Am I being too optimistic and missing something
> that may make you want to do another reroll?

I would even argue for "submodule config: keep update strategy around"
to be ready for next. ;) But as that is quite unrelated to the previous patches
and only needed for the last patch, we can omit that safely too.

All the fixes up to "run-command: fix missing output from late callbacks"
sound good to me for next.

I have run into a problem cloning big repositories though, but I haven't
found the problem. So the whole parallel processing machine may need
another bug fix later on.

>
> 37bc721 submodule.c: write "Fetching submodule <foo>" to stderr
> 0904370 xread: poll on non blocking fds
> fd6ed7c xread_nonblock: add functionality to read from fds without blocking
> e7ba957 strbuf: add strbuf_read_once to read without blocking
> 8fc3f2e sigchain: add command to pop all common signals
> f57c806 run-command: add an asynchronous parallel child processor
> 4733d9e fetch_populated_submodules: use new parallel job processing
> dca8113 submodules: allow parallel fetching, add tests and documentation
> 79f3857 run-command: fix early shutdown
> 1c53754 run-command: clear leftover state from child_process structure
> 63ce47e run-command: initialize the shutdown flag
> c3a5d11 test-run-command: test for gracefully aborting
> 74cc04d test-run-command: increase test coverage
> 376d400 run-command: fix missing output from late callbacks
