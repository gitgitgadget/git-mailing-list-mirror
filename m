From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/12] MinGW: Convert CR/LF to LF in tag
 signatures
Date: Thu, 3 Jul 2008 12:08:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031208050.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <200807022046.28141.johannes.sixt@telecom.at>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: prohaska@zib.de, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 03 13:12:06 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEMjD-0002Le-VK
	for gcvm-msysgit@m.gmane.org; Thu, 03 Jul 2008 13:11:56 +0200
Received: by yw-out-2122.google.com with SMTP id 8so458749yws.63
        for <gcvm-msysgit@m.gmane.org>; Thu, 03 Jul 2008 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=mCCAOsrFIid8wbQdO9Daro5ULW7SLPqU5fQwwUaOOR4=;
        b=pbg/4UpFjjMJYFRcrP4M+yW9yyuITpSbmkRLulRNqGMD2NxzrZcOa+oFHnmsgNehEe
         RRLfJ/UUKztZuXsuKL3pipbAQ+mf1j73t8y8/al6FDGjZqx5Dbuv4kAQLxuLM4Rd64+b
         +C6MsU36gtTFgboDwR3XXeQ/I02GdCI6dOXEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=E/g1KsyN9OCCaV5Fi2mTGF4Rir7cp3hzYjYXgt7tOID2Q4tfwPIMMXTHZYxilnfKRC
         KkEf26cC+UOpJOT+uC1FNjkKyl8MqnUpuGHeLvG/oUWm2pLHROlqHGFlcfQNI7B4Q5Rt
         MTNwkgTYBVls5tbwwZ5ve01ap+fZb7ps5s7Hw=
Received: by 10.141.2.19 with SMTP id e19mr573452rvi.3.1215083454285;
        Thu, 03 Jul 2008 04:10:54 -0700 (PDT)
Received: by 10.106.234.8 with SMTP id g8gr2591prh.0;
	Thu, 03 Jul 2008 04:10:54 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.77.1 with SMTP id z1mr5365232waa.15.1215083452804; Thu, 03 Jul 2008 04:10:52 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 7si9485131yxg.1.2008.07.03.04.10.52; Thu, 03 Jul 2008 04:10:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 03 Jul 2008 11:10:51 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp048) with SMTP; 03 Jul 2008 13:10:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rmtsqFo8r8vBMH0b/Bkjj32s6s26MrKTvSDd99y fej5EdqPcT9UBf
X-X-Sender: gene099@racer
In-Reply-To: <200807022046.28141.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87262>


Hi,

On Wed, 2 Jul 2008, Johannes Sixt wrote:

> On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, gpg outputs CR/LF signatures.  But since the tag
> > messages are already stripped of the CR by stripspace(), it is
> > arguably nicer to do the same for the tag signature.  Actually,
> > this patch does not look for CR/LF, but strips all CRs
> > from the signature.
> >
> > [ spr: ported code to use strbuf ]
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> > ---
> >  builtin-tag.c |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/builtin-tag.c b/builtin-tag.c
> > index e675206..77977ba 100644
> > --- a/builtin-tag.c
> > +++ b/builtin-tag.c
> > @@ -241,6 +241,20 @@ static int do_sign(struct strbuf *buffer)
> >  	if (finish_command(&gpg) || !len || len < 0)
> >  		return error("gpg failed to sign the tag");
> >
> > +#ifdef __MINGW32__
> > +	/* strip CR from the line endings */
> > +	{
> > +		int i, j;
> > +		for (i = j = 0; i < buffer->len; i++)
> > +			if (buffer->buf[i] != '\r') {
> > +				if (i != j)
> > +					buffer->buf[j] = buffer->buf[i];
> > +				j++;
> > +			}
> > +		strbuf_setlen(buffer, j);
> > +	}
> > +#endif
> > +
> >  	return 0;
> >  }
> 
> Do we need the #ifdef __MINGW32__? Can't we just strip CRs unconditionally? It 
> shouldn't hurt on Unix anyway.

I agree, and I would even like to refactor this into its own function.  
Probably even move it to strbuf.[ch].

Ciao,
Dscho
