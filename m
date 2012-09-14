From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 18:54:41 +0200
Message-ID: <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRB6WCZWBAKGQEUNPCCJY@googlegroups.com Fri Sep 14 18:55:31 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB6WCZWBAKGQEUNPCCJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB6WCZWBAKGQEUNPCCJY@googlegroups.com>)
	id 1TCZAs-0002If-OX
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 18:55:26 +0200
Received: by qcsc2 with SMTP id c2sf3308583qcs.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 09:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=1BAEp/3QE7eYqVT8dA1yH/akjqhg4O7PjbWZfWxhaLs=;
        b=WJWVLTEDohA08r4DXmuAaHnYi3S2I4nMKelfuN7vjDUnYLCCY+AFo5YRkHSeTm1n9r
         GzBEuSgN+2+DkhyOk4HVUICZJz6GJuBnBrg8xQPhRPDOHzoNA8j5YMKXgqNatf39TgGJ
         vkytq9j8U31k8N4njKIGwiO/6Cmv/aDzhVAcJr5mB2ySQNiJjyiAvTAJ44IdgeGS48X7
         qRVasmRy9WCV/sAUsnd6iX9ARio3UbUE2mSmWmtFEXK5aGuzGGE6kNr64Ev+VASI1UMt
         vwVt0jQ8KUIGoLsPVsgl3Hkxd8kupZYSfILY0IspzFAr7AwtAy52cM4FSoOxqQPKIYNB
         X+Xw==
Received: by 10.236.181.234 with SMTP id l70mr675784yhm.5.1347641722528;
        Fri, 14 Sep 2012 09:55:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.147.138 with SMTP id l10ls3671725vcv.7.gmail; Fri, 14 Sep
 2012 09:55:22 -0700 (PDT)
Received: by 10.59.7.167 with SMTP id dd7mr478337ved.26.1347641722029;
        Fri, 14 Sep 2012 09:55:22 -0700 (PDT)
Received: by 10.59.7.167 with SMTP id dd7mr478336ved.26.1347641722018;
        Fri, 14 Sep 2012 09:55:22 -0700 (PDT)
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com [209.85.212.51])
        by gmr-mx.google.com with ESMTPS id ef10si30051vdb.3.2012.09.14.09.55.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 09:55:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.51 as permitted sender) client-ip=209.85.212.51;
Received: by vbbfn1 with SMTP id fn1so5641009vbb.24
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 09:55:21 -0700 (PDT)
Received: by 10.58.58.161 with SMTP id s1mr3021866veq.14.1347641721778; Fri,
 14 Sep 2012 09:55:21 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 14 Sep 2012 09:54:41 -0700 (PDT)
In-Reply-To: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.51 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205502>

On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78c4286..7d1b34b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>  # This test checks if command xyzzy does the right thing...
>  # '
>  # . ./test-lib.sh
> +
> +if ! which tput > /dev/null ; then
> +       tput () {
> +               case "$1" in
> +               bold)
> +                       echo -ne "\033[1m" ;;
> +               setaf)
> +                       echo -ne "\033[0;3$2m" ;;
> +               sgr0)
> +                       echo -ne "\033(\033[m" ;;

I should of course have checked this earlier, but I find now that
"echo -ne" isn't portable. So perhaps this on top?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7d1b34b..91a1d7b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,11 +134,11 @@ if ! which tput > /dev/null ; then
 	tput () {
 		case "$1" in
 		bold)
-			echo -ne "\033[1m" ;;
+			printf "%b" "\033[1m" ;;
 		setaf)
-			echo -ne "\033[0;3$2m" ;;
+			printf "%b" "\033[0;3$2m" ;;
 		sgr0)
-			echo -ne "\033(\033[m" ;;
+			printf "%b" "\033(\033[m" ;;
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
