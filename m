From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 19:52:53 +0200
Message-ID: <CABPQNSYzSzMrmY4Jto+xig2BRL-P0xJDcUiBV8TtV3Ehd1DD_w@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com> <20120914174439.GA16657@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBDR53PPJ7YHRBHW6ZWBAKGQE3LQD7FA@googlegroups.com Fri Sep 14 19:53:40 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBHW6ZWBAKGQE3LQD7FA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBHW6ZWBAKGQE3LQD7FA@googlegroups.com>)
	id 1TCa5D-00052P-3K
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:53:39 +0200
Received: by qcsc2 with SMTP id c2sf3339623qcs.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=OS/75xNUHnQ4ZKLxw+30QE3XY7IeJciYTNxOkjWpHzc=;
        b=kRcVQa7C8T0aBXnUe5aH1ra0H7LGCPtv1umfJcbFV8djGlqf3AfpUql+hNTWg8NDwU
         RogOCVCA/lmfl1VvhCrhSN6t1aNlhJNm4Kh4/t7eCzqnWXo4NZlALLzAaz/S4jUDG+g2
         tBLDCcgO1AQOqEGwWX7GAnuCeL28XbBDN9dJyyOeq6lkYPRaf695jMePI7yXmmKO52Rl
         dd8F/Q3k35EShqye7K7DBcmD3pOQGJi/lpyUl6O+ulhgex9QwhX2ZBnFKTVTmfPvEHmA
         JznQzudTz+Ak4azQ+od3uxDss4YprBWlzaJ4afA/kzMxmfMVW+awe6sJ2oMPXgcI9YaM
         MpXg==
Received: by 10.236.176.103 with SMTP id a67mr737766yhm.2.1347645214840;
        Fri, 14 Sep 2012 10:53:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.155.6 with SMTP id q6ls3683874vcw.3.gmail; Fri, 14 Sep
 2012 10:53:34 -0700 (PDT)
Received: by 10.59.1.102 with SMTP id bf6mr537423ved.21.1347645214355;
        Fri, 14 Sep 2012 10:53:34 -0700 (PDT)
Received: by 10.59.1.102 with SMTP id bf6mr537422ved.21.1347645214347;
        Fri, 14 Sep 2012 10:53:34 -0700 (PDT)
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com [209.85.220.176])
        by gmr-mx.google.com with ESMTPS id s13si38619vde.2.2012.09.14.10.53.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:53:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.176 as permitted sender) client-ip=209.85.220.176;
Received: by vcbfl11 with SMTP id fl11so4823652vcb.7
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 10:53:34 -0700 (PDT)
Received: by 10.220.155.3 with SMTP id q3mr3055255vcw.11.1347645214175; Fri,
 14 Sep 2012 10:53:34 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 10:52:53 -0700 (PDT)
In-Reply-To: <20120914174439.GA16657@sigill.intra.peff.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.176 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205518>

On Fri, Sep 14, 2012 at 7:44 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 14, 2012 at 06:41:45PM +0200, Erik Faye-Lund wrote:
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 78c4286..7d1b34b 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>>  # This test checks if command xyzzy does the right thing...
>>  # '
>>  # . ./test-lib.sh
>> +
>> +if ! which tput > /dev/null ; then
>
> Testing the return value of "which" is not portable (I know, it's
> insane; SunOS is the common offender). Use "type" instead.

Junio already noticed it, and I suggested a fix that involved running
it. However, I like your fix much better, thanks :)

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
