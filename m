From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/11] Place __stdcall to correct position.
Date: Tue, 18 Aug 2009 11:36:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181134500.4680@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171859060.4991@intel-tinevez-2-302> <1976ea660908171851n16b8b56j378ace9ecf0ce272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-661245009-1250588180=:4680"
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 11:36:32 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdL7H-0006iO-BL
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 11:36:31 +0200
Received: by yxe34 with SMTP id 34so5879412yxe.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=MJwb7Dt3N7GxUQTaUgMLeMoLnoO+2tFb5xYeRqoMVNg=;
        b=ucLEaxyQ0Seb9krOFUjcVrDtNQ8lTtDEEZdfmT7Drzzw56wldCDp64LhQrAR7HQ3Nb
         d9IqfnJ7O0bjRp17TFBJv0mcroLBPvFBGns6nCQg0FhQHafUjWa2T0ityxzB/YUJKub0
         Uu/hktviNTG7okdzTt0crLUtJDy4nMmeZxyxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=rd8O9AuSdgNAIlrQhckW7uRY5IVjeb/AOOlpWPdx2qxZVFIODhIl5MfPxp/8WkN2TJ
         wQ6mnZptXmgExh/VLS7U4XnnAGsWEBIjqcQ74Ta9PbXTRM18B+AhfFrh+YU60AuUyZi0
         +W4sZojKA2lU/q3vfmSxbTxJjw9mzpzvkrtEU=
Received: by 10.90.48.10 with SMTP id v10mr382150agv.25.1250588185302;
        Tue, 18 Aug 2009 02:36:25 -0700 (PDT)
Received: by 10.177.102.22 with SMTP id e22gr6443yqm.0;
	Tue, 18 Aug 2009 02:36:22 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.134.70 with SMTP id i6mr149676fat.19.1250588180956; Tue, 18 Aug 2009 02:36:20 -0700 (PDT)
Received: by 10.223.134.70 with SMTP id i6mr149675fat.19.1250588180931; Tue, 18 Aug 2009 02:36:20 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si739423bwz.0.2009.08.18.02.36.20; Tue, 18 Aug 2009 02:36:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 18 Aug 2009 09:36:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp041) with SMTP; 18 Aug 2009 11:36:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kWWlGA1RksQ9fNdcZIEuoc6+0PhHebCQkp7OiEJ ij/pJAXrP+ts/+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1976ea660908171851n16b8b56j378ace9ecf0ce272@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126362>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-661245009-1250588180=:4680
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> > How about "... to the correct ..." and "MSVC requires _stdcall to be
> > between return value..." and "All Win32 API functions are declared with
> > the WINAPI attribute."?
> 
> WINAPI always like
> 
> BOOL WINAPI function_name(xxx);
> It compile fail if WINAPI BOOL function_name(xxx);

Oh, okay, so let's say

	Furthermore, Microsoft Visual C++ requires the order

		BOOL WINAPI function();

	instead of

		WINAPI BOOL function();

> >>  #if defined(__MINGW32__) || defined(_MSC_VER)
> >> -static __stdcall unsigned run_thread(void *data)
> >> +static unsigned __stdcall run_thread(void *data)
> >>  {
> >>       struct async *async = data;
> >>       return async->proc(async->fd_for_proc, async->data);
> >>  }
> >> -#endif
> >> +#endif /* __MINGW32__ || _MSC_VER */
> >
> > I do not think this is necessary.  There are only 5 lines wrapped into
> > those #ifdef guards, the developer should be able to see that far.
> >
> Do you means remove /* __MINGW32__ || _MSC_VER */?

I was talking about this change:

> -#endif
> +#endif /* __MINGW32__ || _MSC_VER */

which is IMHO distracting rather than helpful.

Ciao,
Dscho


--8323329-661245009-1250588180=:4680--
