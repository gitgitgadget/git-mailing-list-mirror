From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 16:35:00 -0500
Message-ID: <CAMP44s1EJO3gMyb-SCGL3mWQOgsgYDb87e2mx3spO=V71hs+=g@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<20130411161845.GA665@sigill.intra.peff.net>
	<CAMP44s2-4i_tSzz8Y88_YnK5d1AjNoTqOa7eXZ0W5Vzk9Uosng@mail.gmail.com>
	<20130411165937.GA1255@sigill.intra.peff.net>
	<CAMP44s1KgpT5YGwAr2KAToaoB6rUmtM3ocA-OtFSGfOzudx5RA@mail.gmail.com>
	<7vbo9kj41y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 23:35:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQP9K-0005XX-2K
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab3DKVfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:35:11 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:44714 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab3DKVfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:35:10 -0400
Received: by mail-la0-f48.google.com with SMTP id fq12so1906035lab.21
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1TkURHy3PugEKBp2ZxpE9ri9OypLV7wugNsJy70YUuQ=;
        b=fAJG1JSp7m89f3IswQkj29lOhxbPnMq5UVJFcOLPZ1zAbphMXuNx2CllXzLM/xyVcZ
         rrlBBmI3fY4wFQyi1ECPmYWuWGe1rbLax+k6ibQiuD0EKEkmjTC1gokgudtGlNC4TsDR
         RJizEVkPNkEUlpaYwyh5mZjCzr1bjUB5TkvOu1K6tTqleAfIqqfGE6Ld9WbrL/kQ32jf
         QJZA2A+PyDKe+m1RLKyVgmDukjzmRVQ8hF3+mV1jzTp6wwsiju4yWg5nxpWODw6pHAp7
         uaRclmhExuo9Z5vZj9pChB+czWlkTNEtb4fsTtLWDaSU+ik6UH7+msYxU/BK+dbIZzqF
         L+EA==
X-Received: by 10.152.105.17 with SMTP id gi17mr4031995lab.46.1365716100365;
 Thu, 11 Apr 2013 14:35:00 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 11 Apr 2013 14:35:00 -0700 (PDT)
In-Reply-To: <7vbo9kj41y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220932>

On Thu, Apr 11, 2013 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 11, 2013 at 11:59 AM, Jeff King <peff@peff.net> wrote:
>>
>>> But I give up on you. I find most of your commit messages lacking in
>>> details and motivation, making assumptions that the reader is as
>>> familiar with the code when reading the commit as you are when you wrote
>>> it. I tried to help by suggesting in review that you elaborate. That
>>> didn't work. So I tried to help by writing the text myself. But clearly
>>> I am not going to convince you that it is valuable, even if it requires
>>> no work at all from you, so I have nothing else to say on the matter.
>>
>> Me neither. I picked your solution, but that's not enough, you
>> *always* want me to do EXACTLY what you want, and never argue back.
>>
>> It's not going to happen. There's nothing wrong with disagreeing.
>
> Heh, it seems that I was late for the party.
>
> Writing only minimally sufficient in the log messages is fine for
> your own project. We won't decide nor dictate the policy for your
> project for you.
>
> But _this_ project wants its log messages to be understandable by
> people who you may disagree with and who may have shorter memory
> span than you do.

Having a shorter memory span is irrelevant when you are _never_ going
to go back and ask the question the commit message is answering. And
if it indeed is an important question, the answer belongs in the code
comments.

> Disagreeing with that policy is fine.  You need
> to learn to disagree but accept to be part of the project.

Yeah, I accept that you will commit whatever you want, but I still
don't think this verbosity serves the purpose you think it serves.
Some one-liners deserve pages of commit messages, but this one is not
one of them. People are easily deceived, and because you saw one
commit message that needed more information, you think all of them do,
but no, some don't don't, and this is one of them. It's not serving
any real purpose.

--
Felipe Contreras
