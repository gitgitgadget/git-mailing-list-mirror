From: David Kastrup <dak-mXXj517/zsQ@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 17:41:26 +0100
Message-ID: <86r6fora6h.fsf@lola.quinscape.zz>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com> <alpine.LFD.1.00.0802071133230.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 17:42:35 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9pM-0007md-1n
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 17:42:20 +0100
Received: by ug-out-1516.google.com with SMTP id 1so277445uga.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=uMRjkMmKm9YXJwxxzCyWC/pIGUkKKolj/b/GS4Xyx6I=;
        b=4Rw9P0eXNHfJUFQ0L4MQqu5VbP3nCv1Axf4B0dIbwicuN5AyLeet8KuqSDsD6x4gCcvG0HrtIRQD7fu9J0iw7j9w1VJ0U/89Ite2K9ExdJckciXTxyrDzRNDTZuTqxu4+otUM8bR7UMktjx59nkACd2c6H8kb1rUAxM1RnwsGH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=LuEkWrlKjMJLagsEm0AnD8/Sw9oo2qRP51CsxNiNdUVZhgXazkc8M93IpS3LdhwaBsVG6ZEk+xbIvzzfMseYCHPoYvmY84/5IQhJmH3azHOgYWGgpZnCM354hd/JAWyAlxa9s1ygT0H7chksuzo+ptte1HZMDA1ggqGW2gY6+Dk=
Received: by 10.150.51.6 with SMTP id y6mr504637yby.21.1202402507301;
        Thu, 07 Feb 2008 08:41:47 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1652prf;
	Thu, 07 Feb 2008 08:41:47 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr25301233pyj.6.1202402506835; Thu, 07 Feb 2008 08:41:46 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id x46si6897403pyg.3.2008.02.07.08.41.43; Thu, 07 Feb 2008 08:41:46 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1JN9od-0003hI-4I for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 16:41:35 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 16:41:35 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 16:41:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:zt7k9ln2DHVXv0JKFHB5cClswf4=
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72976>


Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org> writes:

> On Thu, 7 Feb 2008, Luciano Rocha wrote:
>
>> On Thu, Feb 07, 2008 at 09:53:05AM -0500, Nicolas Pitre wrote:
>> > What are they forced into if they indeed only want to _use_ Git?
>> 
>> The msys git installer forces me to accept the GNU GPL in order to
>> proceed.
>> 
>> Of course, I can use another installer, or compile my own set of
>> binaries. I just wanted to bring that case to attention, nothing else.
>> 
>> > They nevertheless must be made aware of the rules they have to follow in 
>> > case the idea of redistributing it crosses their mind.
>> 
>> I don't dispute that, only that I can't continue with the install unless
>> I click on "I Accept" to the GNU GPL.
>
> Then, simply changing the button text from "I accept" to "Continue" 
> should be OK?

Another rather neutral option would be the choice "Abort"/"Install".

-- 
David Kastrup
