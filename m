From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Fri, 15 May 2009 14:31:54 -0400
Message-ID: <32541b130905151131h76048ff2o418764aa41bcd13b@mail.gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com> 
	<32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com> 
	<7vzldes0ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52Cm-0005ZK-Sr
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbZEOScO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbZEOScO
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:32:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:23131 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZEOScN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 14:32:13 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1193577yxj.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E/wqfwIkunlRpkXAvSShLioBsr4XZtR2ETbk2Xsn/lU=;
        b=p2eH8+DpfZXPRzxsHtTif9AuEu9r13dWJCCwWNM9822ay9mZWJhEyrBubI52Ayo5rz
         S1cu761nZuLjivFS8AhqwgQSy3PjORkj72lasoyE5ffF2+e2GxqAcsF07OqInR0zz8v9
         WC+LKfBy+2Krp7oE67H4pnTPu1zeF5NiAtDW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZAmWWz4pXO2St0Ne33FBtfGxPC9l9BZHWDnWT8+6wCaxz0NUg/6oyb5yU51y7+dPBC
         PPskIKQVsNerJYtKrxKtTJCIBWE3rAdXXE9XHDz6paLh6oVphayFXChGl3+khd9EG4gf
         WqDkTb2VguIudH14T0dUG5wvDzdlcXf62HVLs=
Received: by 10.151.139.1 with SMTP id r1mr6665725ybn.184.1242412334219; Fri, 
	15 May 2009 11:32:14 -0700 (PDT)
In-Reply-To: <7vzldes0ce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119275>

On Fri, May 15, 2009 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> ... =A0Obviously I would need to write a man page, but I've been
>> hesitant to do that in case people have suggestions that need the
>> whole UI to change. =A0Perhaps that's a chicken-and-egg problem, tho=
ugh,...
>
> If you fear that you might get into a situation that the UI _must_ ch=
ange
> because it does not fit people's needs or workflows, that is a sign t=
hat
> the UI and the workflow it was designed to support may not have been =
well
> thought out yet. =A0At least, you do not even _know_ if it is well th=
ought
> out or not. =A0It is understandable that people would say "sounds coo=
l,
> could potentially be good, but I'll wait and see if it is real" and l=
eave.

Well, I'm already using it myself in my own projects and I like it.
So I'm pretty confident that it is *a* useful workflow.  Whether it's
useful for others is a good question, and the only way to know the
answer is to put it out there.

But I'm at a bit of a loss as to why so many people (er, as compared
to none) seem to have gotten excited about the tool, but then it
fizzled.  This implies to me that something is missing.  Perhaps it's
just the documentation; I'll work on that next, then.

> It is an easy mistake to make to consider inclusion to my tree your g=
oal.
> It can be one of the means to give exposure to wider audience, but it=
 does
> not have to be your only avenue to do so.

Thanks for pointing that out.  In fact my primary goal wasn't really
to get it included in the tree (otherwise I *would* have written the
documentation and even included a signed-off-by line :)) but to get
comments on the feature.  In fact, it would be detrimental to have it
included in your tree and then find out afterwards that it ought to be
ripped out and replaced.

> With proliferation of free hosting services, however, I think contrib=
/
> area for such purposes outlived its usefulness. =A0People can now for=
k and
> gather interested and enthused users very easily and can make *me* be=
g to
> merge from them to include their new, popular, and already polished
> features.

I suppose you could merge it in using git-subtree and then you
wouldn't even have to beg :)

Okay, documentation next.  At least I have somewhere to go from here.

Have fun,

Avery
