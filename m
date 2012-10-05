From: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Fw: How do I git-push to an FTP server?
Date: Fri, 5 Oct 2012 17:38:33 +0400
Message-ID: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: git-users+bncBCWKX34CSUCBBXOFXOBQKGQEEWMRR3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Oct 05 15:38:44 2012
Return-path: <git-users+bncBCWKX34CSUCBBXOFXOBQKGQEEWMRR3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCWKX34CSUCBBXOFXOBQKGQEEWMRR3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TK871-0001BU-PA
	for gcggu-git-users@m.gmane.org; Fri, 05 Oct 2012 15:38:43 +0200
Received: by mail-lb0-f186.google.com with SMTP id gn12sf694583lbb.3
        for <gcggu-git-users@m.gmane.org>; Fri, 05 Oct 2012 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :x-mailer:mime-version:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=X77HSb/mgtdQEeW7mAViRnTMHt75HER8pQARdBJBO3M=;
        b=wUf0wZF9+mmq79M7Scb7pX93xuqYhKDr2/24MY5LNd6dK//lvC1ezEgNdDhP0jnV8f
         QxwyqHESlE7siTEtM5hBUgL+law0MuWAxb7sOBFVn+vb7U+0cIimNYdet1Wi6crOVCvM
         TMb4W8nj0WCYAIHf8fCXV0UWW+wnd/mXQGjOzirg/xUEcqN95J+6R2ltPXlhBo8jB2US
         q8GIClWHcY1VpmK/XMCNFvJebDC4juKlis9Xkw5JdV6jo21Jwd3nq3FwtxOARHGs+H6z
         nXix5he4qco6E0/2VbeNv0Bs+EV9Kp5sA+3f4QbPeSzX0/QLWPkCXwkQtEwX0CJ0RZrk
         pkJA==
Received: by 10.204.7.139 with SMTP id d11mr691538bkd.28.1349444317863;
        Fri, 05 Oct 2012 06:38:37 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.129.72 with SMTP id n8ls4284118bks.0.gmail; Fri, 05 Oct
 2012 06:38:37 -0700 (PDT)
Received: by 10.204.149.65 with SMTP id s1mr609502bkv.3.1349444316968;
        Fri, 05 Oct 2012 06:38:36 -0700 (PDT)
Received: by 10.204.149.65 with SMTP id s1mr609501bkv.3.1349444316952;
        Fri, 05 Oct 2012 06:38:36 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id v13si989202bkw.0.2012.10.05.06.38.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:38:36 -0700 (PDT)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) client-ip=84.204.203.130;
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q95DcX7c000918;
	Fri, 5 Oct 2012 17:38:34 +0400
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Original-Sender: flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 84.204.203.130 is neither permitted nor denied by best guess record for
 domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) smtp.mail=flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en_US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en_US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207105>

On the git-users mailing list we're trying someone to help with
running `git push` over FTP.  That person is runnig Git 1.7.9.5
on Ubuntu 12.04.

Below is the trace captured while trying to perform such a faulty push.
The oddity (in my eyes) is that after uploading the files, Git executes
`git http-push` which manual page does not mention FTP at all.

So I'd like to ask experts on Git transports for any advice in this
situation.

Begin forwarded message:

Date: Fri, 5 Oct 2012 05:07:24 -0700 (PDT)
From: August Karlstrom <fusio...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: git...-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: August Karlstrom <fusio...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [git-users] How do I git-push to an FTP server?

