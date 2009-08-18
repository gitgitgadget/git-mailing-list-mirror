From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Add MSVC porting header files.
Date: Tue, 18 Aug 2009 15:01:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181500450.4680@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302> <1976ea660908171915v62fb6c40j17f750cac9836433@mail.gmail.com> <alpine.DEB.1.00.0908181140460.4680@intel-tinevez-2-302> <7v4os5jtd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 15:01:44 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOJs-0001IP-IW
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 15:01:44 +0200
Received: by qyk30 with SMTP id 30so4825778qyk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=lQNcc84stwFXR42tfqy9A0qQ4aOoh3YD9Imo4yDoOoU=;
        b=pFqarXLGlwvDfAH8GtWiZmhuzWMdgJ9afEuZzelMXpS/fhyOhl8ZXv0n8KVle376h5
         A2zqJ2gfwHeUQjCdtryduWyhD/b0a9CkyiiDPge2XAMDp7rNedUzMXphiMW94f0njDi6
         Xv6FTYBEYZvlaJOSYzD2irhwv3LGGv5+uokpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=tB44QE2FkWUf5cJF/n+8wC4duX6njD0IHfpdZ287MTpTKa1q35i51dUKE88PC7ISHp
         b7PrZeVRlySKCJSHw7CjDfkaGMevl9fY0Ojg07/LwwtQYWSSA5TLnPGu+/0uK7G4cOlB
         kRRYpz7TJLjpcUae9IPyhMiDTPQ7vwRy4qj34=
Received: by 10.220.78.9 with SMTP id i9mr1074937vck.8.1250600497843;
        Tue, 18 Aug 2009 06:01:37 -0700 (PDT)
Received: by 10.177.38.34 with SMTP id q34gr6467yqj.0;
	Tue, 18 Aug 2009 06:01:28 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.174.210 with SMTP id u18mr239445bkz.29.1250600487568; Tue, 18 Aug 2009 06:01:27 -0700 (PDT)
Received: by 10.204.174.210 with SMTP id u18mr239444bkz.29.1250600487527; Tue, 18 Aug 2009 06:01:27 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si773937fxm.2.2009.08.18.06.01.27; Tue, 18 Aug 2009 06:01:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 18 Aug 2009 13:01:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp027) with SMTP; 18 Aug 2009 15:01:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bbiVNckUbzkIq+DkCllGX659Q+y2Cn0DBCiat7y dKu2wJyDYTkq9u
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v4os5jtd9.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126393>


Hi,

On Tue, 18 Aug 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > As I said earlier, there are common flags, but as I also said, it is 
> > probably better to keep the #define's in a header file for better 
> > visibility and editability, albeit in logically clustered blocks (i.e. 
> > all the NO_* and other #define's that affect what source code is 
> > compiled, all default paths in another cluster, #define's to bow 
> > before Microsoft's C runtime's decision to deprecate the C99 standard 
> > function names, etc)
> 
> ... and that can live in a separate header file to reduce clutter and 
> shield people who do not need to look at MSC related code, no?

Maybe we could call it compat/msvc.h? ;-)

Ciao,
Dscho
