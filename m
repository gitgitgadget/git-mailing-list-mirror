From: kevin molcard <kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git clone fails with "bad pack header", how to get
 remote log
Date: Tue, 30 Oct 2012 15:57:36 +0100
Message-ID: <508FEAE0.20204@gmail.com>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com> <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
X-From: git-users+bncBCRMXTNY2MBRBY6VX6CAKGQEDCY5IOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Oct 30 15:57:50 2012
Return-path: <git-users+bncBCRMXTNY2MBRBY6VX6CAKGQEDCY5IOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCRMXTNY2MBRBY6VX6CAKGQEDCY5IOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TTDGH-0002Ig-FJ
	for gcggu-git-users@m.gmane.org; Tue, 30 Oct 2012 15:57:49 +0100
Received: by mail-ee0-f58.google.com with SMTP id c1sf125075eek.3
        for <gcggu-git-users@m.gmane.org>; Tue, 30 Oct 2012 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=X7O6BuC+atcjqqonHUPRHdDtsmUn7n0AL+I1u/uiCmQ=;
        b=yGcr6JRwp+FqjWoMBMzo6F41opxiN7pEhk7QP+pxSQ8iJcARwpdvZ6QwyO+gQ4FEUL
         763Kx8sflvd2+acxaebaG09jn51u27bangj1eDUxD1i1DqsA15qt1WH6C2K5c1BeZtbM
         78h8okEvHmfdix9bqUbpFFFPiQ1hECIYrt3u6jXX4Mk2IuxKIUkjHkJLySTngQ6iL2x8
         LwN1JRlyw89ULUXwWs1Z69VqbrQijq8TCUB1Z2QRZUOP660N+o0Ym6STQJOJCjlmWR/2
         k+WrRi+cbi8oa/pBOeUfsWu+OpuM4PkkLaaXv37qFqLeTkZYQMne2Fpmo6wAFa3xC+cU
       
Received: by 10.216.140.160 with SMTP id e32mr1190575wej.27.1351609060361;
        Tue, 30 Oct 2012 07:57:40 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.20.236 with SMTP id q12ls825493wie.1.gmail; Tue, 30 Oct
 2012 07:57:39 -0700 (PDT)
Received: by 10.216.199.78 with SMTP id w56mr1922946wen.11.1351609059586;
        Tue, 30 Oct 2012 07:57:39 -0700 (PDT)
Received: by 10.216.199.78 with SMTP id w56mr1922945wen.11.1351609059554;
        Tue, 30 Oct 2012 07:57:39 -0700 (PDT)
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com [209.85.212.171])
        by gmr-mx.google.com with ESMTPS id gp9si65179wib.0.2012.10.30.07.57.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 07:57:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.212.171 as permitted sender) client-ip=209.85.212.171;
Received: by mail-wi0-f171.google.com with SMTP id hj13so2869801wib.6
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Tue, 30 Oct 2012 07:57:39 -0700 (PDT)
Received: by 10.180.105.168 with SMTP id gn8mr3385985wib.10.1351609059448;
        Tue, 30 Oct 2012 07:57:39 -0700 (PDT)
Received: from md009.arturia.lan (mey38-2-82-228-181-124.fbx.proxad.net. [82.228.181.124])
        by mx.google.com with ESMTPS id a2sm6828171wie.6.2012.10.30.07.57.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 07:57:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <20121029211854.b58c791d30a6c8d68665e574-g5ZlayWIM10NZ+ppGFcyYQ@public.gmane.org>
X-Original-Sender: kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.212.171 as permitted sender)
 smtp.mail=kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208704>

I tried to install git 1.8 on the remote server and get exactly the same 
problem :(.

Kevin

On 10/29/12 6:18 PM, Konstantin Khomoutov wrote:
> On Mon, 29 Oct 2012 09:52:54 -0700 (PDT)
> Kevin Molcard <kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> I have a problem with my build system.
>>
>> I have a remote server with a relatively large repository (around 12
>> GB, each branch having a size of 3 GB).
>>
>> I have also 2 build servers (Mac, Windows) that are cloning the repo
>> from the remote.
>>
>> Sometimes (very often when several git clone are sent at the same
>> time), I have the following error:
>>          
>>      remote: internal server error
>>      fatal: protocol error: bad pack header
>>
>> I know that it happens when the remote is compressing objects (thanks
>> to `--progress -v` flags) because the last line of the log before the
>> erro is:
>>      remote: Compressing objects:  93% (17959/19284)   [K
>>
>>   * So I have 2 questions, does anybody what is the problem and what
>> should I do?
>>   * Is there a way to get a more precise log from the remote to debug
>> this problem?
> This reminds me of a bug fixed in 1.7.12.1 [1]:
>
> * When "git push" triggered the automatic gc on the receiving end, a
>    message from "git prune" that said it was removing cruft leaked to
>    the standard output, breaking the communication protocol.
>
> In any case, bugs should be reported to the main Git list (which is
> git at vger.kernel.org), not here.
> I'm Cc'ing the main Git list so you'll get any responses from there, if
> any.
>
> Kevin, please answer to this message (keeping all the Ccs -- use "Reply
> to group" or "Reply to all" in your MUA) and describe exactly what Git
> versions on which platforms your have.
>
> 1. https://raw.github.com/git/git/master/Documentation/RelNotes/1.7.12.1.txt
>

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
