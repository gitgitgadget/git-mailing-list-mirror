From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH/RFC] test-lib: add support for colors
 without tput
Date: Fri, 14 Sep 2012 20:11:48 +0200
Message-ID: <CABPQNSZeuG-J8nVH15hpsX+bkM3CPcUGBNgNOUp6AtTipSdVbQ@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
 <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com> <50536943.4030300@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDR53PPJ7YHRBDPHZWBAKGQEEXZRPWQ@googlegroups.com Fri Sep 14 20:12:36 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBDPHZWBAKGQEEXZRPWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBDPHZWBAKGQEEXZRPWQ@googlegroups.com>)
	id 1TCaNV-0000XY-LH
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 20:12:33 +0200
Received: by mail-gh0-f186.google.com with SMTP id f18sf2457604ghb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=wcL4OIfwt+XGQ55acJpozSAiqPxJ7JOUCveJqymx77A=;
        b=eDC1tO3nG6Na7UnCjmrUhhVWpLCp+jqZwsY3CFlz9GO87r7eBa1j0LWpQZMXiQx+LE
         0CM5bor5rvN7cNjbqQwDP2PZZFlqUx8BtQdcSwpg+T+M2L8zlgq8Wi7hfjDNKpwpriLS
         xUuZVqeq77KijE1nRxOgspnjL2QeINcfOVs4v+xcH3HgHbZJaAybnX8tmiHt1lfWY8BZ
         LuIlHH0psXTCRQ/3jsSpkn/EcfTS6APl+QifRVWbIfh+VMdViuQZKd2H5tMbmxcFPSR8
         HE6Z2Wqy6Pwy9lMfB2Y/BhPBS1ybJyhGqVT+F0NBXMZFEbKnCZMonGFgXSIXFKqEMwqw
         OW4A==
Received: by 10.236.192.164 with SMTP id i24mr742908yhn.14.1347646349723;
        Fri, 14 Sep 2012 11:12:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.154.77 with SMTP id n13ls3654451vcw.4.gmail; Fri, 14 Sep
 2012 11:12:29 -0700 (PDT)
Received: by 10.59.0.226 with SMTP id bb2mr489952ved.30.1347646349209;
        Fri, 14 Sep 2012 11:12:29 -0700 (PDT)
Received: by 10.59.0.226 with SMTP id bb2mr489951ved.30.1347646349201;
        Fri, 14 Sep 2012 11:12:29 -0700 (PDT)
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com [209.85.220.182])
        by gmr-mx.google.com with ESMTPS id r14si21547vdu.1.2012.09.14.11.12.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 11:12:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.182 as permitted sender) client-ip=209.85.220.182;
Received: by mail-vc0-f182.google.com with SMTP id fw7so6729130vcb.13
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 11:12:29 -0700 (PDT)
Received: by 10.220.150.15 with SMTP id w15mr3050313vcv.68.1347646349138; Fri,
 14 Sep 2012 11:12:29 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 11:11:48 -0700 (PDT)
In-Reply-To: <50536943.4030300@kdbg.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.182 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205523>

On Fri, Sep 14, 2012 at 7:28 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 14.09.2012 18:58, schrieb Erik Faye-Lund:
>>       tput () {
>>               case "$1" in
>>               bold)
>> -                     echo -ne "\033[1m" ;;
>> +                     printf "\033[1m" ;;
>>               setaf)
>> -                     echo -ne "\033[0;3$2m" ;;
>> +                     printf "\033[0;3$2m" ;;
>
> This should be
>                         printf '\033[0;3%sm' "$2" ;;

Is there a reason for %s rather than %d? It seem it only takes
integers, and with %d at least we'd get an error message if someone
started doing something else...

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
