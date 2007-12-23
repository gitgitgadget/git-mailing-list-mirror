From: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
Subject: Re: how to detect git.exe directory?
Date: Sun, 23 Dec 2007 20:51:33 +0100
Message-ID: <fkme88$rc1$1@ger.gmane.org>
References: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com> <200712231735.00336.johannes.sixt@telecom.at> <e5bfff550712230853u1bc0160ap936c2d0a6fe0203b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Dec 23 20:52:21 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.244])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Ws0-00025f-EF
	for gcvm-msysgit@m.gmane.org; Sun, 23 Dec 2007 20:52:21 +0100
Received: by wa-out-0708.google.com with SMTP id n36so768867wag.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Dec 2007 11:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Tfji/8CpQwAEn1pt/0rFc/sc6/NkPhqFhYOh43206PY=;
        b=gi3Pi5po9dSl1dEoYQMH3PzXNXDPEunduBAskXMtKC86BlDtIoefwUJNj/Dcw0SYyjxOmrosZIvDEdxZGsswwQu31B/ZsGZKjuKe68DNXbH7pplqAOSfoxbA/RbZ1Y9z3SH7H/yijlztwCnFLMFKjyp70mTHheiGymj8gGpk+tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=hNSY9Qyb6eK+zIhtZKGv7+ZoAg3UrRjDtxf4V5EHHmfNvBH9moyjPi9BfWZyLY53TGNz3zjTgGF2NBaqaWhwAiPPnUmRec5pyyhWPMDK8jnYfqSDflibRcIhirYUDXFbTtMuZT+m3kub23Fuiw0FNYEX2st4+VnpZiCrWwcUiMk=
Received: by 10.114.146.1 with SMTP id t1mr119587wad.4.1198439515903;
        Sun, 23 Dec 2007 11:51:55 -0800 (PST)
Received: by 10.107.100.4 with SMTP id c4gr1279prm;
	Sun, 23 Dec 2007 11:51:55 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.161.11 with SMTP id j11mr1718615wae.29.1198439515796; Sun, 23 Dec 2007 11:51:55 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id h71si6274806nzf.3.2007.12.23.11.51.55; Sun, 23 Dec 2007 11:51:55 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1J6WrV-0004He-Vf for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Sun, 23 Dec 2007 19:51:49 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 23 Dec 2007 19:51:49 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 23 Dec 2007 19:51:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712230853u1bc0160ap936c2d0a6fe0203b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69194>


Marco Costalba wrote:
> 
> What I'm looking for is git.exe itself. If I run "git --exec-path" I
> get something along the lines "git executable not found..."
> 
> I don't use dashed command inside qgit, so I run "git log ..." not
> "git-log ...", but the git.exe should be known to qgit or in path.

If you're planning to create an installer for qgit, a good solution 
would be to ask the user to manually point to the msysgit installation 
directory if not found in the path. Then the installer could just save 
the directory to an ini file along 'qgit.exe'.

Abdel.
