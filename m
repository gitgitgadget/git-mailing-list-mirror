From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Problems with Windows, Was: What's cooking in git.git
 (May 2013, #01; Fri, 3)
Date: Wed, 15 May 2013 14:19:15 +0800
Message-ID: <CALUzUxono74WCnyFh-JWA0pA_Ax2OD_95VE-wFFdtuLsw05www@mail.gmail.com>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org> <51890F48.3090409@web.de>
 <518BDA49.400@ramsay1.demon.co.uk> <5192927E.3030203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>, mlevedahl@gmail.com, 
	Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>, msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCEMFWO7QMPRB56RZSGAKGQEQWFU5MA@googlegroups.com Wed May 15 08:19:37 2013
Return-path: <msysgit+bncBCEMFWO7QMPRB56RZSGAKGQEQWFU5MA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qe0-f56.google.com ([209.85.128.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCEMFWO7QMPRB56RZSGAKGQEQWFU5MA@googlegroups.com>)
	id 1UcV3p-0005Xo-Dd
	for gcvm-msysgit@m.gmane.org; Wed, 15 May 2013 08:19:37 +0200
Received: by mail-qe0-f56.google.com with SMTP id s14sf451245qeb.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 14 May 2013 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=LMHeF/r0rtror+eemeqebZqS0dsEFV3ocu0hHm9HZcA=;
        b=eAXqFJPh6KjD50xOv1bBPBVAgikyaWnIXSJiqsBd/q5LYRhocwkJRIq4P+/MP7rHIA
         r/Ji4VuLrCXfvdqBPmxVojD6epodIjhWWk+p7AtM7+fBXzNaT5HdcUL8LGLzR4NSsWQp
         w7qOCVAkslaybQwhCTQFH5Dn0xDqrnQcua44eDSkE3y1Tngx60huq9TsObmvpd2sd+kR
         BNvdnHKu0csPUufn6POuGh93Yn+0iNFlgwpyk2/MqmVJj4fMwUP28VOuDsvb2PArLCUV
         xwyWWyDEFAhbZYobI6u3iWmOUa 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=LMHeF/r0rtror+eemeqebZqS0dsEFV3ocu0hHm9HZcA=;
        b=yhS9NUD4inQG1kzJ5m2sm1nJdxG2rHjEGbhGCzA/AGnBg0bT+Gu+Ut8uk1u/9VM0y2
         Ky73LHwUJvhvDzeIf+L7we4MpaZY7US/4LOdqWm5mF6TpvjK8KB29IPW2GDP7sbaVzBM
         bqdGLar4PstY/C+EpDuDwD5xJi9g9Awm+87HRb2r1z/6Iub6CCkR3JQIBAr5E3cIX3wS
         fmXu/m7C9P2Six0l6qgEvfUyRTDvo9X4z4HH0MhfUl3IUYSmoZhOXcpC5mqQm+yrSjKb
         U3t7LfAvkQdYjj+B7CaF4/ksflVI8IkUj 
X-Received: by 10.50.73.170 with SMTP id m10mr867605igv.1.1368598776458;
        Tue, 14 May 2013 23:19:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.154.102 with SMTP id vn6ls3388860igb.23.canary; Tue, 14 May
 2013 23:19:35 -0700 (PDT)
X-Received: by 10.43.60.18 with SMTP id wq18mr25198206icb.27.1368598775625;
        Tue, 14 May 2013 23:19:35 -0700 (PDT)
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com [2607:f8b0:4001:c03::22d])
        by gmr-mx.google.com with ESMTPS id b5si173602igx.3.2013.05.14.23.19.35
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 14 May 2013 23:19:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of rctay89@gmail.com designates 2607:f8b0:4001:c03::22d as permitted sender) client-ip=2607:f8b0:4001:c03::22d;
Received: by mail-ie0-f173.google.com with SMTP id k5so2907358iea.18
        for <msysgit@googlegroups.com>; Tue, 14 May 2013 23:19:35 -0700 (PDT)
X-Received: by 10.50.115.36 with SMTP id jl4mr4416496igb.8.1368598775493; Tue,
 14 May 2013 23:19:35 -0700 (PDT)
Received: by 10.64.44.165 with HTTP; Tue, 14 May 2013 23:19:15 -0700 (PDT)
In-Reply-To: <5192927E.3030203@web.de>
X-Original-Sender: rctay89@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of rctay89@gmail.com designates 2607:f8b0:4001:c03::22d
 as permitted sender) smtp.mail=rctay89@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224381>

