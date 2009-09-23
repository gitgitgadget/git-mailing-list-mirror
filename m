From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Add MinGW header files to build git with MSVC
Date: Wed, 23 Sep 2009 13:29:28 +0200
Message-ID: <4ABA0698.7020604@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com> <a416a9d0-90f3-40b7-bd39-ea67ceb2e0b9@j19g2000vbp.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,  Johannes.Schindelin@gmx.de, gitster@pobox.com, j6t@kdbg.org,  lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 23 13:29:57 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqQ2j-0003wx-86
	for gcvm-msysgit@m.gmane.org; Wed, 23 Sep 2009 13:29:53 +0200
Received: by yxe1 with SMTP id 1so665374yxe.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Sep 2009 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=oIc4uIYQDY9gvjK40tldnPrzjLutpLn1BVqGaFA0qjs=;
        b=l3LdSudpAjaxpY40wrnLkBKxUp/a+U6pAvwdYOyaEYnrw0Y4yvjCujWZWdyNN5kUlC
         cWSGpTgCmsrAAoGn/24rIOvHIfN2ixacFS6Exwn/I0veklx68jmcWb23OIKXMwdMkR8a
         XZoaE5Swg8Fo0S3ftxE+c4VlNrW+FHxkVLa5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=A/SaTPuGKZ61GwNOiW1oQW29mO1d9OzaH5dZpHmDifYDitADv19CLpk1NCf3uRrqav
         ALoaRm2wLY0XkjDg4Qfqg81nvhOTlinp9iCkm5ZCRbOeofXzPfnfBwrjyHUvLYgnUvTH
         UBPtsRVAHmhNCeQhNqdnUYIfA4zWvZJg77vwM=
Received: by 10.150.168.4 with SMTP id q4mr262699ybe.4.1253705385953;
        Wed, 23 Sep 2009 04:29:45 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7145yqi.0;
	Wed, 23 Sep 2009 04:29:36 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.172.7 with SMTP id z7mr296946ebo.21.1253705374915; Wed, 23 Sep 2009 04:29:34 -0700 (PDT)
Received: by 10.211.172.7 with SMTP id z7mr296945ebo.21.1253705374849; Wed, 23 Sep 2009 04:29:34 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144]) by gmr-mx.google.com with ESMTP id 13si177227ewy.2.2009.09.23.04.29.33; Wed, 23 Sep 2009 04:29:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.144 as permitted sender) client-ip=74.125.78.144;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.144 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 5so346086eyb.0 for <msysgit@googlegroups.com>; Wed, 23 Sep 2009 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=jIJk/IUU68GZgigsSvn77V2kcb8KX+lxtqmH/o5lDpc=; b=CZ0IlPLuETL1JR0WtL5Arn23j6BwzlNkxefkqO2JfY+MOOV38+9aic55OOt/aatKTq 4qj9s8/G0wRQ7chv42TBi5+Pf14vlhgXfubcl+YWXD6+5Eq4Mwpi2qNDroOyg2jums6s HKP2YfVsuZZHqXBdOhNppqFkWFxEn8MPHTQ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=rsJYuCp2FvDVxAH8g+kZEp5gramX0t7IAit/vQTU719lb6zeqfUdquP63BrvcbNsP8 dZn9UYR8xhKpRuHlsQLVd5tw/OdqUEuhp/9tUDw6DXmGpBviObX6YpwJbNh2Ef6Z+vaf X54NYWA2n0DhXeSJ99EQe/I+XMqQseEgl7Ad4=
Received: by 10.211.153.2 with SMTP id f2mr1213189ebo.42.1253705373723; Wed, 23 Sep 2009 04:29:33 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104]) by mx.google.com with ESMTPS id 28sm684906eyg.44.2009.09.23.04.29.32 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 23 Sep 2009 04:29:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <a416a9d0-90f3-40b7-bd39-ea67ceb2e0b9@j19g2000vbp.googlegroups.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128980>


Sebastian Schuberth said the following on 23.09.2009 12:03:
>> From: Frank Li <lznuaa@gmail.com>
>>
>> Added the header files dirent.h, unistd.h and utime.h
>> Add alloca.h, which simply includes malloc.h, which defines alloca
>>
>> Signed-off-by: Frank Li <lznuaa@gmail.com>
>> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> 
> [...]
> 
>>  create mode 100644 compat/vcbuild/include/sys/utime.h
> 
> Have you considered simply including MSVC's sys/utime.h here? From a
> first glance, it seems as if it contains all required symbols.

This was a patch which originated from Frank Li's original series. 
While we might have been able to simply use the MSVC one, I'm sure 
Frank had a reason for overriding it with the small content which you 
see in this patch. We'll have to ask Frank about that. We can always 
remove it now, if the MSVC version works ok and doesn't introduce any 
compiler errors/warnings.

While I appreciate your comments, they are a tad late, as the whole 
series is already in master.. :)
  See http://repo.or.cz/w/git.git?a=shortlog;h=refs/heads/master

So, give it a try, to see if removing the include override
     compat/vcbuild/include/utime.h
doesn't introduce a regression, and send a patch for it.

--
.marius
