From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 9 May 2014 13:35:06 +0200
Message-ID: <CABPQNSbU8E39vcP1T50DWgwTvxcd7UX3BHmJfS4gJigTWX=7jw@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch> <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
 <536c966cf0e9c_2bf0e952f079@nysa.notmuch> <CABPQNSay4gDJ2Ea-w0=wnU1oqVZ_ATm1Q_M71zt+rAd1XUr0zg@mail.gmail.com>
 <536ca0a0f38af_39ea14ab31017@nysa.notmuch> <CABPQNSYJabLU5+9ODMWswu_7R_LRno9oEM=NyC6vhZ--tatb+A@mail.gmail.com>
 <536cb4b4cda1e_6b2dde730827@nysa.notmuch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 13:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wij5i-0004vF-49
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 13:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbaEILfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 07:35:47 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35625 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbaEILfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 07:35:46 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so3905666iec.36
        for <git@vger.kernel.org>; Fri, 09 May 2014 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Y3TqbBjVk18xOY0zU5jlEiqJsAkaWsyNqcEnxzWFa4s=;
        b=bpXBW5Wm32ndT0UQtOTqryaDdzZ/L7mj3dorBOPAmkl56eKgZMhzIuCVqDFujvZUMp
         GqpajwDR+9zjQZ0vOjTJKEb9aXO4H62Vr+OrHGl4AGi4QRGy+R52wpvCg5G3S1J4yJHv
         9l/1RkU+49bLaLVcDfH/XhLrtkiVJKuUNG7msZrVxz6DWGJpwGa0P6G87wLWi/0ddpph
         jiNRrnzn8iRtV+5mFfcxJhsPus+EiWbmUlNWrOqHAg6u3xDZDqFxs22pDysqW9Ka+WcF
         DB1bH1QsCZ827dQZFytooy0YEUKAwMVuN95gMy0lFX3cQ4o+G2zviWLtIG0Z1HzKmnoL
         q7tA==
X-Received: by 10.50.154.73 with SMTP id vm9mr8317129igb.14.1399635346208;
 Fri, 09 May 2014 04:35:46 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Fri, 9 May 2014 04:35:06 -0700 (PDT)
In-Reply-To: <536cb4b4cda1e_6b2dde730827@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248553>

On Fri, May 9, 2014 at 12:57 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Erik Faye-Lund wrote:
>> On Fri, May 9, 2014 at 11:32 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > Erik Faye-Lund wrote:
>> >> On Fri, May 9, 2014 at 10:48 AM, Felipe Contreras
>> >> > You think changing the execution bit of a file is considered "activity"?
>> >>
>> >> Well, now we're getting into semantics, which I don't care so much
>> >> about.
>> >
>> > Convenient.
>>
>> Yeah, the part above here goes in my "don't argue with idiots, they'll
>> drag you down to their level and beat you with experience"-filter.
>> Good luck trying to convince *anyone* with this line of argumentation.
>
> It has been demonstrated that there is inactivity. The fact that your
> semantics about "inactivity" differ from the rest of the world is
> irrelevant.
>
>> > The script doesn't depend on the version of the Makefile, and proof of
>> > that is that is has *never* been changed even though the Makefile has.
>>
>> Except it has, in 74cf9bd.
>
> Once change in *four* years. My god! How are people ever going to keep
> up with such amount of changes if it moves out-of-tree!
>

It's rather amusing to see you react to my definition of "activity",
when you seem to have a rather unusual definition of "never"...
