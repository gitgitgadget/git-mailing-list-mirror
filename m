From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Thu, 20 Mar 2014 01:38:59 -0700
Message-ID: <532AA923.6030409@gmail.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>	<531D51EC.6050503@gmail.com>	<xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com>	<xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>	<53200C1A.7070002@gmail.com>	<xmqq38innyjq.fsf@gitster.dls.corp.google.com>	<53295D30.8090307@gmail.com> <xmqq61na3u2m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 09:39:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQYVy-0003aj-1o
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 09:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbaCTIjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 04:39:43 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:52995 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaCTIjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 04:39:15 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so620256pbb.12
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zve1ZDGH3pGpxBIMGpA9i77VvJS2zxqgqD4U7Sl1fCI=;
        b=m5AVDtMLJYoUrs3WA+Arg6cuNSM9K5qF6FqbzK0zfWnKPUYQKy0Yn7lAkK0Xz7WMwF
         inqJjcWeWWO6BQOubqZRHMYU8DJjtg9ne+oquW2+3wUiXnSBewSeBMvfjQuaVzjpq4ZT
         dC7zMQ8QAKG7laB+TEjSKwvyz+kt+q3x496JZs2ufsXwUPnNI54O5qaN2ffWhKO7eX5i
         CYsJ77bMmAB38QAy9MFOKYoPGIpMfhcafIK08CiwDM+xzFZVaHSEBt8ItRft1ylOKXRU
         Ab2qzIUDoHiTayRUUBZ7RZLz19zDRbtc6i8i4BoD5+Mx2Zpsih11FC/MIQJmq5oN9+js
         arng==
X-Received: by 10.66.13.138 with SMTP id h10mr23088941pac.148.1395304754226;
        Thu, 20 Mar 2014 01:39:14 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id yo9sm6567806pab.16.2014.03.20.01.38.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Mar 2014 01:39:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <xmqq61na3u2m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244523>

On 3/19/2014 11:46 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> I can not find this particular patch in the latest "What's cooking" email.
>> Is there something I can do?
> IIRC, I think I was waiting for the version with a new "Usage text"
> section to the documentation you alluded to in this exchange
> ($gmane/243924):
>
>      Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>      > On 3/11/2014 12:10 PM, Junio C Hamano wrote:
>      >>
>      >>>> Documentation on the whole argument parsing is quite short, so,...
>      > ...
>      > I though that an example just to describe `argh' while useful would
>      > look a bit disproportional, compared to the amount of text on
>      > --parseopt.
>      >
>      > But now that I've added a "Usage text" section to looks quite in place.
>      >
>      > I just realized that the second patch I sent did not contain the
>      > changes.  Sorry about - I will resend it.

Oh %)
I did sent it in the next minute.  And did receive a copy myself.
But it seems it never showed up in the list.
I am still a bit new to the tools, maybe I did something wrong.
Will try again :)

>> It does not seems like there is a lot of interest, so I am not sure
>> there will be a lot of discussion.
>> It is a minor fix and considering the number of the emails on the
>> list, I do not unexpected this kind of stuff to be very popular.
>> But it seems like a valid improvement to me.
>> Maybe I am missing something?
> You did the right thing by sending a reminder message with a pointer
> to help others locate the original (like the one I am responding
> to), as nobody can keep up with a busy list traffic.

Thanks :)

>> Same questions about this one:
>>
>>      [PATCH] gitk: replace SHA1 entry field on keyboard paste
>>      http://www.mail-archive.com/git@vger.kernel.org/msg45040.html
>>
>> I think they are more or less similar, except that the second one is
>> just trivial.
> I do not remember if I forwarded the patch to the area maintainer
> Paul Mackerras <paulus@samba.org>, but if I didn't please do so
> yourself.  The changes to gitk and git-gui come to me via their own
> project repositories.

You did and I even replied with additional details, that I should have 
included as a cover letter.
I can see those messages in the web archive.
It seems that Paul Mackerras gitk repository is here: 
git://ozlabs.org/~paulus/gitk.git
At least that is what is online.  I do not see the change in there.
I will remind him about it.
