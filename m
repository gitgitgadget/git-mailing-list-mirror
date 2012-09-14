From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH/RFC] test-lib: add support for colors
 without tput
Date: Fri, 14 Sep 2012 19:31:00 +0200
Message-ID: <CABPQNSbKWb-tWqFBtBCenJNDE6oVLyCbspoK+vLYj9yD6ZraWQ@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
 <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com> <50536943.4030300@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDR53PPJ7YHRB7OTZWBAKGQEN6NNURA@googlegroups.com Fri Sep 14 19:31:50 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB7OTZWBAKGQEN6NNURA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB7OTZWBAKGQEN6NNURA@googlegroups.com>)
	id 1TCZk2-0008U7-5w
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:31:46 +0200
Received: by qcsc2 with SMTP id c2sf3328528qcs.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=lT3+ugV3UYaZowSUfr061Qz9GXFzJQURj4Rb1jRFffU=;
        b=c4bKCstDVNNJE5EtW8lm4TJhZBWeVmnW6hYiwQ1xiq0Q/27N7EgKXQzXdRqL6NYa7Y
         75RmHHFlERMVyFRiIGhXKWVj2GMXZrSrnGGriEr48uUpoNf6sgGwWbdT7Msf1utlvkHp
         DNrRlp/MGjrbXUhPvnaESK6h1JiL6b3k0J7C/0/qanpW2O252xARGLlNEWtHK5eFpI/6
         3WnJT0Vio5di1wj2p+WyK8A0ahPcFtVg42LCoA6VHsIc0uPqLWNQfrLBZuJBA0DoWLMJ
         FOGtnZlC9Hi7cBbKdo3qYWPvDVE0iU978PlPvOqJF1R1iqJSDx7st0W2qWM3H+72DG94
         BK/A==
Received: by 10.236.142.211 with SMTP id i59mr717562yhj.1.1347643901904;
        Fri, 14 Sep 2012 10:31:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.149.129 with SMTP id t1ls3669078vcv.0.gmail; Fri, 14 Sep
 2012 10:31:41 -0700 (PDT)
Received: by 10.58.132.238 with SMTP id ox14mr527241veb.15.1347643901450;
        Fri, 14 Sep 2012 10:31:41 -0700 (PDT)
Received: by 10.58.132.238 with SMTP id ox14mr527239veb.15.1347643901442;
        Fri, 14 Sep 2012 10:31:41 -0700 (PDT)
Received: from mail-vb0-f41.google.com (mail-vb0-f41.google.com [209.85.212.41])
        by gmr-mx.google.com with ESMTPS id s13si35456vde.2.2012.09.14.10.31.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:31:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.41 as permitted sender) client-ip=209.85.212.41;
Received: by vbkv13 with SMTP id v13so5028826vbk.28
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 10:31:41 -0700 (PDT)
Received: by 10.220.247.137 with SMTP id mc9mr2910907vcb.52.1347643901302;
 Fri, 14 Sep 2012 10:31:41 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 10:31:00 -0700 (PDT)
In-Reply-To: <50536943.4030300@kdbg.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.41 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205514>

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
>

That's probably a good idea, yeah.

>>               sgr0)
>> -                     echo -ne "\033(\033[m" ;;
>> +                     printf "\033(\033[m" ;;
>>               esac
>>       }
>>  fi
>
> Did you test this only in rxvt or in CMD as well? (I hadn't time to
> test, yet, so I'm asking :-)

I don't have rxvt installed, but it works for me in CMD also.

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
