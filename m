From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 19:42:32 +0200
Message-ID: <CABPQNSb=j=TtZVm4tzR6HE+Fhh=Aa6GSnmaysLNBQTbtSie4Mg@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com> <7va9ws5x6w.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBMOZZWBAKGQEGA2AFAI@googlegroups.com Fri Sep 14 19:43:19 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBMOZZWBAKGQEGA2AFAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBMOZZWBAKGQEGA2AFAI@googlegroups.com>)
	id 1TCZvB-0006si-Hl
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:43:17 +0200
Received: by mail-qc0-f186.google.com with SMTP id c2sf3334982qcs.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=hU9v+z+cHH8oYYL7eYDyS4Tp/SiPLSJpKG4I0ysYHME=;
        b=bTMip3a8w71QCbdkUdf2GM3OSZsBA5BW4DHa/KtQEB9vjtZj0II2a2zTs2tEJ6StSZ
         O1rS98et0XaBqFlSFiMMNAXmA3UpQTGZf2idK4Qlb0ICHpauO5gSjf5ji2QxkcuvBA5A
         yp6d0B2BQkD1DDScWUxJ1xeZO2FsHO2xW4VsHxlzabTsT2pP9JNDUIWuTfRPXvvQ087b
         GHl8ENIQoKZXxKeE+VSlvoqdkeLQ4xX+hYwtm9lLcfizSbWdeJBMtOteVuFeCl2raVot
         TiAKjkRDlwo6eSiAO0Fz8xybyHMHFcbt2RT2DJTbXP7PhBBE5pzhsV8WfyrvhIF/muVn
         WDLw==
Received: by 10.236.74.38 with SMTP id w26mr729890yhd.18.1347644593705;
        Fri, 14 Sep 2012 10:43:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.155.6 with SMTP id q6ls3680019vcw.3.gmail; Fri, 14 Sep
 2012 10:43:13 -0700 (PDT)
Received: by 10.59.1.102 with SMTP id bf6mr529968ved.21.1347644593254;
        Fri, 14 Sep 2012 10:43:13 -0700 (PDT)
Received: by 10.59.1.102 with SMTP id bf6mr529967ved.21.1347644593245;
        Fri, 14 Sep 2012 10:43:13 -0700 (PDT)
Received: from mail-vb0-f52.google.com (mail-vb0-f52.google.com [209.85.212.52])
        by gmr-mx.google.com with ESMTPS id z16si17425vdf.0.2012.09.14.10.43.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:43:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender) client-ip=209.85.212.52;
Received: by mail-vb0-f52.google.com with SMTP id k17so7104590vbj.39
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 10:43:13 -0700 (PDT)
Received: by 10.220.247.137 with SMTP id mc9mr2943325vcb.52.1347644592994;
 Fri, 14 Sep 2012 10:43:12 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 10:42:32 -0700 (PDT)
In-Reply-To: <7va9ws5x6w.fsf@alter.siamese.dyndns.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205515>

On Fri, Sep 14, 2012 at 7:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index 78c4286..7d1b34b 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>>>  # This test checks if command xyzzy does the right thing...
>>>  # '
>>>  # . ./test-lib.sh
>>> +
>>> +if ! which tput > /dev/null ; then
>>> +       tput () {
>>> +               case "$1" in
>>> +               bold)
>>> +                       echo -ne "\033[1m" ;;
>>> +               setaf)
>>> +                       echo -ne "\033[0;3$2m" ;;
>>> +               sgr0)
>>> +                       echo -ne "\033(\033[m" ;;
>>
>> I should of course have checked this earlier, but I find now that
>> "echo -ne" isn't portable.
>
> Neither is which, no?

Oooh, right. Thanks for noticing. So I guess I should try to run it
instead. From the POSIX spec, I can't find a way of running it that
guarantees a return-code of 0 without clobbering the console somehow.

Perhaps the best thing is pass no operands, and check for $? == 127 instead?

Something like this?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a939e19..1433cb3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -130,7 +130,8 @@ export _x05 _x40 _z40 LF
 # '
 # . ./test-lib.sh

-if ! which tput > /dev/null ; then
+tput > /dev/null
+if test $? -eq 127 ; then
 	tput () {
 		case "$1" in
 		bold)

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
