From: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 23:23:57 +0300
Message-ID: <20080207202357.GO30368@dpotapov.dyndns.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org>
Reply-To: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 21:24:44 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.191])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNDIS-0005Co-K2
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 21:24:36 +0100
Received: by ag-out-0910.google.com with SMTP id 32so6233791agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=vNQRhTPaeDWfTzVAD53ofhjZA7WoUl3BvTCkO3EeGlw=;
        b=HiL5PaVb9ASDGxBaXW1Qir3+RGjy6l9ZZM307QWEO5jRtI3VOLESlKiE0mkQsnOLtSN1GpKqslEpS1Epp4/SSqPUhGjqAXboytv945O923I6TfH/xnxhdjpKiTfpVX+iHMVM/nGoGrI/ptSo2RwtK9KGPIlVvq5ht6WmrhuiRNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=M7mU282Gv1OYHCYFgAT/AjIB1ExTbmE94TfuMnCT5MZGEBWXPuf8XtfrMpc2UGxNyNYJitebFvqnA3J05bZ3sdsAycMNny7u2TqHYDyt3ZGddoJQo/oUmnBEv5o+iQp0thkxgPjqSrQKZin9/8Myc1X26DAC96SeU/8bP4XjV9Q=
Received: by 10.143.19.5 with SMTP id w5mr2301wfi.24.1202415843908;
        Thu, 07 Feb 2008 12:24:03 -0800 (PST)
Received: by 10.106.159.13 with SMTP id h13gr1668pre;
	Thu, 07 Feb 2008 12:24:03 -0800 (PST)
X-Sender: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr25715604pym.3.1202415843710; Thu, 07 Feb 2008 12:24:03 -0800 (PST)
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186]) by mx.google.com with ESMTP id x46si7381118pyg.3.2008.02.07.12.24.02; Thu, 07 Feb 2008 12:24:03 -0800 (PST)
Received-SPF: pass (google.com: domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 64.233.182.186 as permitted sender) client-ip=64.233.182.186;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 64.233.182.186 as permitted sender) smtp.mail=dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by nf-out-0910.google.com with SMTP id b2so945878nfb.3 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; bh=J49qx+saXjsh7U+P9oJCjddqh89HpMqZjbyVRlF7R80=; b=h85rwUJtRHIPbk6VhddBzPSA1axMwztYWQ/91u5BCTl4B48MuWIVnEtZx0zoaXBvv30PkWPP3YeIGLXxTVLJCACgJnD+nUNLrX/gUK+WV692/kg531xA4M7HYHRWUP7cA0UISc7wmRDgiSW4q+hxlj1Ll0+uM8CV28AYRmOE5go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; b=o6+65Mr5A8URXBeCS6VBq70CAdI609axM1kzLkH1OJDuGdG14CcNnjONyropXykrbrIBCiU93Szf9o8GKIBvzQZu2U/EBOm/HRIxWdAR4o6D51RWyGJpvoBNmW9/Xfk3cVXwkSIigXaOHqvSrRl/BGdDzSKQQHgRHyS503/o2/I=
Received: by 10.150.196.5 with SMTP id t5mr4862584ybf.109.1202415842410; Thu, 07 Feb 2008 12:24:02 -0800 (PST)
Received: from localhost ( [85.141.191.183]) by mx.google.com with ESMTPS id s10sm12582646mue.15.2008.02.07.12.23.59 (version=TLSv1/SSLv3 cipher=OTHER); Thu, 07 Feb 2008 12:24:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vprv8mu2k.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72997>


On Thu, Feb 07, 2008 at 11:42:59AM -0800, Junio C Hamano wrote:
> 
> It does not matter if the person is somebody you know or you
> have shared with.  I'd grant you that Luciano could have been
> more diplomatic when he started his message, but I'd agree that
> it is silly to refuse to install an end user program unless the
> end user agrees to GPL that governs how its sources can and
> cannot be used, especially if the installer does not even
> install the sources to the software.

Actually, the GPL is applied to the binary form too, and it
prescribes how the program can be redistributed. There is no
restriction on how the user can run the program, but we still
must give to the user a copy of GPL in the appropriate way.
Besides, the user should acknowledge that he or she is warned
the program is provided "AS IS" without warranty of any kind.
If the user cannot accept that, he or she should not run the
program.

So, the current Git installer fully adheres to GPL requirements
and installs Git in the traditional for Windows way. I don't
see anything here that can be considered as bug.

Dmitry
