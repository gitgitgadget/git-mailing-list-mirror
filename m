From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Wed, 7 Oct 2015 23:32:27 +0530
Message-ID: <CAOLa=ZQ8QpU_FTqK7Sn0xeygtyirsLOE7bG03iwcVoPUJFpptg@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-9-git-send-email-Karthik.188@gmail.com> <vpqvbao86pj.fsf@grenoble-inp.fr>
 <CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
 <vpq7fn1qhp2.fsf@grenoble-inp.fr> <CAOLa=ZS5x=ksfnBt1kLp5bJJHmqeBztR7Zn7U5VKZN-56T-_5A@mail.gmail.com>
 <vpqmvvvhl9m.fsf@grenoble-inp.fr> <CAOLa=ZS4xVfsQ+F+KGD8Gz9NHzvJtuVvW16RSLV08ZiEv8DhKw@mail.gmail.com>
 <vpqmvvu4l3o.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 07 20:03:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjt3Q-0003O1-3q
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 20:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbbJGSC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 14:02:58 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33618 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbbJGSC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 14:02:57 -0400
Received: by vkgd64 with SMTP id d64so16784953vkg.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bhUkqBnyIExJJ5K2BAKVVgAjoD88fHC5dS+5Q1mu328=;
        b=xOOJ4qiv6eEfTLUw0/DQgE9c2b2dGoXszBRCF/GU3cx2N2HWL6/hcKjx5a33N/cxcI
         fcwzXL7qO8sac6cbjVmTJaqexh/VumbDhaOJBBwt7rlCM1ISO2/DzXvg21zRvy239mWf
         nsb6JsXuZuGCs9rX+T1tuTXISs7Q87PbFDAzCAmuBew7nWZBqyoraJBOr5z2obCjJilT
         HZ0Og91kPO2prW8ZpyKc/jNRxOq3rTgfsuTGah3HLRMJdzEtWIGR5VnpKNk/LMyOtGn/
         98hx8p6EZvkn1wNy930897teXwA1hXDWSD0r35kthvkJNi5aySraf/21ahl7YbVA0KNg
         l5CQ==
X-Received: by 10.31.173.136 with SMTP id w130mr2233915vke.72.1444240977181;
 Wed, 07 Oct 2015 11:02:57 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Wed, 7 Oct 2015 11:02:27 -0700 (PDT)
In-Reply-To: <vpqmvvu4l3o.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279191>

On Wed, Oct 7, 2015 at 11:28 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Oct 7, 2015 at 12:33 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> To go a bit further, you can pre-build a string or strbuf aligned_short
>>> with value like "%%(align:20,left)%%(refname:short)%%(end)" and use it
>>> where needed (it's not a constant because you have to introduce maxwidth
>>> into the string, so it's not a candidate for #define).
>>>
>>
>> Again, the remote has a remote prefix here, so we can't really factor
>> it out much.
>
> Ah, OK, there's a %s containing the remote prefix in "remote" that is
> not there in "local", and in the last version you sent it's already
> factored for verbose > 1 and verbose == 1. Indeed, there's nothing more
> to gain here.

I'll send version2 of the patch series to the list then :)

-- 
Regards,
Karthik Nayak
