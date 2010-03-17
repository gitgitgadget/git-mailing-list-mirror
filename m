From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] Report errors when failing to launch the 
	html browser in mingw.
Date: Wed, 17 Mar 2010 18:01:07 +0100
Message-ID: <40aa078e1003171001s2c6a8765ve3bee38dddc2211c@mail.gmail.com>
References: <87aau7dkon.fsf@fox.patthoyts.tk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: 31wqhSwkOB844EC6uv2Dy08805y6u25.w866CIC02D08805y0B8E9C.w86@groups.bounces.google.com Wed Mar 17 18:01:31 2010
Return-path: <31wqhSwkOB844EC6uv2Dy08805y6u25.w866CIC02D08805y0B8E9C.w86@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gw0-f58.google.com ([74.125.83.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <31wqhSwkOB844EC6uv2Dy08805y6u25.w866CIC02D08805y0B8E9C.w86@groups.bounces.google.com>)
	id 1Nrwcc-0000U8-Uz
	for gcvm-msysgit@m.gmane.org; Wed, 17 Mar 2010 18:01:31 +0100
Received: by mail-gw0-f58.google.com with SMTP id a18sf8720gwa.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 17 Mar 2010 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=SWfam9AGjFSv9nFg1XuLrIJDGCr4bjEfUocCwxtyqXg=;
        b=5G0DudcgMNf3Xefc0nSnwQNc9tqpPnjuSeLXDoQrwIqeoKRsWDuZvrIe4wOmH8O18l
         ZUXqHsPrPHcMxLEFwBwENlk3n6fU8iptTWan2UABmXYr3TCOrCa7jQqATje6ph3DOM0d
         3gQ91xrdHvQ5gPaYJ4NmN3SZpVvGJXlDDY+hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=sL1mV5SG7DGI07C+KX/RIUqY44CTOY4TncoTAYWrPPXfp7cub9PGhDXp9R8KSPTWqq
         pmzoEw8Fi28s+SnBUHtSgP5ZU+J4EmDm1PDpKk+zJnscdCXiefWpLcrAzaA/7+Wp8j7h
         GllA5SIAmsscO4MNh4idyzggdiqW13cNSGNBM=
Received: by 10.91.1.12 with SMTP id d12mr90249agi.19.1268845271180;
        Wed, 17 Mar 2010 10:01:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.50.10 with SMTP id x10ls1043311ebf.3.p; Wed, 17 Mar 2010 
	10:01:08 -0700 (PDT)
Received: by 10.213.37.145 with SMTP id x17mr137026ebd.10.1268845268500;
        Wed, 17 Mar 2010 10:01:08 -0700 (PDT)
Received: by 10.213.37.145 with SMTP id x17mr137025ebd.10.1268845268478;
        Wed, 17 Mar 2010 10:01:08 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
        by gmr-mx.google.com with ESMTP id 11si163814ewy.1.2010.03.17.10.01.07;
        Wed, 17 Mar 2010 10:01:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.147 as permitted sender) client-ip=74.125.78.147;
Received: by ey-out-1920.google.com with SMTP id 26so57822eyw.42
        for <msysgit@googlegroups.com>; Wed, 17 Mar 2010 10:01:07 -0700 (PDT)
Received: by 10.216.86.211 with SMTP id w61mr592846wee.50.1268845267192; Wed, 
	17 Mar 2010 10:01:07 -0700 (PDT)
In-Reply-To: <87aau7dkon.fsf@fox.patthoyts.tk>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 74.125.78.147 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/debbf89669e0bc12
X-Message-Url: http://groups.google.com/group/msysgit/msg/15952c330a03d36e
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142415>

On Wed, Mar 17, 2010 at 4:20 PM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> The mingw function to launch the system html browser is silent if the
> target file does not exist leaving the user confused. Make it display
> something.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
> =A0compat/mingw.c | =A0 =A07 +++++--
> =A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9c10a4c..d6539ef 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1548,6 +1548,7 @@ void mingw_open_html(const char *unixpath)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *, const char *=
, const char *, INT);
> =A0 =A0 =A0 =A0T ShellExecute;
> =A0 =A0 =A0 =A0HMODULE shell32;
> + =A0 =A0 =A0 int r;
>
> =A0 =A0 =A0 =A0shell32 =3D LoadLibrary("shell32.dll");
> =A0 =A0 =A0 =A0if (!shell32)
> @@ -1557,9 +1558,11 @@ void mingw_open_html(const char *unixpath)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("cannot run browser");
>
> =A0 =A0 =A0 =A0printf("Launching default browser to display HTML ...\n");
> - =A0 =A0 =A0 ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
> -
> + =A0 =A0 =A0 r =3D (int)ShellExecute(NULL, "open", htmlpath, NULL, "\\",=
 SW_SHOWNORMAL);
> =A0 =A0 =A0 =A0FreeLibrary(shell32);
> + =A0 =A0 =A0 if (r < 33) {

While entirely correct, this looks a little weird to me. How about "if
(r <=3D 32)" (since 32 is the number MSDN mentions) and a comment?

--=20
Erik "kusma" Faye-Lund
