From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 18:58:34 +0200
Message-ID: <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com> <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBY6EZWBAKGQEETWEECQ@googlegroups.com Fri Sep 14 18:59:20 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBY6EZWBAKGQEETWEECQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBY6EZWBAKGQEETWEECQ@googlegroups.com>)
	id 1TCZEd-0004lc-Tf
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 18:59:20 +0200
Received: by obbta17 with SMTP id ta17sf3304798obb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=6CPP+9CJ9780sZaH+kbMb1TqzFxdxxwDgiSXIfQfHm0=;
        b=y3fjbHAg+AWGKKpKROsdz2lcfH4H1AlZSnwY5k80cSdIQhWhnWv/PoATxYhckZRGOF
         jxyU7F32JtiS8rjol3+67KniV0IbZ4slNe2FgGgc8Ui4TFGUEOZWppxD+U02X/qnjABF
         uIpmVqunKUi5YCoBuZgk5ps0/UsWaFYo3jMtWMzli5O7ThBGraRfWQWkwGed5N/kkdFM
         duKE288DjppkCgvunCiz6Rt/cybm+7g5NjgCoYrA9oLDybwtHflNza+/NYSpZUkeYEwQ
         1VZCykIN8PlTHt5NSIbOKhHXxdxwSsgneBbUblvd+xBjI7S8fonXoZOWw9rNRpsH1uzT
         mgOA==
Received: by 10.236.173.202 with SMTP id v50mr683047yhl.19.1347641955465;
        Fri, 14 Sep 2012 09:59:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.148.143 with SMTP id p15ls3628222vcv.9.gmail; Fri, 14 Sep
 2012 09:59:14 -0700 (PDT)
Received: by 10.58.92.9 with SMTP id ci9mr491891veb.40.1347641954880;
        Fri, 14 Sep 2012 09:59:14 -0700 (PDT)
Received: by 10.58.92.9 with SMTP id ci9mr491890veb.40.1347641954872;
        Fri, 14 Sep 2012 09:59:14 -0700 (PDT)
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com [209.85.220.170])
        by gmr-mx.google.com with ESMTPS id s13si30858vde.2.2012.09.14.09.59.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 09:59:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.170 as permitted sender) client-ip=209.85.220.170;
Received: by mail-vc0-f170.google.com with SMTP id fk26so4565165vcb.15
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 09:59:14 -0700 (PDT)
Received: by 10.220.247.137 with SMTP id mc9mr2804850vcb.52.1347641954677;
 Fri, 14 Sep 2012 09:59:14 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 09:58:34 -0700 (PDT)
In-Reply-To: <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205503>

On Fri, Sep 14, 2012 at 6:54 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
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
>> +       tput () {
>> +               case "$1" in
>> +               bold)
>> +                       echo -ne "\033[1m" ;;
>> +               setaf)
>> +                       echo -ne "\033[0;3$2m" ;;
>> +               sgr0)
>> +                       echo -ne "\033(\033[m" ;;
>
> I should of course have checked this earlier, but I find now that
> "echo -ne" isn't portable. So perhaps this on top?
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7d1b34b..91a1d7b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -134,11 +134,11 @@ if ! which tput > /dev/null ; then
>         tput () {
>                 case "$1" in
>                 bold)
> -                       echo -ne "\033[1m" ;;
> +                       printf "%b" "\033[1m" ;;
>                 setaf)
> -                       echo -ne "\033[0;3$2m" ;;
> +                       printf "%b" "\033[0;3$2m" ;;
>                 sgr0)
> -                       echo -ne "\033(\033[m" ;;
> +                       printf "%b" "\033(\033[m" ;;
>                 esac
>         }
>  fi

And again, I'm stupid for not reading documentation properly; octal
escaped strings in the format string should work (and does on my
systems), so this is sufficient:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7d1b34b..2a6149e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,11 +134,11 @@ if ! which tput > /dev/null ; then
 	tput () {
 		case "$1" in
 		bold)
-			echo -ne "\033[1m" ;;
+			printf "\033[1m" ;;
 		setaf)
-			echo -ne "\033[0;3$2m" ;;
+			printf "\033[0;3$2m" ;;
 		sgr0)
-			echo -ne "\033(\033[m" ;;
+			printf "\033(\033[m" ;;
 		esac
 	}
 fi

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
