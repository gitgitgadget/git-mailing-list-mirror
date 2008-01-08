From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 19:58:57 +0100
Message-ID: <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 19:59:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCJfc-00028g-AL
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 19:59:28 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1455179wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=lwFLfwRDoPv/L8ZnJGrctiFyoB8GVIgE1CdXJA9GvPU=;
        b=vZbszpvtZtf/JQCE/eFhDnaBxEWU963DPkeradniPGOi0UbqioI/bcJdg6UVMv9MFNSQprv6dHEMn686ObTtCBCmhvu9TyRgVVCb1s3DpziLDcEl1/Dzvr2Jp31rkDk/HOnE2m9w3qHOrJFdzoVl1B4o9h+m06dIU2Mca9q3iGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=cFTe1KxPDkOOajbPeUfxlsTt/j1Yle/cxznb9ub+krFwYSH6RGdgdJziDXm5P7SGeZlivue0RkNF+8S7+YfhcxzfR4tdA+y+uqLYPVhdZSyVvW9x/a7fQ8bapwLTIxe2xfnaoZtBcWVHRJDdkqFgGAUxvqwQLRs3ZdqIlQy3R6E=
Received: by 10.140.144.4 with SMTP id r4mr783216rvd.16.1199818741212;
        Tue, 08 Jan 2008 10:59:01 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1323hsm;
	Tue, 08 Jan 2008 10:59:01 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.75.2 with SMTP id c2mr48291481qbl.5.1199818740625; Tue, 08 Jan 2008 10:59:00 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id v28si29135980nzb.4.2008.01.08.10.58.59; Tue, 08 Jan 2008 10:59:00 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m08Ivqdt025292; Tue, 8 Jan 2008 19:58:52 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m08Ivpqa022651 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 8 Jan 2008 19:57:51 +0100 (MET)
In-Reply-To: <7vmyrgry20.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
X-Mailer: Apple Mail (2.753)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69904>



On Jan 8, 2008, at 7:07 PM, Junio C Hamano wrote:

>
>
> Steffen Prohaska <prohaska-wjoc1KHpMeg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
>
>> msysgit installs plain git.  core.autocrlf is unset.  Whatever plain
>> git's default is, this is msysgit's default, too.
>
> That sounds like a mistake if you are installing a port to a
> platform whose native line ending convention is different from
> where plain git natively runs on (i.e. UNIX).

We failed to agree on a better default and as the lengthy
discussion documents, the best default isn't obvious.

I don't think a solution will be found by declaring one platform
native (UNIX) and all other platform non-native.  The question to
answer is how to support cross-platform projects.  A valid
solution should never corrupt data unless the user explicitly
told git to do so.  I don't believe it is a valid solution to set
core.autocrlf=true on Windows and tell the users: "Well, in its
default settings, git sometimes corrupts your data on Windows.
Maybe you want to switch to Linux because this is the native
platform where data corruption will never happen."

I'd prefer the "warn/fail" proposal.

	Steffen
