From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Mon, 1 Apr 2013 02:04:17 +0530
Message-ID: <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 22:35:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMOyg-0001Ao-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab3CaUe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 16:34:58 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:57882 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639Ab3CaUe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 16:34:57 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so1477247iak.32
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nTNZmuRqEPvwP+58NJB3+7GZy/k66GQ2kLmRX6iy0ok=;
        b=b1bbsYBBvPQtomkAUU669pdmHVpT/P7Yw815/dLFi55UOzNDDm2UCFaAPpFw76Of6v
         DegplLwRRgMTERyedvnollGRj8Dbtv/gjqASKz3Pzl5EDrvsFhpF93cxjadqRwJ/Vx2T
         KG/uQxVwZ0yhurzkPlS25yZJoS3cUlhXmF0gvovUGmAEVW7roQswDI8jFz7c5jZOiOu1
         KWiBvsY1jaitnvOLOYZMblsqpu8UM+ZENC0qDIjjusf5FobRE+JrrIiLPr9LH3iVAhU6
         QvvkmXb3ib99hJosO+WSvAMK6EC4U3bpTU6iaV2e8PzDXTdSx5pqq+azgUjER7nIFsyr
         jJgA==
X-Received: by 10.42.50.202 with SMTP id b10mr4283050icg.7.1364762097231; Sun,
 31 Mar 2013 13:34:57 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 31 Mar 2013 13:34:17 -0700 (PDT)
In-Reply-To: <5154AACC.7050006@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219639>

Thanks for taking the time and effort to review my thoughts.

Jens Lehmann wrote:
> A
> commit is the thing to record here because it *is* the perfect fit

Might be, but saying that doesn't help one bit.  I want to know why.

> I want to improve the user experience
> of submodules and don't care much in what language we achieve that.

You missed the point entirely.  If git didn't have a commit object,
would you use a special kind of blob and code around everything to
avoid fixing a more fundamental issue?

> What happens when you rename "magit" to "foo" in that branch and want
> to check out an older commit of the same branch? That is one of the
> reasons why that belongs in to a checked in .gitmodules and not
> someplace untracked.

Good point.  I learnt something new.

> Are you aware that current Git code already stats all files across
> all submodules recursive by default? So (again) no problem here, we
> do that already (unless configured otherwise).

I didn't know that.  Why does it do this?

> Guess what: submodules are the solution for a certain set of use
> cases, and tools like subtree are a solution for another set of
> use cases. There is no silver bullet.

That's the core of your argument: submodules already solve what it
was meant to, and we can't get it to solve a larger class of problems.
 In other words, you're implying that it's impossible to build a tool
that will be able to compose git repositories in a way that solves a
very large class of problems.  I don't see conclusive proof for this,
so I have to disagree.

To summarize, everyone seems to be elated with the current state of
submodules and is vehemently defending it.  I'm a little unhappy, but
am unable to express my discontent in better prose.  Let's just go
back to writing patches, and come back to this if and when I have a
full design.
