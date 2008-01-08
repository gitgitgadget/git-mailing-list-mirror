From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 21:02:07 +0100
Message-ID: <B655B6FF-9377-434A-A979-2E758771B0FA@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 21:02:41 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKei-0006nR-9Z
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 21:02:36 +0100
Received: by ug-out-1516.google.com with SMTP id 1so1324466uga.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 12:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=BlBJJeb6CisG0vsLCsRJvsW4R+9fV5E38qqPAdcW9iA=;
        b=wtZQ+PCLo2Of3T5xVjzadPVePZRB3JcTOtgbnoHW/EnWIYw1Bm2bC2jySKGDKQGTMnr+/jIn3XkLpb9gM8TWVEXnWGeQsymPfqYgCz4JCXS5rhhQgb+CAxlDtzFu9zJPKmu7CzsBczxPk7rpzpuL0BUs4V3Y/LrS4jo6FexQ8fY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=anQGW3HGjHE8r6PZ4f4V83wpRlTXEpZK7celOqufVBciahPzIuaNA59tb28ZNmPw/ursw38R0uG84U0FpHsV5V3Y4RolRcJmIQtU8ATx0cw3t7dsNHddS2Rn2FTorcZksVj777o7sF02GEUlN6wDwtpWgd25LwKFyQ6g44KIZCw=
Received: by 10.82.175.17 with SMTP id x17mr43537bue.26.1199822529884;
        Tue, 08 Jan 2008 12:02:09 -0800 (PST)
Received: by 10.44.219.52 with SMTP id r52gr1327hsg;
	Tue, 08 Jan 2008 12:02:09 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.132.13 with SMTP id j13mr48171415qbn.2.1199822529451; Tue, 08 Jan 2008 12:02:09 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h49si29147392nzf.5.2008.01.08.12.02.08; Tue, 08 Jan 2008 12:02:09 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m08K11gT000458; Tue, 8 Jan 2008 21:02:01 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m08K11Bf005873 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 8 Jan 2008 21:01:01 +0100 (MET)
In-Reply-To: <7vir24rtfp.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69909>



On Jan 8, 2008, at 8:47 PM, Junio C Hamano wrote:

>
> "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org> writes:
>
>> On Tue, Jan 08, 2008 at 07:58:57PM +0100, Steffen Prohaska wrote:
>>> ...
>>> I don't think a solution will be found by declaring one platform
>>> native (UNIX) and all other platform non-native.  The question to
>>> answer is how to support cross-platform projects.  A valid
>>> solution should never corrupt data unless the user explicitly
>>> told git to do so.
>>
>> My only suggestion is that we consider allowing the user that
>> "explicitly told git to do so" be the project maintainer.  So if you
>>
>> 	echo * autodetectcrlf >.gitattributes
>> 	git add .gitattributes
>> 	git commit
>>
>> then users that clone your repo will get that default without  
>> having to
>> be told to do something magic on clone.
>>
>> (And ideally I'd've hoped you could do that using the existing crlf
>> attribute rather than having to invent something new, but maybe that
>> doesn't work.)
>
> I think the project can mark text files as text with attributes
> and if the port to the platform initialized core.autocrlf
> appropriately for the platform everything should work as you
> described.
>
> At least that is how I read the description of `crlf` in
> gitattributes(5).


But we do not want to mark a file as text but tell git to run its
auto-detection and use the local default line endings.  But for
different projects we do not even want to run the auto-detection,
but leave the files as is.

See my separate mail that I just sent before I read yours.

	Steffen
