From: Jari Aalto <jari.aalto-w6EBCRcXQ4deoWH0uzbU5w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Fri, 08 Feb 2008 00:46:20 +0200
Organization: Private
Message-ID: <fxw4v0zn.fsf@blue.sea.net>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 23:48:06 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNFXE-0004AM-Ll
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 23:48:01 +0100
Received: by wr-out-0708.google.com with SMTP id 56so7011561wra.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 14:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:organization:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=iL4ieaostVrCTLN6Xdnly6voAuMs68kJPnxCtqXfVZk=;
        b=PbGgRmGfc7DQzsT2svoUEwK0q+aUV4XAMMam0dXLTXz62Ozy2dfukx0JAJOvh3E1qQn+CgooP9TCGxfBlps9lrhQC23XlkETpQPdCu5xeyggJEiSo8mxOgOw528TQrQX8JwyITYAVIW75U8cMJKlimG4Wt8EU1/LBMAQV7zxPsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:organization:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=dPS3m9AZS7ntIugRbmwpXy6pR2OcAkWNnfoxGuHiFPlfZnC0mhknfewQNo9Tq5EIajRE7DF4Nk+D5m+iK/n3wFpotYTN3fZdS3jYYGOqTPivCyPvwWSJfZIPdd74UCuewODPwlcJZ0jD8AgXt9ObEFtbPpFxs6whNfRo9ys/VoU=
Received: by 10.100.136.15 with SMTP id j15mr991214and.21.1202424440074;
        Thu, 07 Feb 2008 14:47:20 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1673prf;
	Thu, 07 Feb 2008 14:47:20 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr25932057pyj.6.1202424439647; Thu, 07 Feb 2008 14:47:19 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id z53si7686521pyg.1.2008.02.07.14.47.18; Thu, 07 Feb 2008 14:47:19 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1JNFWV-0005rY-44 for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 22:47:15 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 22:47:15 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 22:47:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:TKorgOE9HMKCBt7o+wT9Zxgt75o=
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73014>


* Thu 2008-02-07 Johannes Schindelin-Mmb7MZpHnFY <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
* Message-Id: alpine.LSU.1.00.0802071831520.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
> The reasoning for showing the GPL in the Git installer..in favour, for two 
> reasons:
>
> - the end users should really know that the software is licensed in a 
>   pretty free way.

No they don't. The git binary is free in its distributable form and
needs therefore no such "EULA to be clicked".

Git is distributed everywhere else without "press the button to
bypass/accept/whatever reading the GPL". Let's not make some platform,
and a specific version of it, an exception.

FYI, Windows / Cygwin, version does not require user to click past such
"EULA".

> - _every_ serious Windows program comes with a click-through license.  We 
>   just don't want to be left behind.

No they don't. Have a look at vast number of Freeware software out there
www.nonags.com, tucows etc. They do not at all require such measures.

And yes, Freeware is serious software for Windows users.

> - even if it would be not necessary to accept the license (which I am not 
>   at all sure about

Redhat, The big company, has allowed the hosted Cygwin project to
distribute GPL software for ages under Windows. And their lawyers *have*
certainly checked that Cygwin installer does not need user to click "GPL
EULA" to have Cygwin installed.

That pretty much proves that there is no need for "read LICENCE to
install" button to be present.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
