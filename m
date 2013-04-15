From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Sun, 14 Apr 2013 20:35:08 -0500
Message-ID: <CAMP44s1NpPVyRZGDdM2r3R7DrJOkZhFY8cyZX_CgJBomjmSVog@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
	<CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
	<CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com>
	<CAMP44s38e4n_jKC-f973JJUXuxkD2dqP+ECwzxvUMWxit2P2PA@mail.gmail.com>
	<CACsJy8CTmh2eMDqBpr0agiTGcHkP_AQBLLg2A4HM203u9G1v9g@mail.gmail.com>
	<CAMP44s27Tj4x5U34ysdfQx8uzxAz=yJZ+rkWxLWtQHzAeoF8SA@mail.gmail.com>
	<CACsJy8Cecymz-vPQ_WwGzB8kR6B_j5vm8MPVykrO44C5Vk=1Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:35:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYKE-0000yF-O2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab3DOBfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:35:11 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:65202 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab3DOBfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:35:10 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so4099948lbd.10
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=M8HhhYS340HgxdYFMfjUC14k82tE0+CYK1fzDltWt7Y=;
        b=fHuoUR1ofjYNSea57bH5qlg1cLgHzuNErlK211mBaqSGikckiGSgJ7yE1qx6CwkJEq
         WOqXwu+ha6albdFPVutMGmnCBhAEA3eClvnrN8SS2g65xxBzjMCVKhqWXckn3LN4DMGt
         5z4TMqJqeq5Gu3YEQaZbYqgyeU8HgNRd0eeWkBITihaInsq4HnELoiG7xMxjR1ntOSJ/
         cIQJ4u/wWQzSAxhZq6F4dit42jK5wt4R8fbz10TkzrPF/4aYYbGrIkE16aui0+9Qgjgh
         +3NUZHq73Q1n+RhFTAVKpUVoNzM8EgwgW79/t59sCzjZso3vfIhWDUEdQ04hifWBlV/5
         8I1A==
X-Received: by 10.112.20.106 with SMTP id m10mr9367394lbe.8.1365989708885;
 Sun, 14 Apr 2013 18:35:08 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 18:35:08 -0700 (PDT)
In-Reply-To: <CACsJy8Cecymz-vPQ_WwGzB8kR6B_j5vm8MPVykrO44C5Vk=1Zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221178>

On Sun, Apr 14, 2013 at 8:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 15, 2013 at 11:24 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Apr 14, 2013 at 7:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Mon, Apr 15, 2013 at 9:54 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Sun, Apr 14, 2013 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>>> On Mon, Apr 15, 2013 at 9:22 AM, Felipe Contreras
>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>> On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>>>>> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
>>>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>>>> +       char fancy[80];
>>>>>>>>
>>>>>>>> -       if (show_upstream_ref)
>>>>>>>> +       if (show_upstream_ref) {
>>>>>>>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>>>>>>>> +               if (want_color(branch_use_color))
>>>>>>>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>>>>>>>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>>>>>>>> +               else
>>>>>>>> +                       strncpy(fancy, ref, sizeof(fancy));
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>
>>>>>>> Please use strbuf for "fancy".
>>>>>>
>>>>>> Why? We would need to initialize and free it. What's the advantage?
>>>>>
>>>>> From a quick glance, I don't see any gurantee that "ref" (plus ansi
>>>>> codes) will always fit in 80 bytes.
>>>>
>>>> Would changing it to 1024 (MAXREFLEN) fix it?
>>>
>>> You still need to take ansi codes into account. I think it's easier to
>>> just use strbuf.
>>
>> I'm not sure what you mean. If there was an issue with snprintf, then
>> there would be with this in refs.c:
>>
>>         if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
>
> I mean GIT_COLOR_BLUE and GIT_COLOR_RESET take some bytes from
> "fancy". In the stretched case where ref takes all MAXREFLEN, then
> fancy must be a little bit bigger. Why do we need to think hard about

I don't see that as a big issue, since it's a matter of finding the
maximum length of those, but the argument from Jeff convinces me; I
would not like to add extra code for the snprintf corner cases.

Cheers.

-- 
Felipe Contreras
