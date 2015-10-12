From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 12 Oct 2015 23:18:05 +0530
Message-ID: <CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr> <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
 <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> <vpqpp0ojvs6.fsf@grenoble-inp.fr>
 <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
 <xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlhDF-00073S-B8
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbJLRsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:48:37 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33728 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbJLRsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:48:35 -0400
Received: by vkaw128 with SMTP id w128so33894038vka.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4EIXTfBuxjlalLqq+/m4x5FgWNusRO5/jeoYcCYc0+Y=;
        b=mZucrHXU0AlX1+A/hXqmVN/uQfW9KK1ULoVsyg6a4CLrfTzTzFR+jE4uTEV5NjXYMj
         tO7JJlDYMB5vKkKoe35KvyYmDihRv/KjiELo6k7bF3YFA6gVMCHfWJ2jSFTnhojfMtzL
         09xTMwjkuRFD3HK/C7Kt3MGgyieyCRh148TPV90A4Z/bio0OPPezhrczvfYHK7RnIP5l
         UrZBoIpyc1L4GeCbk6UtG48LGSPJiWHYyiy1QSlb9JRutKal90QAaEMUD2PAt+EjWMVy
         2CdrIc7ENVie8qmu1VJyO7voP4mOhvEHdMda66Donc2yd+l3Qq+wntiu1/RZKqYDwj+a
         mG8A==
X-Received: by 10.31.21.149 with SMTP id 143mr18818012vkv.79.1444672114626;
 Mon, 12 Oct 2015 10:48:34 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 12 Oct 2015 10:48:05 -0700 (PDT)
In-Reply-To: <xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279388>

On Mon, Oct 12, 2015 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Fri, Oct 9, 2015 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> Also does it make sense to integrate these changes here? Or would you like to
>> have another series on this?
>
> I do not think you would want to ask that question, as my answer
> would most likely be "The most preferable would be a series to clean
> up the existing codepath that deals with %(align) first, on top of
> which everything in flight that is not yet in 'next' is rebased."
>

Ah, but I might take a while to get there, So I'd rather push code which
is almost ready and work on that slowly, if that's ok?

-- 
Regards,
Karthik Nayak
