From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 13:45:38 +0100
Message-ID: <019B1C82-27BF-4B6B-981D-5498D31B5DD3@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <B655B6FF-9377-434A-A979-2E758771B0FA@zib.de> <alpine.LSU.1.00.0801091100401.31053@racer.site>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 13:46:15 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.241])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCaJu-00039S-32
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 13:46:10 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1961064wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=9cSMqbBiHyNVN/dxWFu6gN3BEaYBcHiQWhk2jUai510=;
        b=mQpx3xnHaZ+2opRz2eYnOQbuVQVguErcPNMDBp2ySu01iVxlaJIFufzSn50vbXFvF+avkrOEOowsLpQjgnPakK4JB8o8KFNEb0XRl+INTjYVrjtHZMEcC25EzPx5HDabT2J82eNUJEBhkD5I2Ls9TfD9+5sQUB0WoYEAQNjjk6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=i5ctUwNnX0ud46qR5zI6TBnNVYS8ClZSCxJ8cspdhHpGa3kWpt+s/+Gs8DNLallXaqYjiv0hQ3NB4FebK20/wSyoICq/Ej7MtfTT9AtbiJF14iGSBoAJltE0ssl72dyRFBjXZk0PjcIxfWuMsDRquCMzYAgwOxKLbzGAgf/0kVU=
Received: by 10.140.141.15 with SMTP id o15mr792920rvd.17.1199882739198;
        Wed, 09 Jan 2008 04:45:39 -0800 (PST)
Received: by 10.44.24.32 with SMTP id 32gr1346hsx;
	Wed, 09 Jan 2008 04:45:39 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.197.13 with SMTP id z13mr48846882qbp.0.1199882738736; Wed, 09 Jan 2008 04:45:38 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h71si29617247nzf.3.2008.01.09.04.45.37; Wed, 09 Jan 2008 04:45:38 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m09CiXI6007048; Wed, 9 Jan 2008 13:44:33 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m09CiWWT000321 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 9 Jan 2008 13:44:33 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801091100401.31053-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69986>



On Jan 9, 2008, at 12:03 PM, Johannes Schindelin wrote:

> On Tue, 8 Jan 2008, Steffen Prohaska wrote:
>
>> On Jan 8, 2008, at 8:47 PM, Junio C Hamano wrote:
>>
>>> I think the project can mark text files as text with attributes  
>>> and if
>>> the port to the platform initialized core.autocrlf appropriately for
>>> the platform everything should work as you described.
>>>
>>> At least that is how I read the description of `crlf` in
>>> gitattributes(5).
>>
>> But we do not want to mark a file as text but tell git to run its
>> auto-detection and use the local default line endings.  But for
>> different projects we do not even want to run the auto-detection, but
>> leave the files as is.
>
> Probably the best thing would be to default to crlf=true, and then  
> have a
> .gitattributes file like this in your project:
>
> -- snip --
> *.am -crlf
> -- snap --
>
> (Did I guess right about the file extension? But why do you want to  
> check
> in huge 3D stacks? Ah, of course, for test cases.)

Yes, thanks ;)

For now, this is the right thing to do.  However, our file format
and the application does not depend on the extension.  A a long
term solution, I'll fix our file format header to include '\0' if
the file is binary.

	Steffen
