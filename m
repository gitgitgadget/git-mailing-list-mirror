From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 12:15:32 -0800
Message-ID: <7v3at8rs4b.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <B655B6FF-9377-434A-A979-2E758771B0FA@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 21:16:14 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from nz-out-0708.google.com ([64.233.162.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKrt-0002xS-T7
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 21:16:14 +0100
Received: by nz-out-0708.google.com with SMTP id h28so12862124nzf.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=7kSMIg/Ilr2QA9X2/ZaLnBiis95m2q+rz1pCcsuZUyQ=;
        b=HdXu3DchvJE+dZrek8YkZCtmth8E3sfppkNfnKsDsKQi7bRgmTUmPcAwGi8dG6hCd8Uamn/PxD8vtrXaopjuvI+PEVm4h1W4EZCxF+Zr47LYNwA/5/KebS1qy3jrza+su687+65spvuUsetlGCRV5NDp+8UhZdOLiYKkeujrix8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=GcHAxRi8KKEGY63E8W4LAai1GfvoWVJDR+vkAzuslDHwoTYnvi3+AkhgEneDmxpyckvUVPzle/F88I1hZ9AMEbJSFg1e1ERkRUXBjFNlneShtoowmNs4p52qIJgm73Q6LIBt3d6qtuGf6vT8aA0+5OC1ZL8pSRjojlpOl41o2s0=
Received: by 10.150.124.2 with SMTP id w2mr459590ybc.12.1199823346618;
        Tue, 08 Jan 2008 12:15:46 -0800 (PST)
Received: by 10.44.24.32 with SMTP id 32gr1329hsx;
	Tue, 08 Jan 2008 12:15:46 -0800 (PST)
X-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.237.15 with SMTP id o15mr48299650qbr.3.1199823346239; Tue, 08 Jan 2008 12:15:46 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com [208.72.237.25]) by mx.google.com with ESMTP id y6si29190411nzg.1.2008.01.08.12.15.45; Tue, 08 Jan 2008 12:15:46 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) smtp.mail=gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
Received: from a-sasl-quonix (localhost [127.0.0.1]) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 75AE8C4F3; Tue,  8 Jan 2008 15:15:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 91384C4E0; Tue,  8 Jan 2008 15:15:36 -0500 (EST)
In-Reply-To: <B655B6FF-9377-434A-A979-2E758771B0FA-wjoc1KHpMeg@public.gmane.org> (Steffen Prohaska's message of "Tue, 8 Jan 2008 21:02:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69912>


Steffen Prohaska <prohaska-wjoc1KHpMeg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:

> On Jan 8, 2008, at 8:47 PM, Junio C Hamano wrote:
>>
>> "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
>>
>>> My only suggestion is that we consider allowing the user that
>>> "explicitly told git to do so" be the project maintainer.  So if you
>>>
>>> 	echo * autodetectcrlf >.gitattributes
>>> 	git add .gitattributes
>>> 	git commit
>>>
>>> then users that clone your repo will get that default without
>>> having to
>>> be told to do something magic on clone.
>>>
>>> (And ideally I'd've hoped you could do that using the existing crlf
>>> attribute rather than having to invent something new, but maybe that
>>> doesn't work.)
>>
>> I think the project can mark text files as text with attributes
>> and if the port to the platform initialized core.autocrlf
>> appropriately for the platform everything should work as you
>> described.
>>
>> At least that is how I read the description of `crlf` in
>> gitattributes(5).
>
>
> But we do not want to mark a file as text but tell git to run its
> auto-detection and use the local default line endings.

My reading of the description of `crlf` in gitattributes(5) is:

    `crlf`
    ^^^^^^

    This attribute controls the line-ending convention.

    Set::

            Setting the `crlf` attribute on a path is meant to mark
            the path as a "text" file.  'core.autocrlf' conversion
            takes place without guessing the content type by
            inspection.


Notice "without guessing".
