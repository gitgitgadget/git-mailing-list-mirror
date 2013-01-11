From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Fri, 11 Jan 2013 17:20:09 +0100
Message-ID: <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
 <50EEAF9A.6020302@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Jeff King <peff@peff.net>
To: blees@dcon.de
X-From: msysgit+bncBDR53PPJ7YHRBYPXYCDQKGQEADAS2PI@googlegroups.com Fri Jan 11 17:21:08 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBYPXYCDQKGQEADAS2PI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f61.google.com ([209.85.212.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBYPXYCDQKGQEADAS2PI@googlegroups.com>)
	id 1TthLv-0000hw-FA
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jan 2013 17:21:07 +0100
Received: by mail-vb0-f61.google.com with SMTP id fs19sf960367vbb.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jan 2013 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=3fq9e1A9LYmVPWXw5fmKsbY/DlIhm+cFrtkZGGsJQTU=;
        b=sgrbYstTs9DypYSdKrGNVqqO/n79xG71fZR2RVBRYlo3RL9xwYg6n6lHpf+e/VS8v4
         DWsdvfoWf/cuEGyAKr2SPf5KLE5a3OJuFjCWh0v867rWnhsoZXLlXvFgbP9n1wx/ts4+
         1YL3yNU9gxkupdKq8bXye5uldVTnZWi/wtIO7iyKMQ7yWvYvIvAF3Nvo+htBqjSvXe59
         GQemvk1E3W6oEls+UrFO4lmsOyKfzWCb77d5UKto7cj2w9/ksmPWzkpIDJtYiQE44qHn
         Bqjpa+ONPdmmTXd18p85Edn3aOqxaCgr 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=3fq9e1A9LYmVPWXw5fmKsbY/DlIhm+cFrtkZGGsJQTU=;
        b=EUb10lFLCbThIOfrVVz2pqNm4w3j4w9U2o6hxLDsFmRji5JpHFiME3WVsmAEEmt1r1
         ASM5upVGvOHTzpY9pYRYK9ZFgrnP2RQqLcs3dF8SLCW6udoSABeGXiUldDqrbuQ8bULg
         ceC/VNeVdFfGASDc/rvaW1w+OBwgHf3vNGrFh26dGlohG8XkHdcAmtHgdjrdKzcvieGK
         6RhQDnp9I+Xy6rz3/JnWAmrcwRiHbDQVcLxwklJJmQ92pC+ZQNVmbRG0X8qqhUSgGcB5
         O1pSUsFT67pxf3dlvbpfVnA5U0EXTnzDga7gO23 
X-Received: by 10.50.108.200 with SMTP id hm8mr3518944igb.10.1357921250433;
        Fri, 11 Jan 2013 08:20:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.17.201 with SMTP id q9ls518748igd.26.canary; Fri, 11 Jan
 2013 08:20:49 -0800 (PST)
X-Received: by 10.42.87.198 with SMTP id z6mr26750icl.27.1357921249690;
        Fri, 11 Jan 2013 08:20:49 -0800 (PST)
X-Received: by 10.42.87.198 with SMTP id z6mr26745icl.27.1357921249680;
        Fri, 11 Jan 2013 08:20:49 -0800 (PST)
Received: from mail-ia0-f178.google.com (mail-ia0-f178.google.com [209.85.210.178])
        by gmr-mx.google.com with ESMTPS id xc3si160367igb.2.2013.01.11.08.20.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 08:20:49 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.210.178 as permitted sender) client-ip=209.85.210.178;
Received: by mail-ia0-f178.google.com with SMTP id k25so1680826iah.37
        for <msysgit@googlegroups.com>; Fri, 11 Jan 2013 08:20:49 -0800 (PST)
X-Received: by 10.50.51.231 with SMTP id n7mr9389104igo.85.1357921249554; Fri,
 11 Jan 2013 08:20:49 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Fri, 11 Jan 2013 08:20:09 -0800 (PST)
In-Reply-To: <50EEAF9A.6020302@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 209.85.210.178 as
 permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213221>

On Thu, Jan 10, 2013 at 1:10 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Changes since initial version (see attached diff for details):
> - split in two patches
> - removed unused variables
> - improved the dll error message
> - changed ?: to if else
> - added comments
>
> Also available here:
> https://github.com/kblees/git/tree/kb/improve-wincred-compatibility-v2
> git pull git://github.com/kblees/git.git kb/improve-wincred-compatibility-v2
>
> Karsten Blees (2):
>   wincred: accept CRLF on stdin to simplify console usage
>   wincred: improve compatibility with windows versions
>
>  .../credential/wincred/git-credential-wincred.c    | 206 ++++++++-------------
>  1 file changed, 75 insertions(+), 131 deletions(-)
>
>

Wonderful!

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

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
