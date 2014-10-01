From: James Hancock <james@bookstobrains.com>
Subject: Re: Can you git clone -partial? I am looking to make a mobile app and
 it would be nice to have.
Date: Thu, 2 Oct 2014 05:32:20 +0800
Message-ID: <CAOHoyPq7dxAgw+O7A8d1v36a3BJrW8cEZM79YwY_4cQd80Mawg@mail.gmail.com>
References: <CAOHoyPr3E9U3XPEjmrSNkT0okHcRN2H7OKyrt-Ar3WMMDL=4vw@mail.gmail.com>
	<xmqqtx3npu6e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:32:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZRVc-00056D-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 23:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaJAVcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 17:32:24 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65413 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbaJAVcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 17:32:21 -0400
Received: by mail-lb0-f172.google.com with SMTP id b6so1184474lbj.17
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 14:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6y4c8ANh7B2QNNvyVjJBKrHCCRIauv2XPm0Jpft6OxQ=;
        b=aL56KJerYekpLz22zn4v4q7Y3lmfp4Vktkyf8SAK7iWTRtlhX3kAT7BvxVS4kAC1zi
         vPL0uXNULiD3iNwiAI4pCJqkD/KaKXhBLMFPWiuuEEAxOB53zcB6ibxpzz9JkjxAoRcY
         31Ia9C2ys6QbIf+K90V6WsEVXTwN+XgSpViy3wIqnThAWokfVEs8GoSKp0wr+Bpayuaq
         GtHzlylhU3VmtiuKUj1HhrP0rbqBw4C8FdEw/nFbX6CsdGWkwCLIVAIB33Nf8p4CltAX
         ybs4OUVI8eZJmjrd5s1WmUOjWVaUP97SR01J8KGQMDFMkviXX+AUzl7qWHOvhqaP/SD1
         vEaQ==
X-Gm-Message-State: ALoCoQmRw9K4Rv+U3wdVr+s7g+r63snf6ZymhA3HGq4mxjJaASi51O+XBuNPXRHrhtmEpYlPFYu4
X-Received: by 10.152.6.228 with SMTP id e4mr28928349laa.12.1412199140234;
 Wed, 01 Oct 2014 14:32:20 -0700 (PDT)
Received: by 10.25.30.10 with HTTP; Wed, 1 Oct 2014 14:32:20 -0700 (PDT)
X-Originating-IP: [58.115.134.159]
In-Reply-To: <xmqqtx3npu6e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257767>

I see what you are saying with the file thing. I am not a git master
and I am afraid that is showing in the words I use...

The app I want to build is actually part of testing a Mobile Markdown
Editor I am working on. I thought a good way to prove the system would
be to make a simple app that allows you to edit your READMEs and other
Markdown pages in your projects that use Git. They could be hosted on
Github or elsewhere. It is mostly about testing the editor
functionality on a larger scale.

So, I want to just get the files I need out of the collection of file
history and then put it back when and if I need to. But, I want to do
this with as little network and data storage as possible (given the
limitations of a mobile environment). I know most projects aren't very
large as far as file size goes, but I am still wondering at what it
would take to do this and if Git has the ability, or what would need
to change for it to have the ability. Maybe it isn't worth it? I just
want to be able to say why it isn't worth it with good reason.

I read about git archive and I looks like it almost does what I want.
I am not sure what happens underlying so my Git Noobness will show
again here. I found documentation on how to us archive but I haven't
been able to find something that tells me how archive does what it
does.

1) Can you the push your changes in a file that you have used git
archive for? Maybe you can do it just to set up a pull request or
something.

2) How would the archive know when to pull updated changes? My
understanding is that archive would just pull out the file but it
would then be separated from its' parent. Is there a cost effective
way to compare the archive to the master without downloading the whole
history? Maybe I could keep a record of where the repo is and just
have the program check the original repo for a new version?

3) I am wondering how intensive archive is? Do you need to get
everything and then it narrow it down on your end or do you just grab
the small part you need? How does the repo know what to give you? It
says it compresses the data. Where does the compression happen?


Cheers,
James

On Thu, Oct 2, 2014 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> James Hancock <james@bookstobrains.com> writes:
>
>> i am thinking about developing an app and I want to integrate it with
>> git but I only want to store a portion of the file on disk. It is
>> going to be in a mobile enviornment and I want to just get one file or
>> a small group of files.
>>
>> I read that you can clone and then only look at one peice but is it
>> possible just to clone one peice? And if not what would it take? Maybe
>> this is a feature people would like to have. Just hypothetically, what
>> would need to happen?
>>
>> Either
>> git clonepartial /repo /file/or/folder/in/repo
>> Or
>> Git clone -partial /repo /file/or/folder/in/repo
>
> You keep saying "file", but the thing is, Git does not track file.
> It tracks history of collection of files.
>
> What are you trying to achieve, exactly?  What does your "app" need
> out of that operation?  Does it need these selected files with their
> history?  Or does it only care about the contents of the selected
> files at the tip of the 'master' branch of that repository?
>
> I'd imagine that your answer would be the latter, and suspect that
> you may want to run "git archive --remote" with a pathspec to limit
> what gets grabbed.
