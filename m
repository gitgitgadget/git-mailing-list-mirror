From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 15/17] Add MSVC to Makefile
Date: Mon, 14 Sep 2009 21:09:13 +0200
Message-ID: <4AAE94D9.7000802@gmail.com>
References: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>	 <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>	 <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>	 <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstormo@gmail.com>	 <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>	 <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>	 <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>	 <cover.1252925290.git.mstormo@gmail.com>	 <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>	 <abaa803c30801c570f4b8e1baf6648a482bf295d.1252925290.git.mstormo@gmail.com> <81b0412b0909140706s32e888ddwe4bbd668c3a7ccfd@mail.gma
 il.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 21:09:20 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnGvP-0001pO-Dh
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 21:09:19 +0200
Received: by qyk30 with SMTP id 30so3894168qyk.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ZItClC8mBrwjiH8wM47KWOsITlxZH4wi7NwMaEORzPs=;
        b=2tGIH5V/GwcFpAuoTs+XV1kblWkvTQHmqHFGwp1IYFtkpdUAwNdXH62Vpvm9i8RRA6
         kWG1+SYDpWktf+gA4tPswS2gDGOZcscEcvDIfb/pUGpE2IoqNiSpzDnSVSak3WjBFTMB
         R38KT59xRJukpEvj3K5xpI6A/kmgrXEkU/s3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=AWpkCr1y1E99a3+5pdSkxaz1fcY2r5e7OAYEISFgBjsee5qSyC3qjYfqRu7vmdtaxa
         zj1mI+VlagaiFeWvBMUxWvwMvyJ+SSMFn/qfsUZPT7ekgc9yYGwsQvk28MY8PQ7FkXL9
         BwshIxE2CsGxafs/BLfGUeVsK+ubMfuIBKaKo=
Received: by 10.224.124.131 with SMTP id u3mr582336qar.3.1252955352155;
        Mon, 14 Sep 2009 12:09:12 -0700 (PDT)
Received: by 10.176.151.15 with SMTP id y15gr6995yqd.0;
	Mon, 14 Sep 2009 12:09:08 -0700 (PDT)
X-Sender: marius@storm-olsen.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.132.10 with SMTP id j10mr1012755ebn.3.1252955346843; Mon, 14 Sep 2009 12:09:06 -0700 (PDT)
Received: by 10.211.132.10 with SMTP id j10mr1012754ebn.3.1252955346811; Mon, 14 Sep 2009 12:09:06 -0700 (PDT)
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com [209.85.219.225]) by gmr-mx.google.com with ESMTP id 16si1368001ewy.3.2009.09.14.12.09.06; Mon, 14 Sep 2009 12:09:06 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.219.225 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) client-ip=209.85.219.225;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 209.85.219.225 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) smtp.mail=marius@storm-olsen.com
Received: by ewy25 with SMTP id 25so1535699ewy.9 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 12:09:06 -0700 (PDT)
Received: by 10.210.7.21 with SMTP id 21mr7269574ebg.75.1252955346569; Mon, 14 Sep 2009 12:09:06 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206]) by mx.google.com with ESMTPS id 7sm1875727eyg.22.2009.09.14.12.09.05 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 12:09:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <81b0412b0909140706s32e888ddwe4bbd668c3a7ccfd@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128492>


Alex Riesen said the following on 14.09.2009 16:06:
> On Mon, Sep 14, 2009 at 15:11, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>> @@ -1327,7 +1379,7 @@ strip: $(PROGRAMS) git$X
>>  git.o: git.c common-cmds.h GIT-CFLAGS
>>        $(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
>>                '-DGIT_HTML_PATH="$(htmldir_SQ)"' \
>> -               $(ALL_CFLAGS) -c $(filter %.c,$^)
>> +               $(ALL_CFLAGS) -o git.o -c $(filter %.c,$^)
> 
> Why do you use "-o git.o" instead of "-o $@"?

No reason really. I'll resend tomorrow.

--
.marius