On Wed, May 15, 2013 at 3:37 AM, Torsten B=F6gershausen <tboegi@web.de> wro=
te:
> Second,
> I was able to do some testing.
> The hanging is not 100% reproducable, and I had one hanging in Git 1.8.1
>
> Turning the screen saver off in Win XP helps that the machine reacts,
> and using process explorer showed that the hanging is happening
> in test cases doing "git fetch" (or git pull) from a local repository.
> What I can see is one git-fetch.exe together with git-upload-pack.exe

I also managed to run into the intermittent hanging of git-fetch when
running t5510. What I do is keep running the test till it stalls:

  while [ $? -eq 0 ]; do date; ./t5510-fetch.sh -i -v; done

Almost always the git-fetch output looks like this:

  remote: Counting objects: 7, done.
  remote: Compressing objects: 100% (5/5), done.
  remote: Total 6 (delta 1), reused 0 (delta 0)

However my task manager indicates that git-upload-pack or whatever
that runs on the remote side is absent, only git-fetch is waiting - 0
I/O, 0 cswitches, nilda. I tried getting a gdb backtrace but I get ???
nonsense, despite having compiled git with `-g -O0`. I also noticed
there were a couple of threads. This is my gdb session:

$ gdb --pid=3D7936
GNU gdb (GDB) 7.6.50.20130508-cvs (cygwin-special)
...
Attaching to process 7936
[New Thread 7936.0x1c7c]
[New Thread 7936.0x6b8]
[New Thread 7936.0xd20]
[New Thread 7936.0x1cf8]
[New Thread 7936.0x1b24]
Reading symbols from /cygdrive/f/files/coding/git/git.exe...done.
(gdb) info thread
  Id   Target Id         Frame
* 5    Thread 7936.0x1b24 0x77c5000d in ntdll!DbgBreakPoint ()
   from /cygdrive/c/Windows/SysWOW64/ntdll.dll
  4    Thread 7936.0x1cf8 0x77c5f8b1 in ntdll!ZwWaitForSingleObject ()
   from /cygdrive/c/Windows/SysWOW64/ntdll.dll
  3    Thread 7936.0xd20 0x77c5f91d in ntdll!ZwWriteFile ()
   from /cygdrive/c/Windows/SysWOW64/ntdll.dll
  2    Thread 7936.0x6b8 0x77c5f8b1 in ntdll!ZwWaitForSingleObject ()
   from /cygdrive/c/Windows/SysWOW64/ntdll.dll
  1    Thread 7936.0x1c7c 0x77c5f8b1 in ntdll!ZwWaitForSingleObject ()
   from /cygdrive/c/Windows/SysWOW64/ntdll.dll
(gdb) bt
#0  0x77c5000d in ntdll!DbgBreakPoint () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#1  0x77cdf896 in ntdll!DbgUiRemoteBreakin () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#2  0x775c5cca in ?? ()
#3  0x00000000 in ?? ()
(gdb) thread 4
[Switching to thread 4 (Thread 7936.0x1cf8)]
#0  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
(gdb) bt
#0  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#1  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#2  0x7573149d in WaitForSingleObjectEx () from
/cygdrive/c/Windows/syswow64/KERNELBASE.dll
#3  0x00000148 in ?? ()
#4  0x00000000 in ?? ()
(gdb) thread 3
[Switching to thread 3 (Thread 7936.0xd20)]
#0  0x77c5f91d in ntdll!ZwWriteFile () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
(gdb) bt
#0  0x77c5f91d in ntdll!ZwWriteFile () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#1  0x77c5f91d in ntdll!ZwWriteFile () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#2  0x7572dec1 in WriteFile () from /cygdrive/c/Windows/syswow64/KERNELBASE=
.dll
#3  0x0000009c in ?? ()
#4  0x00000000 in ?? ()
(gdb) thread 2
[Switching to thread 2 (Thread 7936.0x6b8)]
#0  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
(gdb) bt
#0  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#1  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#2  0x7573149d in WaitForSingleObjectEx () from
/cygdrive/c/Windows/syswow64/KERNELBASE.dll
#3  0x0000001c in ?? ()
#4  0x00000000 in ?? ()
(gdb) thread 1
[Switching to thread 1 (Thread 7936.0x1c7c)]
#0  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
(gdb) bt
#0  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#1  0x77c5f8b1 in ntdll!ZwWaitForSingleObject () from
/cygdrive/c/Windows/SysWOW64/ntdll.dll
#2  0x7573149d in WaitForSingleObjectEx () from
/cygdrive/c/Windows/syswow64/KERNELBASE.dll
#3  0x00000034 in ?? ()
#4  0x00000000 in ?? ()

--
Cheers,
Ray Chuan

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
