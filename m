From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [PATCH] git-gui: fix usage of themed widgets variable
Date: Sat, 20 Feb 2010 18:47:12 +0000
Message-ID: <a5b261831002201047r153a067btb7d2a9cf96617df4@mail.gmail.com>
References: <20100220180114.GB15561@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: 3My6ASwkOBy0YJccQXhcbPXXPUNVJRU.LXVVbhbPRcPXXPUNPaXdYb.LXV@groups.bounces.google.com Sat Feb 20 20:42:39 2010
Return-path: <3My6ASwkOBy0YJccQXhcbPXXPUNVJRU.LXVVbhbPRcPXXPUNPaXdYb.LXV@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f154.google.com ([209.85.210.154])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3My6ASwkOBy0YJccQXhcbPXXPUNVJRU.LXVVbhbPRcPXXPUNPaXdYb.LXV@groups.bounces.google.com>)
	id 1NiuMl-0003ez-Hi
	for gcvm-msysgit@m.gmane.org; Sat, 20 Feb 2010 19:47:47 +0100
Received: by yxe26 with SMTP id 26sf3706093yxe.25
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Feb 2010 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=8OLKk58aBZZKB9F6lakohaeAtGLuoqPZn28CNi1JELE=;
        b=TXGsY+56Y6GoAsbYPyTwGX98tABgRGLhDqKfmGeedG4OouLlLjCo2V1kMvj8X66A+1
         F0OlycWvvalTOn20cvmsyj9mcmbqGFkrcUrbm+IGN7ECFRkhqi0MfVdVnVUtgZijZS9g
         SanCXNeEzTfXrxYSbRpBC2MhE7M0gOuI/qc40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=l44xluCpjEOlfczWwvfEoDlCpPa8o5rBc9Z1yK88GVJlO/YvgY2w8eBpNSvsSZmqfF
         2HMuvfut7rm8xFCD/nDiGbTVPz9Fvykh8WkDA0YA1RYzoGTqu81Tzn+m+vmvbwa6OX1a
         KVwYVxuSFpCOW0E7sRP7SyjGTo5eXlxayFYfQ=
Received: by 10.91.91.20 with SMTP id t20mr6648agl.22.1266691636483;
        Sat, 20 Feb 2010 10:47:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.50.10 with SMTP id x10ls1504594ebf.3.p; Sat, 20 Feb 2010 
	10:47:14 -0800 (PST)
Received: by 10.213.70.206 with SMTP id e14mr55182ebj.8.1266691634222;
        Sat, 20 Feb 2010 10:47:14 -0800 (PST)
Received: by 10.213.70.206 with SMTP id e14mr55181ebj.8.1266691634191;
        Sat, 20 Feb 2010 10:47:14 -0800 (PST)
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com [209.85.219.224])
        by gmr-mx.google.com with ESMTP id 12si232065ewy.2.2010.02.20.10.47.13;
        Sat, 20 Feb 2010 10:47:13 -0800 (PST)
Received-SPF: pass (google.com: domain of patthoyts@googlemail.com designates 209.85.219.224 as permitted sender) client-ip=209.85.219.224;
Received: by mail-ew0-f224.google.com with SMTP id 24so1156079ewy.6
        for <msysgit@googlegroups.com>; Sat, 20 Feb 2010 10:47:13 -0800 (PST)
Received: by 10.216.162.202 with SMTP id y52mr690255wek.76.1266691632541; Sat, 
	20 Feb 2010 10:47:12 -0800 (PST)
In-Reply-To: <20100220180114.GB15561@book.hvoigt.net>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of patthoyts@googlemail.com designates 209.85.219.224 as permitted 
	sender) smtp.mail=patthoyts@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: patthoyts@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/61aaff59563ed5ea
X-Message-Url: http://groups.google.com/group/msysgit/msg/8ba6e101b84932aa
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140545>

On 20 February 2010 18:01, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> There was one forgotten global so NS was not visible to the method
> which resulted in an error.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> =C2=A0git-gui/lib/status_bar.tcl | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
> index 5fe3aad..95cb449 100644
> --- a/git-gui/lib/status_bar.tcl
> +++ b/git-gui/lib/status_bar.tcl
> @@ -39,6 +39,7 @@ method _oneline_pack {} {
> =C2=A0}
>
> =C2=A0constructor two_line {path} {
> + =C2=A0 =C2=A0 =C2=A0 global NS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set w $path
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set w_l $w.l
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set w_c $w.c
> --
> 1.7.0.m5.rc2.13.g7abfa.dirty

The commit message should mention what triggered the error I think -
but this patch is clearly correct.
You can have a

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

if you like :)

Pat Thoyts.
