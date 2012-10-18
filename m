From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 11:22:01 +0200
Message-ID: <CAMP44s2Fd2aO_CcNrPJYGjo6thp3YXmN-dv4agd5qQEJQvqp0w@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<20121017225913.GC21742@sigill.intra.peff.net>
	<CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
	<CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
	<CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com>
	<CAMP44s3+FP2N4iEmxzcu_ayUAF+XWmKdBFDCvFvj6D5RQmN+5Q@mail.gmail.com>
	<alpine.DEB.1.00.1210181112050.3049@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmIx-0005fI-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab2JRJWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:22:04 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38643 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab2JRJWC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:22:02 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so8372776oag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LJIc+XgBIn8EUjAqqBbW7tZZ3KrFIEznP2jdlIiAr5w=;
        b=UXeQ8ceIMbbPovCtOiiksqmYlVmSx77pjyFh1rlMUnJlaLMv28sBGC3uyc1zjkg/4r
         YhlGbMdf+5cz566pCxGmqKXeE4lBWAVmMPGMkpfO/4EKoDxMccF1zYvWZ6PsXbPuApof
         89fcDc1YZfor8JE67m5s203C0vDz/PTA7uMbQOJTXclqO36lN7xaEQQ58jdluujpLPqO
         92zOBbTHUP2b8BA8SZUv38/x/bmvDTCfiMUchVbW3RTUbrZ3YIJEASLP83VtG+aQkGd/
         y4Xitq728JVucoObfTgkA9EiEUkrqDlhqK6b8YtRztwQKXJmsGzS0kOLzlne0aP+3VW9
         WkJQ==
Received: by 10.60.22.228 with SMTP id h4mr7453149oef.30.1350552121891; Thu,
 18 Oct 2012 02:22:01 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 02:22:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210181112050.3049@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207986>

On Thu, Oct 18, 2012 at 11:13 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 18 Oct 2012, Felipe Contreras wrote:
>
>> On Thu, Oct 18, 2012 at 8:12 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> > On Wed, Oct 17, 2012 at 10:18 PM, Felipe Contreras
>> > <felipe.contreras@gmail.com> wrote:
>> >> Right now I've just added an error when using remote repositories.
>> >> But it seems there's no way around it; if we want to have support for
>> >> remote repos, we need to make a local clone.
>> >
>> > My git-remote-hg does the local clone into .git/ using a hash of the
>> > url (although you could just as well use urlencode, basically any way
>> > to safely use a url as a directory name). Have a look if you want.
>>
>> Can you point to the version you are talking about? I've been checking
>> the remote-hg branch of fingolfin.
>>
>> https://github.com/fingolfin/git/tree/remote-hg/
>
> The code is in https://github.com/msysgit/git/ (Sverre does not have
> enough time to work on remote-hg, and was okay with me hosting it in Git
> for Windows, for all the reasons I mentioned earlier in this thread).

Which branch? I don't see any remote-hg branch.

-- 
Felipe Contreras
