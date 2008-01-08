From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 21:39:51 +0100
Message-ID: <FADDEA64-FFE7-4420-AC1F-19262F415BAF@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <B655B6FF-9377-434A-A979-2E758771B0FA@zib.de> <7v3at8rs4b.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 21:40:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.189])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLFD-000307-A7
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 21:40:19 +0100
Received: by ag-out-0910.google.com with SMTP id 32so3347959agc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=QK7+oWBpBs2WXizX5cjblN3h34TLmHcYqnc9opc8dqs=;
        b=3V7pePnCbb3bAMaCXH0HcjFI7A2y+49OhMAUGUqTo9w9R8LJQOdL11tmGs1cCG4gNZimf5MsOKE8f77Wdege1FgnsFl5rK+O8VXvrnIxZFxAOxbXPtEijymaopXWcYCJGoPwj/g3FTBkMNcH89X6RXtyCJbx3XWk/ITLxsC/SUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=nj0xuPuW8mJRapHf0l6v8hvD2txyqgsrko/Mv62j+A2OiYuGdYUwCWaIQgZLlOvryidTwUFaURPBDV3gGqSGfifiFBzrP4wExedvhBey7xC8T872A5yIsI40PWN5ZmpB7k1o8QAJThJ9bSXbUcdgYLQShaF6SltN9ulu2cOk9GY=
Received: by 10.101.69.10 with SMTP id w10mr578290ank.24.1199824789810;
        Tue, 08 Jan 2008 12:39:49 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1331hsm;
	Tue, 08 Jan 2008 12:39:49 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.66.2 with SMTP id o2mr335772waa.18.1199824789094; Tue, 08 Jan 2008 12:39:49 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h49si29185510nzf.5.2008.01.08.12.39.48; Tue, 08 Jan 2008 12:39:49 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m08Kck32004769; Tue, 8 Jan 2008 21:39:46 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m08KcjLM016350 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 8 Jan 2008 21:38:45 +0100 (MET)
In-Reply-To: <7v3at8rs4b.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69915>



On Jan 8, 2008, at 9:15 PM, Junio C Hamano wrote:

>
> Steffen Prohaska <prohaska-wjoc1KHpMeg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
>
>> On Jan 8, 2008, at 8:47 PM, Junio C Hamano wrote:
>>>
>>> "J. Bruce Fields" <bfields- 
>>> uC3wQj2KruNg9hUCZPvPmw-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
>>>
>>>> My only suggestion is that we consider allowing the user that
>>>> "explicitly told git to do so" be the project maintainer.  So if  
>>>> you
>>>>
>>>> 	echo * autodetectcrlf >.gitattributes
>>>> 	git add .gitattributes
>>>> 	git commit
>>>>
>>>> then users that clone your repo will get that default without
>>>> having to
>>>> be told to do something magic on clone.
>>>>
>>>> (And ideally I'd've hoped you could do that using the existing crlf
>>>> attribute rather than having to invent something new, but maybe  
>>>> that
>>>> doesn't work.)
>>>
>>> I think the project can mark text files as text with attributes
>>> and if the port to the platform initialized core.autocrlf
>>> appropriately for the platform everything should work as you
>>> described.
>>>
>>> At least that is how I read the description of `crlf` in
>>> gitattributes(5).
>>
>>
>> But we do not want to mark a file as text but tell git to run its
>> auto-detection and use the local default line endings.
>
> My reading of the description of `crlf` in gitattributes(5) is:
>
>     `crlf`
>     ^^^^^^
>
>     This attribute controls the line-ending convention.
>
>     Set::
>
>             Setting the `crlf` attribute on a path is meant to mark
>             the path as a "text" file.  'core.autocrlf' conversion
>             takes place without guessing the content type by
>             inspection.
>
>
> Notice "without guessing".

Exactly this is the problem.  Some projects want guessing.  A
project needs to have a way to explicitly tell git that is should
guess the file type and if it found "text", then it should use
the right line endings (that is the locally preferred endings).
If the project has control, the project maintainer is responsible
for making the right choice.  That is either he enables automatic
detection of "text" files, or he can explicitly tell git about
the types without guessing.

A different project may not want to have guessing at all, but
leave all files as is.  I believe this should be the default for
all projects that do not explicitly choose otherwise.  I'm still
reluctant to enabling guessing as a system wide default.  Someone
may just want to use git to manage a few binary files locally on
his machine.  I'd be unhappy if "guessing" corrupted these files.

The project needs control if guessing is activated or not.  Right
now we have no way for a project to tell git that it should
guess, even if the default for other projects is not to guess.

	Steffen
