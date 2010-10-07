From: Peter Harris <pharris@opentext.com>
Subject: Re: [PULL] Pull request from msysGit
Date: Thu, 07 Oct 2010 15:30:46 -0400
Message-ID: <4CAE1FE6.9020306@opentext.com>
References: <87ocb9zfbf.fsf@fox.patthoyts.tk> <4CAE00C5.1050509@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
   Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
   msysgit@googlegroups.com, sschuberth@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: msysgit+bncCAAQusG45QQaBEK8V6U@googlegroups.com Thu Oct 07 21:34:44 2010
Return-path: <msysgit+bncCAAQusG45QQaBEK8V6U@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gw0-f58.google.com ([74.125.83.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCAAQusG45QQaBEK8V6U@googlegroups.com>)
	id 1P3wEl-0004ch-EL
	for gcvm-msysgit@m.gmane.org; Thu, 07 Oct 2010 21:34:43 +0200
Received: by gwb20 with SMTP id 20sf148496gwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Oct 2010 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:received:received:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:x-originalarrivaltime
         :x-archived:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=j1YGAMwQzgFc2jBjjVywDaU+SipTifT3rPCJ3gzHsCE=;
        b=d89LkAAj5rejM5phKi4UmEFXbc6CrJNG/p8dB0gh/yDc2xSii2A90yIN4V5qWaNCB+
         BatmIepEmw7BChvyDc+gKb6/iN0WmRS+pUS1EhhBVHtFsY64b23MPJIWngn6n1NmJCmf
         rp0+X8z42pskfJWLJ04/bXj9qoXug3r/IVjnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:x-originalarrivaltime:x-archived
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=D6mfB4qu9+81ftlTdbsrjxX2uZ+kSHSnOXwtpKawdSIlSFDUJRYkCKFUV/WHytChs6
         jMTxwuTxwG8YczNJUSq8ys2NGCTBlysCwx+knR6sU8QtJ71YgckT+DBHAlBfb44lLhsm
         t0eJDhw0nc364KJyBj+t+0kQbr0J3n5bDWURc=
Received: by 10.90.219.3 with SMTP id r3mr138094agg.40.1286480058961;
        Thu, 07 Oct 2010 12:34:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.150.132.3 with SMTP id f3ls610975ybd.6.p; Thu, 07 Oct 2010
 12:34:18 -0700 (PDT)
Received: by 10.151.84.16 with SMTP id m16mr259440ybl.7.1286480058106;
        Thu, 07 Oct 2010 12:34:18 -0700 (PDT)
Received: by 10.229.192.16 with SMTP id do16mr180359qcb.22.1286479849831;
        Thu, 07 Oct 2010 12:30:49 -0700 (PDT)
Received: by 10.229.192.16 with SMTP id do16mr180357qcb.22.1286479849794;
        Thu, 07 Oct 2010 12:30:49 -0700 (PDT)
Received: from opentext.com (smtpout.opentext.com [204.138.115.203])
        by gmr-mx.google.com with ESMTP id 19si453231qci.4.2010.10.07.12.30.49;
        Thu, 07 Oct 2010 12:30:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of pharris@opentext.com designates 204.138.115.203 as permitted sender) client-ip=204.138.115.203;
Received: from otwlpm02.smtp.dmz.opentext.com (otwlpm02.smtp.dmz.opentext.com [192.168.15.231])
	by opentext.com (8.12.8/8.12.8) with ESMTP id o97JUmag016272
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL);
	Thu, 7 Oct 2010 15:30:48 -0400
Received: from vectorsvc.wl.opentext.com (ava.wl.opentext.com [172.21.5.96])
	by otwlpm02.smtp.dmz.opentext.com (8.14.4/8.14.4) with ESMTP id o97JUlT8027844
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Oct 2010 15:30:47 -0400
	(envelope-from pharris@opentext.com)
Received: from OTWLMX04.opentext.net (otwlxg04.wl.opentext.com [10.2.102.26])
	by vectorsvc.wl.opentext.com (8.12.8/8.12.8) with ESMTP id o97JUkHj016260;
	Thu, 7 Oct 2010 15:30:47 -0400
Received: from [10.3.15.195] ([10.3.15.195]) by OTWLMX04.opentext.net with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 7 Oct 2010 15:30:46 -0400
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <4CAE00C5.1050509@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.1.1
X-OriginalArrivalTime: 07 Oct 2010 19:30:46.0790 (UTC) FILETIME=[2407C260:01CB6656]
X-Archived: msg.2hH74ew:2010-10-07:otwlpm02.smtp.dmz.opentext.com
X-Original-Sender: pharris@opentext.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pharris@opentext.com designates 204.138.115.203 as permitted
 sender) smtp.mail=pharris@opentext.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158446>

On 2010-10-07 13:17, Ramsay Jones wrote:
> Now, Peter Harris has already submitted a fix for this, which is
> currently on the work/msvc-fixes branch, which contains:
> 
>     358f1be Modify MSVC wrapper script
>     38bd27d Fix MSVC build
> 
> The suggested fix is given in commit 38bd27d. However, I prefer a
> different solution, which is given below:
> 
> --- >8 ---
> diff --git a/compat/mingw.h b/compat/mingw.h
> index afedf3a..445d1a1 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -12,12 +12,6 @@ typedef int pid_t;
>  #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
>  #define S_ISSOCK(x) 0
>  
> -#ifndef _STAT_H_
> -#define S_IRUSR 0
> -#define S_IWUSR 0
> -#define S_IXUSR 0
> -#define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
> -#endif
>  #define S_IRGRP 0
>  #define S_IWGRP 0
>  #define S_IXGRP 0
> --- 8< ---
> 
> Note that, for *both* MinGW and MSVC, the deleted #defines
> are not wanted, pointless and just plain wrong! :-D

I didn't realize that the defines were not wanted for MinGW either.

I heartily approve of removing code rather than just ifdefing around it.
Please use this version of the patch instead of mine.

Peter Harris
-- 
               Open Text Connectivity Solutions Group
Peter Harris                    http://connectivity.opentext.com/
Research and Development        Phone: +1 905 762 6001
pharris@opentext.com            Toll Free: 1 877 359 4866
