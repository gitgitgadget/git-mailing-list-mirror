From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/5] win32: support echo for terminal-prompt
Date: Tue, 13 Nov 2012 15:04:13 +0100
Message-ID: <CABPQNSZe=oWEb-_orsGx1XFJh=sT3JpFVbOOwc=4=Agy9LreWg@mail.gmail.com>
References: <1352815288-3996-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRBB5HRGCQKGQEP2B7DQY@googlegroups.com Tue Nov 13 15:05:08 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBB5HRGCQKGQEP2B7DQY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f186.google.com ([209.85.161.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBB5HRGCQKGQEP2B7DQY@googlegroups.com>)
	id 1TYH6x-0004XR-Aw
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:05:07 +0100
Received: by mail-gg0-f186.google.com with SMTP id u2sf5791627ggn.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=0hIZE3EmA3KZnJqX/qn3bQ2ldQJaY0PWSxiOdqxsZs0=;
        b=XEa0DwwM4I1c3tM73yzrO9LkSTdMjF7ePPHXn4AnICOhuzytYDRy6m/OZmXiq/oR9f
         Gl3uBGzhjtFDN2WAfiek75Labm46nQ8M6BE+boL6bAuSPzGnNKtxVLzf42bNiCMZKxrS
         uB+J9mF1QZD4Hhsloflzvaj9DLeQViSSfU56CHVzKmal9say/p4CBu85YHQyBJRuf6uA
         7nHi30ZIoEL73ulJkBGs7xd08d/bkXutBbemWgv/wKOFCgM2ixLFcKxQRtWtlqMZAVDB
         9PUHzVoChkoxYc3L61VSJaG+dEjTl2l9Nnji6gg33DyoUCW+eQEUtcXUtx/YlyCmIldn
         VWIQ==
Received: by 10.52.28.176 with SMTP id c16mr4399197vdh.5.1352815496972;
        Tue, 13 Nov 2012 06:04:56 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.155.207 with SMTP id t15ls9091640vcw.8.gmail; Tue, 13 Nov
 2012 06:04:55 -0800 (PST)
Received: by 10.58.66.199 with SMTP id h7mr391204vet.12.1352815495424;
        Tue, 13 Nov 2012 06:04:55 -0800 (PST)
Received: by 10.58.66.199 with SMTP id h7mr391202vet.12.1352815495203;
        Tue, 13 Nov 2012 06:04:55 -0800 (PST)
Received: from mail-vb0-f52.google.com (mail-vb0-f52.google.com [209.85.212.52])
        by gmr-mx.google.com with ESMTPS id bn19si3435373vdb.0.2012.11.13.06.04.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:55 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender) client-ip=209.85.212.52;
Received: by mail-vb0-f52.google.com with SMTP id k17so10467031vbj.39
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:04:55 -0800 (PST)
Received: by 10.52.94.225 with SMTP id df1mr27066986vdb.114.1352815494756;
 Tue, 13 Nov 2012 06:04:54 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Tue, 13 Nov 2012 06:04:13 -0800 (PST)
In-Reply-To: <1352815288-3996-1-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209610>

Sorry, I messed up the subject (lacking RFC-prefix), so I aborted
after sending the cover-letter. I'll resend with a proper prefix right
away.

On Tue, Nov 13, 2012 at 3:01 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> We currently only support getpass, which does not echo at all, for
> git_terminal_prompt on Windows. The Windows console is perfectly
> capable of doing this, so let's make it so.
>
> This implementation tries to reuse the /dev/tty-code as much as
> possible.
>
> The big reason that this becomes a bit hairy is that Ctrl+C needs
> to be handled correctly, so we don't leak the console state to a
> non-echoing setting when a user aborts.
>
> Windows makes this bit a little bit tricky, in that we need to
> implement SIGINT for fgetc. However, I suspect that this is a good
> thing to do in the first place.
>
> An earlier iteration was also breifly discussed here:
> http://mid.gmane.org/CABPQNSaUCEDU4+2N63n0k_XwSXOP_iFZG3GEYSPSBPcSVV8wRQ@mail.gmail.com
>
> The series can also be found here, only with an extra patch that
> makes the (interactive) testing a bit easier:
>
> https://github.com/kusma/git/tree/work/terminal-cleanup
>
> Erik Faye-Lund (5):
>   mingw: make fgetc raise SIGINT if apropriate
>   compat/terminal: factor out echo-disabling
>   compat/terminal: separate input and output handles
>   mingw: reuse tty-version of git_terminal_prompt
>   mingw: get rid of getpass implementation
>
>  compat/mingw.c    |  91 +++++++++++++++++++++++++++-----------
>  compat/mingw.h    |   8 +++-
>  compat/terminal.c | 129 ++++++++++++++++++++++++++++++++++++++++--------------
>  3 files changed, 169 insertions(+), 59 deletions(-)
>
> --
> 1.8.0.7.gbeffeda
>

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
