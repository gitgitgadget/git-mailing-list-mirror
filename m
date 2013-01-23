From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Bug in EOL conversion?
Date: Wed, 23 Jan 2013 21:55:13 -0000
Organization: OPDS
Message-ID: <063ABD39C46D492391698E400A7D1FA9@PhilipOakley>
References: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Cc: "Git MsysGit" <msysgit@googlegroups.com>
To: "Stefan Norgren" <stefan.norgren@gmail.com>,
	<git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBQNYQGEAKGQEE44HWXA@googlegroups.com Wed Jan 23 22:55:33 2013
Return-path: <msysgit+bncBDSOTWHYX4PBBQNYQGEAKGQEE44HWXA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBQNYQGEAKGQEE44HWXA@googlegroups.com>)
	id 1Ty8I8-0002GG-NM
	for gcvm-msysgit@m.gmane.org; Wed, 23 Jan 2013 22:55:32 +0100
Received: by mail-lb0-f186.google.com with SMTP id n8sf3081664lbj.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Jan 2013 13:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-ironport-anti-spam-filtered:x-ironport-anti-spam-result
         :x-ironport-av:message-id:reply-to:from:to:cc:references:subject
         :date:organization:mime-version:x-priority:x-msmail-priority
         :x-mailer:x-mimeole:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=YtxyvpeiU7/Pzu3uZlzzostThgGdWpwwl2cVEpqIC5E=;
        b=vvQ3F9TJAGJ5jVPpmX+yNrbMQLcqgY13AObKsZ5AlUEQiwZ5/GvDGSI3bwFzFsPkn6
         Ht3TmFwWzt2wk/jr+HysTDP//T+E5NI6ZIZEcL7zcczpQv8uCCr5nDlqgFYniY1jT0jw
         im8HXMDB7+ShPfw0glywiF1/dcpnCqyNmmaP7po0duWzMWq6Bf+TvYVSMt 
X-Received: by 10.180.90.140 with SMTP id bw12mr875038wib.6.1358978115266;
        Wed, 23 Jan 2013 13:55:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.94.97 with SMTP id db1ls245419wib.0.canary; Wed, 23 Jan
 2013 13:55:13 -0800 (PST)
X-Received: by 10.180.74.74 with SMTP id r10mr1016090wiv.3.1358978113678;
        Wed, 23 Jan 2013 13:55:13 -0800 (PST)
X-Received: by 10.180.74.74 with SMTP id r10mr1016089wiv.3.1358978113658;
        Wed, 23 Jan 2013 13:55:13 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id co7si1579142wib.1.2013.01.23.13.55.13;
        Wed, 23 Jan 2013 13:55:13 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAP1aAFFcHIm8/2dsb2JhbABEjAKyPRdzghkFAQEEAQgBAS4RBQgBARwFBQYBAQMFAgEDEQMBAQEKJRQBBAgQAgYHCQEFCAYBBwsIAgECAwEMBIdnAwkKCLQaDYlVjAR3g1dhA4gshVGGOYJyihuFEoJ1gWYJFy8
X-IronPort-AV: E=Sophos;i="4.84,523,1355097600"; 
   d="scan'208";a="416376268"
Received: from host-92-28-137-188.as13285.net (HELO PhilipOakley) ([92.28.137.188])
  by out1.ip02ir2.opaltelecom.net with SMTP; 23 Jan 2013 21:55:12 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214367>

The msysgit list msysgit@googlegroups.com may be a better place for 
this.

It is likely that you have a windows specific EOL conversion set within 
the wider config's (i.e.  --system, --global). You may have 
core.safecrlf set which does a round trip test so tests the conversion 
both ways.

The normal canonical line ending choice is LF in the repo.

I don't have a W7 install to compare against.

Philip

----- Original Message ----- 
From: "Stefan Norgren" <stefan.norgren@gmail.com>
To: <git@vger.kernel.org>
Sent: Wednesday, January 23, 2013 2:44 AM
Subject: Bug in EOL conversion?


