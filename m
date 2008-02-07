From: Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 09:53:05 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802070949460.2732@xanadu.home>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 16:05:04 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN8JA-00033E-6u
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 16:05:00 +0100
Received: by yw-out-2122.google.com with SMTP id 4so5048865ywc.37
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:mime-version:content-transfer-encoding:content-type:received:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=H/HChjCYwjhlHjiiiOX4lYLXsjaWsGbNt9ip5nBCaVA=;
        b=w3eZxT5MK7GmZ3pFWnahF7sNS29YtooqSEXSv9LNdYLfNHIQtVETeP/OmxR9EEAWCgAYATX8IxKitg1zPFAwc96yk1eK+AeMOLc8vvGeJ4Qd7zrEIEmmCDf/mC/j55wiP6kHM+/PivaRGLPJyCL9TsK7h4P2VBXE7La6pRzBnC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:mime-version:content-transfer-encoding:content-type:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=qAlqlZ5T7wllJap/hK7EHKGcc1aDeCoZtwY2Dqn2QTczlsG5CCkdT2oUnLZ7KWv1ktL3+CvC9Jgrtl3tG/1+N99j6uNOCVHK877Z8h9Yfh0QZkkIQRpHPWn2YfQSHustU5zYqKicUtovz4tw2xvVmyzD1VjkW+Jf/s0wHJYOpxc=
Received: by 10.142.213.9 with SMTP id l9mr213083wfg.16.1202396668313;
        Thu, 07 Feb 2008 07:04:28 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1644pro;
	Thu, 07 Feb 2008 07:04:28 -0800 (PST)
X-Sender: nico-mo2vmkxb4K0@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr25121810pyi.7.1202396667702; Thu, 07 Feb 2008 07:04:27 -0800 (PST)
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36]) by mx.google.com with ESMTP id a28si6685509pye.0.2008.02.07.07.04.27; Thu, 07 Feb 2008 07:04:27 -0800 (PST)
Received-SPF: neutral (google.com: 24.201.245.36 is neither permitted nor denied by domain of nico-mo2vmkxb4K0@public.gmane.org) client-ip=24.201.245.36;
Authentication-Results: mx.google.com; spf=neutral (google.com: 24.201.245.36 is neither permitted nor denied by domain of nico-mo2vmkxb4K0@public.gmane.org) smtp.mail=nico-mo2vmkxb4K0@public.gmane.org
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit)) with ESMTP id <0JVV00COYIOB4R60-NEFkh5ie623J4At/osOC0VpqB1olwzkXLAPz8V8PbKw@public.gmane.org> for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 09:53:00 -0500 (EST)
X-X-Sender: nico-QuJgVwGFrdf/9pzu0YdTqQ@public.gmane.org
In-reply-to: <20080207130715.GA14000-oEplIgxCSygGFt9iVWuREaMaJEuR8uiQ@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72956>


On Thu, 7 Feb 2008, Luciano Rocha wrote:

> On Thu, Feb 07, 2008 at 12:55:58PM +0000, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 7 Feb 2008, Luciano Rocha wrote:
> > 
> > > Why do I have to accept the GPL to install msysgit?
> > 
> > Because that's the only license you have to use git.
> 
> Again, GPL governs distribution, not use.
> 
> > Get over it, or use another SCM,
> 
> I like and use GPL, but I won't force my users to accept the GPL in
> order to use programs released under it.

What are they forced into if they indeed only want to _use_ Git?

They nevertheless must be made aware of the rules they have to follow in 
case the idea of redistributing it crosses their mind.


Nicolas
