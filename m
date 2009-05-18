From: Ping Yin <pkufranky@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Mon, 18 May 2009 23:55:06 +0800
Message-ID: <46dff0320905180855m3e1bd74esb564af0fbcf4b1ff@mail.gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
	 <32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
	 <7vzldes0ce.fsf@alter.siamese.dyndns.org>
	 <32541b130905151131h76048ff2o418764aa41bcd13b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65BM-0001Wy-Sr
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZERPzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 11:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZERPzH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:55:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:28622 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZERPzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 11:55:05 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2023379ywb.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VoJrTFp1T0wSoXczFnzRlTXcjpPwfx3nS/hRvn99VTg=;
        b=javTFunWpoEce5P8+pqGgNAWDLxApZ3Vwrq/hGTZg6m2bSjwS/u+qAFPL/MbPeJnf6
         TZGopkkfZLpTsQUEx/um+edk8yqHPzcUtT4pG+w8VsKySroZkP17/Fw2tsM/q9n+kdRT
         F4SfsZ/Et/0HGntqiNEIbPLsbW1zz4BiSX0LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o0rlcJnN1ASkzn3ary3SNAODSDZTxL6EIrRbNnskWCh6c5vMQ7eL4ZETBLdFo38pQp
         dLmZJA/+nL+5B+KRLAYP5/JSWRROvcSLpB1WZJOaKtnE5Inf2+uPmY4sURnj76sqJq7Y
         J7FZEjYgaDIcc2m5q2YIqstz7MSI9rNsUsIr4=
Received: by 10.100.10.15 with SMTP id 15mr9013754anj.8.1242662106475; Mon, 18 
	May 2009 08:55:06 -0700 (PDT)
In-Reply-To: <32541b130905151131h76048ff2o418764aa41bcd13b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119451>

On Sat, May 16, 2009 at 2:31 AM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Fri, May 15, 2009 at 2:11 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Avery Pennarun <apenwarr@gmail.com> writes:
>>> ... =C2=A0Obviously I would need to write a man page, but I've been
>>> hesitant to do that in case people have suggestions that need the
>>> whole UI to change. =C2=A0Perhaps that's a chicken-and-egg problem,=
 though,...
>>
>> If you fear that you might get into a situation that the UI _must_ c=
hange
>> because it does not fit people's needs or workflows, that is a sign =
that
>> the UI and the workflow it was designed to support may not have been=
 well
>> thought out yet. =C2=A0At least, you do not even _know_ if it is wel=
l thought
>> out or not. =C2=A0It is understandable that people would say "sounds=
 cool,
>> could potentially be good, but I'll wait and see if it is real" and =
leave.
>
> Well, I'm already using it myself in my own projects and I like it.
> So I'm pretty confident that it is *a* useful workflow. =C2=A0Whether=
 it's
> useful for others is a good question, and the only way to know the
> answer is to put it out there.
>
> But I'm at a bit of a loss as to why so many people (er, as compared
> to none) seem to have gotten excited about the tool, but then it
> fizzled. =C2=A0This implies to me that something is missing. =C2=A0Pe=
rhaps it's
> just the documentation; I'll work on that next, then.
>

It's really a cool feature, but i havn't tried it. Why?

It will spends me some time saving and applying the patches and then
testing it (i don't have the appropriate environment setuped). But I
am busy and there is no urgent need to use this feature ( it is only a
rare case for me).  So i will wait until i need the feature or there
is an easy to fetch the code ( pu of official reposotory or other
repository with these patches applied).

I don't whether this is a common reason, but at least it is the reason =
for me.
