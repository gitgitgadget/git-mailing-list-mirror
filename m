From: kevin molcard <kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git clone fails with "bad pack header", how to get
 remote log
Date: Wed, 31 Oct 2012 15:25:29 +0100
Message-ID: <509134D9.1050705@gmail.com>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com> <20121029211854.b58c791d30a6c8d68665e574@domain007.com> <508FEAE0.20204@gmail.com> <20121031141955.GC24291@sigill.intra.peff.net>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: git-users+bncBCRMXTNY2MBRBXHJYSCAKGQEI54SGLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Oct 31 15:25:47 2012
Return-path: <git-users+bncBCRMXTNY2MBRBXHJYSCAKGQEI54SGLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCRMXTNY2MBRBXHJYSCAKGQEI54SGLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TTZEj-0003wc-Ae
	for gcggu-git-users@m.gmane.org; Wed, 31 Oct 2012 15:25:41 +0100
Received: by mail-la0-f58.google.com with SMTP id p5sf543377lag.3
        for <gcggu-git-users@m.gmane.org>; Wed, 31 Oct 2012 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=S8+jgpgTflnRBCVJTS8q7nNweLLyD+6UHi3G+tWobUs=;
        b=ZlFMeaLgH3waahq0sBqy4ySRJMEU1kQP1WesYPT66nwfdKOSqfmvryrwLDpxSLa/0t
         f3JYgpAXf+mBcXzHmrQ3PvRztOrF0L+lGt+Ud9OKK/APnM52XTnN2KMtf7W4gwjyIx2Z
         avluB+Rt3Wmu/1fNavqNg86FpM4Ft9LsWMpGnTTtfMRtisKaRlu3pQB9gUM0Z5IZQR+Y
         6mdQLnNJjze9KfDldERIkAyQklz0tu4QxJHuJhqeI73XPHYttI+1uTkyKsct8Ypm0uLa
         WRaY+rqlxhgAFN8RdTaGx6MFq1V1pg9Ryq2YX8hG8RX6YxMcNrhOasBixFis7wg3KfAT
       
Received: by 10.180.102.130 with SMTP id fo2mr296005wib.2.1351693533004;
        Wed, 31 Oct 2012 07:25:33 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.77.130 with SMTP id s2ls3081567wiw.4.gmail; Wed, 31 Oct
 2012 07:25:32 -0700 (PDT)
Received: by 10.180.84.74 with SMTP id w10mr528025wiy.4.1351693532283;
        Wed, 31 Oct 2012 07:25:32 -0700 (PDT)
Received: by 10.180.84.74 with SMTP id w10mr528023wiy.4.1351693532236;
        Wed, 31 Oct 2012 07:25:32 -0700 (PDT)
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
        by gmr-mx.google.com with ESMTPS id bu8si249196wib.2.2012.10.31.07.25.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 07:25:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.82.53 as permitted sender) client-ip=74.125.82.53;
Received: by mail-wg0-f53.google.com with SMTP id dr1so777828wgb.22
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 31 Oct 2012 07:25:32 -0700 (PDT)
Received: by 10.180.78.170 with SMTP id c10mr3028282wix.5.1351693532090;
        Wed, 31 Oct 2012 07:25:32 -0700 (PDT)
Received: from md009.arturia.lan (mey38-2-82-228-181-124.fbx.proxad.net. [82.228.181.124])
        by mx.google.com with ESMTPS id dq6sm18181907wib.5.2012.10.31.07.25.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 07:25:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <20121031141955.GC24291-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
X-Original-Sender: kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.82.53 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208826>

Yes I can,
can you tell me how I have to do that?

thanks
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
