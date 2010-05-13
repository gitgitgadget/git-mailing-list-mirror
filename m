From: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Initial setup question
Date: Wed, 12 May 2010 20:04:12 -0500
Message-ID: <20100513010411.GA26612@progeny.tock>
References: <4BEAFC62.40409@smartmediacorp.com>
Reply-To: gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Noah Silverman <noah-OMyv7SbxW+RvqA2Dkdf5ddBPR1lH4CV8@public.gmane.org>
X-From: gitx+bncCPy4qcTgERD2n63fBBoEgkILYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 13 03:03:57 2010
connect(): No such file or directory
Return-path: <gitx+bncCPy4qcTgERD2n63fBBoEgkILYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvg-gitx@m.gmane.org
Received: from mail-yw0-f167.google.com ([209.85.211.167])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <gitx+bncCPy4qcTgERD2n63fBBoEgkILYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1OCMqB-0000fG-H0
	for gcvg-gitx@m.gmane.org; Thu, 13 May 2010 03:03:55 +0200
Received: by ywh39 with SMTP id 39sf454639ywh.24
        for <gcvg-gitx@m.gmane.org>; Wed, 12 May 2010 18:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:reply-to
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition:content-transfer-encoding;
        bh=RFVz9drq8vDPMxSjxTKC5uh/EzgoIs+UWn/bw+HbKIc=;
        b=nJST0JVDThh0R98Z/I4GRb9Tu9S+iG9FNrMBuk+g1HkrdQF2LCMWyg3QSByh6DbKJ5
         pP7DhthFRSYat/66v+f+vaRTDyshUwkDu5mHi3IJ94CSBPnsvnj2UZ5enTd9gmLhFoHJ
         +uYSOXzmKYT+E5gVP1C4RJcuqsC2u1o/hz8FU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:reply-to
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition:content-transfer-encoding;
        b=5llrBVUybWCqWiQhLw/YWsWcR85OqIuFx1od3kVr7wq5jyBasJToCRFVz3Q9lfGLW9
         XVnTNxDnHNKjCXvkoBnIXJDPHGfERT3eZSE5OMbxhFudnGIC1OJXK3CUocXloKEtnBgS
         uSvjdm01wyNR5+5TOmyxViK5oVVleWWLAc5aw=
Received: by 10.150.168.5 with SMTP id q5mr996587ybe.9.1273712630953;
        Wed, 12 May 2010 18:03:50 -0700 (PDT)
X-BeenThere: gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.91.67.25 with SMTP id u25ls11859378agk.7.p; Wed, 12 May 2010 
	18:03:50 -0700 (PDT)
Received: by 10.90.41.36 with SMTP id o36mr44856ago.8.1273712630344;
        Wed, 12 May 2010 18:03:50 -0700 (PDT)
Received: by 10.90.41.36 with SMTP id o36mr44855ago.8.1273712630310;
        Wed, 12 May 2010 18:03:50 -0700 (PDT)
Received: from mail-gw0-f46.google.com (mail-gw0-f46.google.com [74.125.83.46])
        by gmr-mx.google.com with ESMTP id 18si60991gxk.3.2010.05.12.18.03.49;
        Wed, 12 May 2010 18:03:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.83.46 as permitted sender) client-ip=74.125.83.46;
Received: by mail-gw0-f46.google.com with SMTP id 19so388609gwj.19
        for <gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 12 May 2010 18:03:49 -0700 (PDT)
Received: by 10.150.253.11 with SMTP id a11mr14248822ybi.245.1273712629118;
        Wed, 12 May 2010 18:03:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm162218yxe.0.2010.05.12.18.03.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 18:03:48 -0700 (PDT)
In-Reply-To: <4BEAFC62.40409-OMyv7SbxW+RvqA2Dkdf5ddBPR1lH4CV8@public.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.83.46 as permitted sender) 
	smtp.mail=jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
X-Original-Sender: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Precedence: list
Mailing-list: list gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact gitx+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <gitx.googlegroups.com>
List-Post: <http://groups.google.com/group/gitx/post?hl=en_US>, 
	<mailto:gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:gitx+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/gitx?hl=en_US>
Sender: gitx-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/gitx/subscribe?hl=en_US>, 
	<mailto:gitx+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/gitx/subscribe?hl=en_US>, 
	<mailto:gitx+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146973>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146973>

Hi Noah,

Noah Silverman wrote:

> Using Gitx as a gui client.
> 
> I have ssh setup, keys, etc.
> 
> Can someone help me with the next step of pushing my initial repo up
> to the server as version 1?

  ssh some.host git init --bare /path/to/repo.git
  git remote add myrepo some.host:/path/to/repo.git
  git push myrepo master

I don’t know if Gitx has a button for this.

Hope that helps,
Jonathan
