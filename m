From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 19:11:34 +0200
Message-ID: <CABPQNSZSQCvoD=n-iQPSHbUQ2S4c0P1VTZfiHkRcwpm=7dk5Vg@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
 <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com> <CA+EOSBm4cSu8cxPc-3Eqm0J7deeht6FMMUGBKP6vx8VDcVrGPQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRB36KZWBAKGQE57R74EY@googlegroups.com Fri Sep 14 19:12:23 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB36KZWBAKGQE57R74EY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB36KZWBAKGQE57R74EY@googlegroups.com>)
	id 1TCZRH-0004g1-0Z
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:12:23 +0200
Received: by vcbfy7 with SMTP id fy7sf3300527vcb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=20K0gQCXv0FunQtWybOq/M6F+5fbL4LCueYPTCvfd4E=;
        b=m29A6OnliP4/sKGZ/ctVm3YsWEO6HT/NGp5r1rNb1/j585mJ+fao1RxtzC0L98hU26
         tLcdERJIZ6NqJnIFSpAN0fbNdb8YlOZSkBTZxsgXkvS+JgLe/11L8DDRJ4In182FTCyu
         SG8v7qyHKdweDcC9nsf/kb1zrTY3Fc6YKuLV/LS4Fjgswro+FVeM8m2gWtogyRh+mRTp
         2u5Wk2sD4MOEiumCf10YdmrHH+kWPBtJlzaox7B+Mp8KdUGSczTRiZFWD2dnXaRcvgI1
         A5mtaeq5YQkNZz6IpKko8ki1UKIh5LnsYrkqW70gbLUthKUwingjQmiTgDNfi7Fs4yId
         GS6g==
Received: by 10.236.152.5 with SMTP id c5mr706811yhk.10.1347642735625;
        Fri, 14 Sep 2012 10:12:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.147.138 with SMTP id l10ls3679717vcv.7.gmail; Fri, 14 Sep
 2012 10:12:14 -0700 (PDT)
Received: by 10.59.7.234 with SMTP id df10mr482865ved.23.1347642734975;
        Fri, 14 Sep 2012 10:12:14 -0700 (PDT)
Received: by 10.59.7.234 with SMTP id df10mr482864ved.23.1347642734966;
        Fri, 14 Sep 2012 10:12:14 -0700 (PDT)
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com [209.85.220.170])
        by gmr-mx.google.com with ESMTPS id ef10si32493vdb.3.2012.09.14.10.12.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:12:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.170 as permitted sender) client-ip=209.85.220.170;
Received: by mail-vc0-f170.google.com with SMTP id fk26so4579183vcb.15
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 10:12:14 -0700 (PDT)
Received: by 10.58.32.234 with SMTP id m10mr2923115vei.60.1347642734770; Fri,
 14 Sep 2012 10:12:14 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 10:11:34 -0700 (PDT)
In-Reply-To: <CA+EOSBm4cSu8cxPc-3Eqm0J7deeht6FMMUGBKP6vx8VDcVrGPQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.170 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205507>

On Fri, Sep 14, 2012 at 7:08 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> 2012/9/14 Erik Faye-Lund <kusmabite@gmail.com>:
>> On Fri, Sep 14, 2012 at 6:54 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>>> index 78c4286..7d1b34b 100644
>>>> --- a/t/test-lib.sh
>>>> +++ b/t/test-lib.sh
>>>> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>>>>  # This test checks if command xyzzy does the right thing...
>>>>  # '
>>>>  # . ./test-lib.sh
>>>> +
> Nice. But this setting should be check that we have a terminal first isn't ?
> Some test like this before
>
> test "X$$TERM" != Xdumb \
> &&  test -t 1 2>/dev/null  \
> && ....
>
> or the inverse logic. This is what automake  and popt autogen.sh does.

There's already such a check a few lines further down, and tput isn't
used in such cases.

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
