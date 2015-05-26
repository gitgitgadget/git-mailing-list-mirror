From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 20:34:06 -0700
Message-ID: <xmqqoal8811t.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
	<xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
	<xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
	<CAJ80sauXaaOjQhybxWVrHJpNQhHCKOd2Le1vFqEwBef6gYjqrQ@mail.gmail.com>
	<xmqq1ti49k1a.fsf@gitster.dls.corp.google.com>
	<CAJ80sauoB-quepDf2V=-WqewzJ_nN+ALA-z-vcL_4c8rObxpBg@mail.gmail.com>
	<xmqqwpzw82ts.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 05:34:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx5d8-0001Cw-PA
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 05:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbbEZDeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 23:34:10 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38461 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbEZDeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 23:34:08 -0400
Received: by igcau1 with SMTP id au1so44064018igc.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 20:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NW94h1nZEOgpRajpye0sI+/CitdBHSpP6AIXG8T/cFE=;
        b=Jtn9eU7msP3Ds0vZ7ILkPoG93x7oSFUcfdWl9ZrUb+CqQUDqC+3nfazeW1aAXCuLK2
         AAVwHg0sCzHHslJaeZ8PE8cPlV3qH2drgx711JHBYOq3x1Vbz2HyYmF3Cj34xVE2KCyA
         Edou1n2M4a+YxOEjEwCHt4wOWFrSmquSCE02KWj5I7YRXMCwIbys4eXeF/C5dc3R8FNb
         q+Dskxik/EThvjMdWTiiIBz1od2eVk8r21K2iJUR4+fDQKY/ZJ0LRC0JVfynAxWpAE69
         vIiC6nlqXLVc5iWOmqnIX6ojR6qTF+xwrevx+xZvAs51mn7VFy/jUQeHYnXTrCs/C38n
         rEkw==
X-Received: by 10.50.73.198 with SMTP id n6mr26835628igv.32.1432611247927;
        Mon, 25 May 2015 20:34:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id i185sm10167927ioi.24.2015.05.25.20.34.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 20:34:07 -0700 (PDT)
In-Reply-To: <xmqqwpzw82ts.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 May 2015 19:55:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269927>

Junio C Hamano <gitster@pobox.com> writes:

> It probably should be two patches.  Your sendmail thing with docs
> and tests as one patch (with $HOME in test), and fix to mailrc tests
> I did (minus the part that fixes your sendmail test, which should
> now become unnecessary) on top.
>
> If the documentation I queued on 'pu' formats well already (which I
> cannot check myself until tomorrow), then I'd guess the above would
> be like squashing 8b8fb5a into dc6183c and then 6b733ee on top, I
> think.
>
>  6b733ee t9001: write $HOME/, not ~/, to help shells without tilde expansion
>  8b8fb5a git-send-email doc: refer to upstream document for alias format
>  dc6183c send-email: add sendmail email aliases format

Well, I lied [*1*].  I think the documentation part of what is in
'pu' formats fine, so let me just clean them up and push the result
out for your final review.  Give me a few hours (leaving time for
dinner and etc., too).

[Footnote]

*1* My Git time is spent on in a terminal-only environment, a
virtual machine running somewhere in Google datacenters, and when I
am home working from a Chromebook via ssh, I lack a convenient way
to grab a single file out of there to view in the browser locally.
The virtual machine does let me upload to Google Drive and I can
grab a file from there to my Chromebook, and that is what I did to
see what the AsciiDoc formatted result looked like just now ;-)
