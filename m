From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 19:16:59 +0200
Message-ID: <CABPQNSYu1mAxn_ZKqgM6xcsgJfegu=upv0QQpFryMVrEH+KAsw@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
 <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
 <CA+EOSBm4cSu8cxPc-3Eqm0J7deeht6FMMUGBKP6vx8VDcVrGPQ@mail.gmail.com> <CA+EOSBki2syrwdfzFXzBPuJAhH2jfgAbL=W+yP7bx8WXMkYiMQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBNGNZWBAKGQEWXKN63A@googlegroups.com Fri Sep 14 19:17:45 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBNGNZWBAKGQEWXKN63A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBNGNZWBAKGQEWXKN63A@googlegroups.com>)
	id 1TCZWT-0008Da-G5
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:17:45 +0200
Received: by obbta17 with SMTP id ta17sf3314497obb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=56WeYq3jOu8ZWa0qJrDAxDKyuQRY6icOZb3tX2b95xI=;
        b=posDZPvOnoCFuhvTGwh043u6T07LmzdQsby+xKzjGk1cAaFP8e0kIonniRcgwWWLpR
         rVsRPJdmJ/ijf8H58NYaczB654xnkN6f8d3/NBhwFNoB9aZuL7MbVpDGzIqF+lrf9wJ6
         +AzBiQ/gxUgb16mGvfC0ZL1VxREDtAVc9x+xtSX0lRlW1IadTZ6lj1gylfrKP3mJopuD
         Ga2LUg0yhy7q4ceQCFLhD5WzI5PIJENI73SgOuiaVNTCqODTszZUShJHECenUTjPBZbV
         StIwnSLF3qfE/KsndKOz1qUCcza1Ph7DXSYpdDMpcZxqEWxoAiE9d0ssZB2X1rEn0ezh
         VQtg==
Received: by 10.236.173.202 with SMTP id v50mr705801yhl.19.1347643061025;
        Fri, 14 Sep 2012 10:17:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.149.129 with SMTP id t1ls3662253vcv.0.gmail; Fri, 14 Sep
 2012 10:17:40 -0700 (PDT)
Received: by 10.58.127.226 with SMTP id nj2mr475894veb.3.1347643060380;
        Fri, 14 Sep 2012 10:17:40 -0700 (PDT)
Received: by 10.58.127.226 with SMTP id nj2mr475891veb.3.1347643060357;
        Fri, 14 Sep 2012 10:17:40 -0700 (PDT)
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com [209.85.220.175])
        by gmr-mx.google.com with ESMTPS id r14si13619vdu.1.2012.09.14.10.17.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:17:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.175 as permitted sender) client-ip=209.85.220.175;
Received: by mail-vc0-f175.google.com with SMTP id m8so5528025vcd.34
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 10:17:40 -0700 (PDT)
Received: by 10.58.164.8 with SMTP id ym8mr3046530veb.39.1347643060096; Fri,
 14 Sep 2012 10:17:40 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 10:16:59 -0700 (PDT)
In-Reply-To: <CA+EOSBki2syrwdfzFXzBPuJAhH2jfgAbL=W+yP7bx8WXMkYiMQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.175 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205509>

On Fri, Sep 14, 2012 at 7:12 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> 2012/9/14 Elia Pinto <gitter.spiros@gmail.com>:
>> 2012/9/14 Erik Faye-Lund <kusmabite@gmail.com>:
>>> On Fri, Sep 14, 2012 at 6:54 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>>> On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>>>> index 78c4286..7d1b34b 100644
>>>>> --- a/t/test-lib.sh
>>>>> +++ b/t/test-lib.sh
>>>>> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>>>>>  # This test checks if command xyzzy does the right thing...
>>>>>  # '
>>>>>  # . ./test-lib.sh
>>>>> +
>> Nice. But this setting should be check that we have a terminal first isn't ?
>> Some test like this before
>>
>> test "X$$TERM" != Xdumb \
>> &&  test -t 1 2>/dev/null  \
>> && ....
> and in reality this echo use is not portable.

Yeah; I posted a couple of follow-up mails earlier where I had noticed
it and changed to printf instead. It seems the testsuite is already
using it, so it's probably portable.

Thanks a lot for the extra set of eyes :)

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
