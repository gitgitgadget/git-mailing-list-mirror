From: kevin molcard <kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git clone fails with "bad pack header", how to get
 remote log
Date: Wed, 31 Oct 2012 15:34:22 +0100
Message-ID: <509136EE.6040705@gmail.com>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com> <20121029211854.b58c791d30a6c8d68665e574@domain007.com> <508FEAE0.20204@gmail.com> <20121031141955.GC24291@sigill.intra.peff.net>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: git-users+bncBCRMXTNY2MBRB47NYSCAKGQEABEI5QY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Oct 31 15:34:40 2012
Return-path: <git-users+bncBCRMXTNY2MBRB47NYSCAKGQEABEI5QY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCRMXTNY2MBRB47NYSCAKGQEABEI5QY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TTZNO-0007aS-BK
	for gcggu-git-users@m.gmane.org; Wed, 31 Oct 2012 15:34:38 +0100
Received: by mail-wg0-f58.google.com with SMTP id dt12sf553618wgb.3
        for <gcggu-git-users@m.gmane.org>; Wed, 31 Oct 2012 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=JElWreQEhRJg7X80+ibtQfp24s2sxDp/RfMBGRE3A5M=;
        b=Nm3xPt4niK+JikV3Bkz89BwSoOlFMKV0RVQLWs0EkebKS7daVJNj12eF5EqJJPls6n
         Zi4FkJQLPG3W3lx8hds6VtNClNi/w2RQt6EuG5eQHWZVToil6N3ePXjIg/yHtWCLNLLF
         6Glu+QNRHLOVl6IKNmDa7KlWdmoKUi8mQd7p4EFaFAJU8wFHVrLlN74mRuFQn8acKZT3
         stMkBHmFpeRn8jESqSanFHpYks9X++Q/GKs2o3ffgmW96/A/rVdRJF7BwkN3MP7Jfqz9
         A54bBVew6kkd1DaIBN0ia1ZT1atiZth4hPxlGAy1o2Z7iiSQAawqDS3UuxPzYVIsxoWX
       
Received: by 10.180.77.74 with SMTP id q10mr305678wiw.0.1351694068335;
        Wed, 31 Oct 2012 07:34:28 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.73.17 with SMTP id h17ls8694631wiv.0.canary; Wed, 31 Oct
 2012 07:34:27 -0700 (PDT)
Received: by 10.180.96.6 with SMTP id do6mr537293wib.1.1351694067537;
        Wed, 31 Oct 2012 07:34:27 -0700 (PDT)
Received: by 10.180.96.6 with SMTP id do6mr537292wib.1.1351694067528;
        Wed, 31 Oct 2012 07:34:27 -0700 (PDT)
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
        by gmr-mx.google.com with ESMTPS id v1si744915wiw.2.2012.10.31.07.34.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 07:34:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.82.51 as permitted sender) client-ip=74.125.82.51;
Received: by mail-wg0-f51.google.com with SMTP id ed3so725021wgb.32
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 31 Oct 2012 07:34:27 -0700 (PDT)
Received: by 10.180.90.78 with SMTP id bu14mr3031320wib.21.1351694067334;
        Wed, 31 Oct 2012 07:34:27 -0700 (PDT)
Received: from md009.arturia.lan (mey38-2-82-228-181-124.fbx.proxad.net. [82.228.181.124])
        by mx.google.com with ESMTPS id dm3sm6065637wib.3.2012.10.31.07.34.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 07:34:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <20121031141955.GC24291-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
X-Original-Sender: kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.82.51 as permitted sender)
 smtp.mail=kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en-US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en-US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208827>

I forgot to mention that I am using scm manager:
https://bitbucket.org/sdorra/scm-manager/wiki/Home

So that maybe the " custom layer you are talking about.

Kevin

On 10/31/12 3:19 PM, Jeff King wrote:
> On Tue, Oct 30, 2012 at 03:57:36PM +0100, kevin molcard wrote:
>
>> I tried to install git 1.8 on the remote server and get exactly the
>> same problem :(.
>> [...]
>>>> Sometimes (very often when several git clone are sent at the same
>>>> time), I have the following error:
>>>>      remote: internal server error
>>>>      fatal: protocol error: bad pack header
> I'm very confused about who is printing "internal server error". The
> "remote:" indicates that it came to the git client via the sideband,
> which means it probably came from the stderr of a child process (e.g.,
> pack-objects). But git does not and has never generated the phrase
> "internal server error".
>
> So what program is producing that? Is there some kind of custom layer
> that might be run when upload-pack runs "git pack-objects ..."? Can you
> try running strace on the server?
>
> -Peff
>

-- 
