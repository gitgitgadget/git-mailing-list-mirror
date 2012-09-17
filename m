From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Mon, 17 Sep 2012 19:39:36 +0200
Message-ID: <50576058.4020508@kdbg.org>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com> <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com> <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com> <50536943.4030300@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCJYV6HBKQINVQG5QICRUBDXYKQVK@googlegroups.com Mon Sep 17 19:39:49 2012
Return-path: <msysgit+bncBCJYV6HBKQINVQG5QICRUBDXYKQVK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lpp01m010-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQINVQG5QICRUBDXYKQVK@googlegroups.com>)
	id 1TDfIO-0005gZ-Ev
	for gcvm-msysgit@m.gmane.org; Mon, 17 Sep 2012 19:39:44 +0200
Received: by lahd3 with SMTP id d3sf2420627lah.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Sep 2012 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=OK+ttpnAlKNu7w1rMDpYLzU6LYkT9FnGxVoEUm8pcV8=;
        b=jeilHtnnxYXPTBK5ITUMhl/mbslP8fRGfVyolXyH7evx7Fp6ZKKjVYNTUOBDNJNA+O
         yodjHaemUYWXfGkeNtMXYSKmpWGUY8E4WncGbXhApxfL8nDe0xpX4f/6lSW3lT/nSXUm
         fRt2d1+0BgqqJFCzc4VoU+l56UWVEuA2Og4OCzzAkYuBL9A5ikZZWaonhJ0MtURs6gui
         vcRdnc0ZBzqhkvVMN77G9jEj3FdlVFu0tr3d4bWAft84UoRIbC2LPDBVrt4NgDxgHuF7
         dUZgURAk8EQfQ5Lg4DtqYCMl2Mk0Yy/5etbMTPPEThaVTuaSKPKymkN3QrZLgcAuT3VE
         fKHA== 
Received: by 10.204.145.73 with SMTP id c9mr752800bkv.16.1347903579676;
        Mon, 17 Sep 2012 10:39:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.7.203 with SMTP id e11ls6721565bke.8.gmail; Mon, 17 Sep
 2012 10:39:38 -0700 (PDT)
Received: by 10.204.128.207 with SMTP id l15mr1373335bks.4.1347903578525;
        Mon, 17 Sep 2012 10:39:38 -0700 (PDT)
Received: by 10.204.128.207 with SMTP id l15mr1373334bks.4.1347903578508;
        Mon, 17 Sep 2012 10:39:38 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp4.bon.at. [195.3.86.186])
        by gmr-mx.google.com with ESMTPS id 23si895213bku.1.2012.09.17.10.39.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 10:39:38 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 901E62C4010;
	Mon, 17 Sep 2012 19:39:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B706C19F3D7;
	Mon, 17 Sep 2012 19:39:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <50536943.4030300@kdbg.org>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 195.3.86.186 is neither permitted nor denied by best guess record for domain
 of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205720>

Am 14.09.2012 19:28, schrieb Johannes Sixt:
> Am 14.09.2012 18:58, schrieb Erik Faye-Lund:
>>  	tput () {
>>  		case "$1" in
>>  		bold)
>> -			echo -ne "\033[1m" ;;
>> +			printf "\033[1m" ;;
>>  		setaf)
>> -			echo -ne "\033[0;3$2m" ;;
>> +			printf "\033[0;3$2m" ;;
> 
> This should be
> 			printf '\033[0;3%sm' "$2" ;;
> 
>>  		sgr0)
>> -			echo -ne "\033(\033[m" ;;
>> +			printf "\033(\033[m" ;;
>>  		esac
>>  	}
>>  fi
> 
> Did you test this only in rxvt or in CMD as well? (I hadn't time to
> test, yet, so I'm asking :-)

I tested your patch with this fixup, and it works for me (in CMD).

-- Hannes

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