> Hi,
>
> The EOL conversion does not behave as indicated by output message from
> add and commit. Here is my test case executed on Windows 7 64 bit.
>
>
> $ git --version
> git version 1.8.0.msysgit.0
> $ which git
> /cygdrive/c/Program Files (x86)/Git/cmd/git
> $ git config --list
> core.symlinks=false
> core.autocrlf=true
> color.diff=auto
> color.status=auto
> color.branch=auto
> color.interactive=true
> pack.packsizelimit=2g
> help.format=html
> http.sslcainfo=/bin/curl-ca-bundle.crt
> sendemail.smtpserver=/bin/msmtp.exe
> diff.astextplain.textconv=astextplain
> rebase.autosquash=true
> user.name=Stefan
> user.email=stefan@---.com
> core.repositoryformatversion=0
> core.filemode=false
> core.bare=false
> core.logallrefupdates=true
> core.symlinks=false
> core.ignorecase=true
> core.hidedotfiles=dotGitOnly
>
> -- Note core.autocrlf=true.
> -- Created withcrlf.txt with one character and one CRLF line feed.
> File size 3 bytes.
> -- Created withlf.txt with one character and one LF line feed. File
> size 2 bytes.
> -- Now let's init repository.
>
> $ git init
> Initialized empty Git repository in D:/Dev/workspaces/gittest/.git/
> $ ls -la
> total 10
> d---------+ 1 Stefan None 0 Jan 23 02:12 .
> d---------+ 1 Stefan None 0 Jan 23 02:10 ..
> d---------+ 1 Stefan None 0 Jan 23 02:13 .git
> ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
> ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt
>
> -- Note no .gitattributes file that will affect EOL conversion.
>
> $ ls -la .git/info/
> total 5
> d---------+ 1 Stefan None   0 Jan 23 02:12 .
> d---------+ 1 Stefan None   0 Jan 23 02:13 ..
> ----------+ 1 Stefan None 240 Jan 23 02:12 exclude
>
> -- Note no attribute file in .git/info/ that will affect EOL 
> conversion.
>
> $ git add *
> warning: LF will be replaced by CRLF in withlf.txt.
> The file will have its original line endings in your working 
> directory.
> $ git commit -m 'Testing EOL'
> [master (root-commit) 9a0b2f5] Testing EOL
> 2 files changed, 2 insertions(+)
> create mode 100644 withcrlf.txt
> create mode 100644 withlf.txt
> warning: LF will be replaced by CRLF in withlf.txt.
> The file will have its original line endings in your working 
> directory.
> $ ls -la
> total 10
> d---------+ 1 Stefan None 0 Jan 23 02:12 .
> d---------+ 1 Stefan None 0 Jan 23 02:10 ..
> d---------+ 1 Stefan None 0 Jan 23 02:22 .git
> ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
> ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt
>
> -- So no changes (see file size) to files in working directory. This
> is expected and according to output warning from add and commit.
>
> -- Now lets look in the repository
>
> $ git ls-tree -l HEAD withcrlf.txt
> 100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2 
> withcrlf.txt
> $ git ls-tree -l HEAD withlf.txt
> 100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2 
> withlf.txt
>
> -- Note that size of withlf.txt is 2 in repository indicating that LF
> was not replaced by CRLF in withlf.txt as indicated in output from add
> and commit. Also note that size of withcrlf.txt is also 2 in
> repository so it looks like CRLF was replaced by LF in withcrlf.txt.
> To verify I will delete the files from working directory, turn off EOL
> conversion, checkout files and look at file endings in the working
> directory.
>
> $ rm with*
> $ ls -la
> total 8
> d---------+ 1 Stefan None 0 Jan 23 02:31 .
> d---------+ 1 Stefan None 0 Jan 23 02:10 ..
> d---------+ 1 Stefan None 0 Jan 23 02:22 .git
> $ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working 
> directory)
> #
> #       deleted:    withcrlf.txt
> #       deleted:    withlf.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git config --global core.autocrlf false
> $ git config --global core.autocrlf
> false
> $ git checkout -- with*
> $ ls -la
> total 10
> d---------+ 1 Stefan None 0 Jan 23 02:38 .
> d---------+ 1 Stefan None 0 Jan 23 02:10 ..
> d---------+ 1 Stefan None 0 Jan 23 02:38 .git
> ----------+ 1 Stefan None 2 Jan 23 02:38 withcrlf.txt
> ----------+ 1 Stefan None 2 Jan 23 02:38 withlf.txt
>
> -- Both files in working directory files now have LF line endings
> confirming that files in repository have LF file endings. Either the
> output message of add and commit is wrong or the behavior of the EOL
> conversion is wrong... or... have I missed something...?
>
>   /Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.2890 / Virus Database: 2639/6050 - Release Date: 
> 01/22/13
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
