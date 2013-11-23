From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Sat, 23 Nov 2013 12:25:47 +0100
Message-ID: <CALWbr2xzY6o6ubuLTBd5VaUSqOS6+Vg7o7WfxbOE=6Fc1ob8bg@mail.gmail.com>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 23 12:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkBLm-0002Kl-8Q
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 12:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab3KWLZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 06:25:50 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:38768 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab3KWLZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 06:25:49 -0500
Received: by mail-la0-f49.google.com with SMTP id er20so1605802lab.8
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1jgqqgT9d7z9tLNQn7TQbHrm9UEPBM9RTRTb3p7bs78=;
        b=CpPPzty+QbUnVcocY04BylrOsU5nNhxWAYsLKdiLeAXfNKiSRdbfjOC5sxs/KYogfW
         zLtwmHTFJDwsezINGjzbMEyN49Fl4M0tK+1SdBZqWOJaxmjSkkFUpOWFd2Sl+mzsfQv5
         vu17Kb7HiDiqOQeHpescKo269AFFpg1Yx+CD4ugUmvw8tB9kIfQxBCU857/d0ch5+l4V
         sWtFDtfiq0u080I4OsduJXSIw/TKkmdHj/Yu68ftoeLoRjZEoT2649MoGRyeIJI+QNTv
         GThTk5QnT9AUOlRouyb8wFvMbloO2BXdBzoxm3AF0JE/ai5nfIrXCKmbn1LJ0sQN0ItF
         eANg==
X-Received: by 10.112.150.103 with SMTP id uh7mr627543lbb.34.1385205947981;
 Sat, 23 Nov 2013 03:25:47 -0800 (PST)
Received: by 10.112.202.102 with HTTP; Sat, 23 Nov 2013 03:25:47 -0800 (PST)
In-Reply-To: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238230>

On Fri, Nov 22, 2013 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * rh/remote-hg-bzr-updates (2013-11-18) 9 commits
>   (merged to 'next' on 2013-11-20 at a36f3c4)
>  + remote-bzr, remote-hg: fix email address regular expression
>  + test-hg.sh: help user correlate verbose output with email test
>  + test-hg.sh: fix duplicate content strings in author tests
>  + test-hg.sh: avoid obsolete 'test' syntax
>  + test-hg.sh: eliminate 'local' bashism
>  + test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
>  + test-bzr.sh, test-hg.sh: allow running from any dir
>  + test-lib.sh: convert $TEST_DIRECTORY to an absolute path
>  + remote-hg: don't decode UTF-8 paths into Unicode objects
>
>  Can wait in 'next'.

Would it be possible to merge the first commit of this series in
master (and eventually in maint) ?
My commit (11362653: remote-hg: unquote C-style paths when exporting)
breaks the remote-hg tests since v1.8.4.3 (sorry about that), and is
fixed by this commit. It would be nice to deliver 1.8.5 with working
remote-helpers tests.

Cheers,
Antoine
