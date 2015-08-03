From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 0/11] Port tag.c over to use ref-filter APIs
Date: Tue, 4 Aug 2015 03:43:46 +0530
Message-ID: <CAOLa=ZTf-rQuc_Hv=8NnYx_j8YGJuYNmOa+nz=MeoxAK6JFU3Q@mail.gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
 <xmqq8u9s86n3.fsf@gitster.dls.corp.google.com> <CAOLa=ZSRLaRjyif_7auUWfX6DmtA_g2MonumDf-3cMZvvrRXGg@mail.gmail.com>
 <xmqq7fpc6n5o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:14:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNzx-0003mI-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbbHCWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:14:17 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33867 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbHCWOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:14:16 -0400
Received: by oigu133 with SMTP id u133so35095989oig.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0MxDmcOIuA5ct8atQUguKapPCWGEptc/COVJIbjBIVc=;
        b=BcDYe+QTsWIV86UN8WYKStnz6lNVUyMo6/HluNt0e1acZERkaFw0F1k6bvlGKqGd4d
         7T6yufzern7XGe/z4dDAf3eIiA/lqGqvhHSX0DIIsG8Lvd/AvyHKdaC+Em7qJs3VhAgv
         mWMkv7WlwlOPiTMVpVYdYm1kwgRSc0Yoc3b2vreVHAkJ8OFkev4vfym4+zSA5j/CqIUS
         uyQcm37rL3Q2oHN7cBK2P5gm33Spt3Q4GjEGO0YhCzmJaM8kO4ukwuo8lMZAcHmvoXTn
         41JQPSx6qeefaZLzHfyuoD6rXxiZFPDRRvexa2Xb+JSCiZjpT+5/rfx3pp/DcVnd1jVX
         v+Pw==
X-Received: by 10.202.92.6 with SMTP id q6mr248906oib.11.1438640056234; Mon,
 03 Aug 2015 15:14:16 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 15:13:46 -0700 (PDT)
In-Reply-To: <xmqq7fpc6n5o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275218>

On Tue, Aug 4, 2015 at 3:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Aug 4, 2015 at 1:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> It is very very dissapointing to allow the "next atom only"
>>> implementation to squat on a good name "align:<type>,<width>",
>>> especially when I thought that the list agreed
>>>
>>>   %(align:<type>,<width>) any string with or without %(atom) %(end)
>>>
>>> would be the way to go.
>>
>> From what I read, I thought we wanted the next atom or string to be
>> aligned, if we need to align everything within the %(end) atom.
>
> Is that a serious comment?
>
> Did I read too much into your $gmane/275119, expecting that you
> understood everything you are saying "That's a good way to go" to?

Sorry, I kinda was thinking only WRT to the %(if) and %(end) part of it.
Even though you clearly mentioned about %(align) also.

>
>> I could do that :)
>
> Sure ;-)

I have it ready, will wait to see if there are more comments and send with
next iteration of the series.

-- 
Regards,
Karthik Nayak