Den fredagen den 5:e oktober 2012 kl. 11:38:43 UTC+2 skrev Konstantin 
Khomoutov:
>
> On Fri, 5 Oct 2012 01:24:21 -0700 (PDT) 
> August Karlstrom <fusio...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>> wrote: 
>
> > I get the following error when I run `git push' in a repository 
> > called test: 
> > 
> > error: Cannot access URL ftp://my-ftp-server/git/test.git/, return 
> > code 3 fatal: git-http-push failed 
> > 
> > This is after having successfully cloned the repository from the 
> > address above. 
> Try to run your command while having set GIT_TRACE=1 and 
> GIT_CURL_VERBOSE=1, like 
>
> $ GIT_TRACE=1 GIT_CURL_VERBOSE=1 git push 
>
> and post the results here (if you will fail to infer the cause from
> its output by yourself). 
>

Thanks for the input, Konstantin. Below is the output (with identifying 
info removed). I can't see what caused "Uploading to a URL without a
file name" at the end.

$ GIT_TRACE=1 GIT_CURL_VERBOSE=1 git push
trace: built-in: git 'push'
trace: run_command: 'git-remote-ftp' 'origin' 
'ftp://my-ftp-server/git/test.git'
* About to connect() to my-ftp-server port 21 (#0)
*   Trying my-ftp-ip... * Connected to my-ftp-server (my-ftp-ip) port
21 (#0)
< 220---------- Welcome to Pure-FTPd [privsep] [TLS] ---------- 
< 220-You are user number 6 of 400 allowed. 
< 220-Local time is now 11:23. Server port: 21. 
< 220-This is a private system - No anonymous login 
< 220 You will be disconnected after 15 minutes of inactivity. 
> USER my-username 
< 331 User my-username OK. Password required 
> PASS my-password 
< 230-User my-username has group access to:  my-group 
< 230 OK. Current restricted directory is / 
> PWD 
< 257 "/" is your current location 
* Entry path is '/'
> CWD git 
< 250 OK. Current directory is /git 
> CWD test.git 
< 250 OK. Current directory is /git/test.git 
> CWD info 
< 250 OK. Current directory is /git/test.git/info 
> EPSV 
* Connect data stream passively
< 500 Unknown command 
* disabling EPSV usage
> PASV 
< 227 Entering Passive Mode ([not shown]) 
*   Trying my-ftp-ip... * Connecting to my-ftp-ip (my-ftp-ip) port 63983
> TYPE I 
< 200 TYPE is now 8-bit binary 
> SIZE refs 
< 213 59 
> RETR refs 
< 150 Accepted data connection 
* Maxdownload = -1
* Getting file with size: 59
* Remembering we are in dir "git/test.git/info/"
< 226-File successfully transferred 
< 226 0.000 seconds (measured here), 1.34 Mbytes per second 
* Connection #0 to host my-ftp-server left intact
* Re-using existing connection! (#0) with host my-ftp-server
* Connected to my-ftp-server (my-ftp-ip) port 21 (#0)
> CWD / 
< 250 OK. Current directory is / 
> CWD git 
< 250 OK. Current directory is /git 
> CWD test.git 
< 250 OK. Current directory is /git/test.git 
> PASV 
* Connect data stream passively
< 227 Entering Passive Mode ([not shown]) 
*   Trying my-ftp-ip... * Connecting to my-ftp-ip (my-ftp-ip) port 63462
> SIZE HEAD 
< 213 23 
> RETR HEAD 
< 150 Accepted data connection 
* Maxdownload = -1
* Getting file with size: 23
* Remembering we are in dir "git/test.git/"
< 226-File successfully transferred 
< 226 0.000 seconds (measured here), 0.63 Mbytes per second 
* Connection #0 to host my-ftp-server left intact
trace: run_command: 'http-push' '--helper-status' 
'ftp://my-ftp-server/git/test.git/'
'refs/heads/master:refs/heads/master' trace: exec: 'git' 'http-push'
'--helper-status' 'ftp://my-ftp-server/git/test.git/'
'refs/heads/master:refs/heads/master' trace: exec: 'git-http-push'
'--helper-status' 'ftp://my-ftp-server/git/test.git/'
'refs/heads/master:refs/heads/master' trace: run_command:
'git-http-push' '--helper-status' 'ftp://my-ftp-server/git/test.git/'
'refs/heads/master:refs/heads/master'
* About to connect() to my-ftp-server port 21 (#0)
*   Trying my-ftp-ip... * Connected to my-ftp-server (my-ftp-ip) port
21 (#0)
< 220---------- Welcome to Pure-FTPd [privsep] [TLS] ---------- 
< 220-You are user number 7 of 400 allowed. 
< 220-Local time is now 11:23. Server port: 21. 
< 220-This is a private system - No anonymous login 
< 220 You will be disconnected after 15 minutes of inactivity. 
> USER my-username 
< 331 User my-username OK. Password required 
> PASS my-password 
< 230-User my-username has group access to:  my-group 
< 230 OK. Current restricted directory is / 
> PWD 
< 257 "/" is your current location 
* Entry path is '/'
* Uploading to a URL without a file name!
* Closing connection #0
error: Cannot access URL ftp://my-ftp-server/git/test.git/, return code
3 fatal: git-http-push failed

-- 
You received this message because you are subscribed to the Google
Groups "Git for human beings" group. To view this discussion on the web
visit https://groups.google.com/d/msg/git-users/-/n_i8DslaCr8J. To post
to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org To unsubscribe
from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at
http://groups.google.com/group/git-users?hl=en.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
