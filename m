From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 19:12:20 +0200
Message-ID: <CA+EOSBki2syrwdfzFXzBPuJAhH2jfgAbL=W+yP7bx8WXMkYiMQ@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
	<CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
	<CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
	<CA+EOSBm4cSu8cxPc-3Eqm0J7deeht6FMMUGBKP6vx8VDcVrGPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBD333LE6YYIRB5GKZWBAKGQECYROPLY@googlegroups.com Fri Sep 14 19:12:27 2012
Return-path: <msysgit+bncBD333LE6YYIRB5GKZWBAKGQECYROPLY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD333LE6YYIRB5GKZWBAKGQECYROPLY@googlegroups.com>)
	id 1TCZRJ-0004kc-RX
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:12:26 +0200
Received: by obbta17 with SMTP id ta17sf3313009obb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=+4iajMdmVgSFxsup2TOo5VxbPe0mnajPYpW9C25AGrs=;
        b=vwL0mUAexOtyAgfXIvCqvxYP0PmhWChThTDuC8H9a42dMnuqDZ2TaVw8R5imLVbWD3
         gjq5T1hR6Gb/IjTfzedb7CBgHTLBWoZIpet+3GB8ue+8dFTi+IJlk9WSj21xXiSTfZO7
         V6sn2A9XBOaI10xgzxmag5zDnGwhJTHDvEgvgPbbSSdKznKKYPTX05ot/eYga7AqAW30
         DlL2O29iv+hBxUCYICno15i+lv3xWYPfvV4Z35B5tQewyKzu9Lk1YuNNoGvY6uNQUi8c
         yhEr4zxLlzZ1SYwA0rrTUtpayUlGlBkDk9WQBli+8tDqvZBxq+Z8AdbRMr9/pWiCoRdW
         MVpg==
Received: by 10.50.88.137 with SMTP id bg9mr1586989igb.0.1347642741388;
        Fri, 14 Sep 2012 10:12:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.231.62.200 with SMTP id y8ls9684583ibh.5.gmail; Fri, 14 Sep
 2012 10:12:20 -0700 (PDT)
Received: by 10.50.149.228 with SMTP id ud4mr1556794igb.0.1347642740688;
        Fri, 14 Sep 2012 10:12:20 -0700 (PDT)
Received: by 10.50.149.228 with SMTP id ud4mr1556791igb.0.1347642740629;
        Fri, 14 Sep 2012 10:12:20 -0700 (PDT)
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com [209.85.210.170])
        by gmr-mx.google.com with ESMTPS id mb9si3303254igc.1.2012.09.14.10.12.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:12:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitter.spiros@gmail.com designates 209.85.210.170 as permitted sender) client-ip=209.85.210.170;
Received: by mail-iy0-f170.google.com with SMTP id m10so2776082iam.15
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 10:12:20 -0700 (PDT)
Received: by 10.50.173.71 with SMTP id bi7mr3837342igc.3.1347642740503; Fri,
 14 Sep 2012 10:12:20 -0700 (PDT)
Received: by 10.64.82.194 with HTTP; Fri, 14 Sep 2012 10:12:20 -0700 (PDT)
In-Reply-To: <CA+EOSBm4cSu8cxPc-3Eqm0J7deeht6FMMUGBKP6vx8VDcVrGPQ@mail.gmail.com>
X-Original-Sender: gitter.spiros@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of gitter.spiros@gmail.com designates 209.85.210.170 as permitted
 sender) smtp.mail=gitter.spiros@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205508>

2012/9/14 Elia Pinto <gitter.spiros@gmail.com>:
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
and in reality this echo use is not portable.
http://ftp.gnu.org/old-gnu/Manuals/autoconf-2.53/html_node/Limitations-of-Builtins.html

In popt 1_17 autogen.sh does

red=; grn=; lgn=; blu=; std=;
test "X$$TERM" != Xdumb \
&&  test -t 1 2>/dev/null  \
&& { \
  red='^[[0;31m'; \
  grn='^[[0;32m'; \
  lgn='^[[1;32m'; \
  blu='^[[1;34m'; \
  std='^[[m'; \
}

and

Die()    {
        color="$red"
        echo "${color}${_PROGNAME}: Error: $@${std}" >&2
        exit 1
}

Die "message here"


>
> or the inverse logic. This is what automake  and popt autogen.sh does.
>
> Best Regards

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
