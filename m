From: Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 11:35:40 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802071133230.2732@xanadu.home>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 17:36:48 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.184])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9jq-0005Wm-6v
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 17:36:38 +0100
Received: by ag-out-0910.google.com with SMTP id 32so5912081agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:mime-version:content-transfer-encoding:content-type:received:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=oCpVNDM4HYoYusWBhlGP2McBttJTwRUOxr6f5EgX+ZU=;
        b=InkB8Po+nKEiqEPzQLsWnxdsm0DIzich+TSTLiko1vj0wIXIRMHmXW9U7vLaYAl1DLjLw45o3752qp2o8ob0nQMpaufz0H4SypvVSAo0yFDtQ60UN7ZTiWrHsNtIyAnqan2Zq28ftX+u6giY8hQVaEl8+/r6e01OKtRunI/TqMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:mime-version:content-transfer-encoding:content-type:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=YKa9KNTdMi8QP6gvzrhsSQB9dxvX6ILOLcQ653TGjNB3UhGr7HRv/XHoJyr+FfnFqh2yuCdM+Rem3SaNf8p5B90mpaBLB/SwPuE13IeZ8CXhNc22uYhmQ0tGVTl3BcnbMVhmb8M5r49I9ePUM0C8KE6ck6DPAhDpWomMLK2dmbU=
Received: by 10.140.82.38 with SMTP id f38mr397563rvb.5.1202402165291;
        Thu, 07 Feb 2008 08:36:05 -0800 (PST)
Received: by 10.106.78.1 with SMTP id a1gr1651prb;
	Thu, 07 Feb 2008 08:36:05 -0800 (PST)
X-Sender: nico-mo2vmkxb4K0@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr5235960pyn.5.1202402165014; Thu, 07 Feb 2008 08:36:05 -0800 (PST)
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36]) by mx.google.com with ESMTP id z53si6910199pyg.1.2008.02.07.08.36.04; Thu, 07 Feb 2008 08:36:05 -0800 (PST)
Received-SPF: neutral (google.com: 24.201.245.36 is neither permitted nor denied by domain of nico-mo2vmkxb4K0@public.gmane.org) client-ip=24.201.245.36;
Authentication-Results: mx.google.com; spf=neutral (google.com: 24.201.245.36 is neither permitted nor denied by domain of nico-mo2vmkxb4K0@public.gmane.org) smtp.mail=nico-mo2vmkxb4K0@public.gmane.org
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit)) with ESMTP id <0JVV00CKVNFGOSC0-ERcOzmQqbKXdZYtodpC61lpqB1olwzkXLAPz8V8PbKw@public.gmane.org> for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 11:35:41 -0500 (EST)
X-X-Sender: nico-QuJgVwGFrdf/9pzu0YdTqQ@public.gmane.org
In-reply-to: <20080207155946.GA20459-oEplIgxCSygGFt9iVWuREaMaJEuR8uiQ@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72964>


On Thu, 7 Feb 2008, Luciano Rocha wrote:

> On Thu, Feb 07, 2008 at 09:53:05AM -0500, Nicolas Pitre wrote:
> > What are they forced into if they indeed only want to _use_ Git?
> 
> The msys git installer forces me to accept the GNU GPL in order to
> proceed.
> 
> Of course, I can use another installer, or compile my own set of
> binaries. I just wanted to bring that case to attention, nothing else.
> 
> > They nevertheless must be made aware of the rules they have to follow in 
> > case the idea of redistributing it crosses their mind.
> 
> I don't dispute that, only that I can't continue with the install unless
> I click on "I Accept" to the GNU GPL.

Then, simply changing the button text from "I accept" to "Continue" 
should be OK?


Nicolas
