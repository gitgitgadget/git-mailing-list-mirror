From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Tue, 13 Dec 2011 07:16:21 +0100
Message-ID: <op.v6ezpjj90aolir@keputer>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
 <m3zkf1hnh9.fsf@localhost.localdomain>
 <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
 <201112102030.15504.jnareb@gmail.com>
 <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com>
 <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com>
 <4EE62DB9.8030406@ira.uka.de> <op.v6edibfz0aolir@keputer>
 <4EE6C31C.60909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Holger Hellmuth" <hellmuth@ira.uka.de>,
	"Andrew Ardill" <andrew.ardill@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	=?utf-8?Q?Sidney_San_Mart=C3=ADn?= <s@sidneysm.com>,
	git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 13 07:16:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaLfE-0005j3-1h
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 07:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab1LMGQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 01:16:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53762 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab1LMGQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 01:16:25 -0500
Received: by eekc4 with SMTP id c4so1951150eek.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 22:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=ns9zi+E33iCL2Mh7A3rAxDqyZo0P5355rDQHoIqbREo=;
        b=IidUjkF9jzLTH/8xl0UkBhTp6BO5IHynMYhPfoOtTHr+kkM9semStz8Ene8ffnwAWT
         txboizHtblH2d6inbg+UmjbGyb1XdpTICLh/7A3T2Lh9a7z/kG8wBTK3eU3HrG6RMmPr
         KOp/p4f2cQdEzh03ekEz9uciqGP1TalgNI1F0=
Received: by 10.14.17.213 with SMTP id j61mr3778512eej.96.1323756984217;
        Mon, 12 Dec 2011 22:16:24 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm85053803eef.9.2011.12.12.22.16.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 22:16:23 -0800 (PST)
In-Reply-To: <4EE6C31C.60909@alum.mit.edu>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187005>

On Tue, 13 Dec 2011 04:14:36 +0100, Michael Haggerty  
<mhagger@alum.mit.edu> wrote:

> On 12/12/2011 11:16 PM, Frans Klaver wrote:
>> Wrapped code as in auto-wrapped? Or as in manually wrapped? Python
>> programmers have significant white space, but you can still hard wrap
>> stuff, as long as the next statement is properly indented.
>
> This is incorrect.  Python statements can only be broken across lines
> within unbalanced parenthesis (or using '\' or within a multiline
> string).  For example,
>
>     x =
>         1
>
> is a syntax error, while
>
>     y = (
>         1
>         )
>
> or
>
>     f(1,
>           2,
>       3,
>       4)
>
> are both valid.

Hm yes, my statement was quite incomplete. What you describe here is what  
I meant, and I should have taken the time to word it down properly. Thanks  
for taking the time to do so.



>
> FWIW I think automatic wrapping of commit messages is a bad idea.  I
> wrap my commit messages deliberately to make them look the way I want
> them to look.  The assumption of an 80-character display has historical
> reasons, but it is also a relatively comfortable line-width to read
> (even on wider displays).  And given that commit messages sometimes
> contain "flowable" paragraph text, sometimes code snippets, sometimes
> ASCII art, etc, no automatic wrapping will work correctly unless
> everybody agrees that commit messages must be written in some specific
> form of markup (or lightweight markup).  And I can't imagine such a
> thing ever happening.
>
> As for "future-proofing", do you really think there will be a lot of
> programming happening on mobile phones with less than 80-character-wide
> displays?  (And even my little HTC can easily fit 80 characters if I
> rotate the phone to "landscape" mode.)

Makes sense.
