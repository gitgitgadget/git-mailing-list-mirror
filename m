From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 18:16:06 +0530
Message-ID: <CAH-tXsAMJXNs7fM=9msiZT+F_s_06o526kPXLLcQzABBePHxwQ@mail.gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
 <20120330052631.GB11648@sigill.intra.peff.net> <201203301305.23567.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 14:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDbEE-0004xE-19
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 14:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933557Ab2C3Mqu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 08:46:50 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48462 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933448Ab2C3Mqs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 08:46:48 -0400
Received: by wibhr17 with SMTP id hr17so654066wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j5JKPc+FUlT+ADrf9ap+ahB7161/D3UKCQIbANrWdGM=;
        b=iLjSUmCpYzwGb/PjnIYX1/iOw8yea0Xp3BFLnGu7VTjBZeXPiGhNYnV/tQBk5ODA1j
         w4X7z2XIgS/VS2Oa4vnPtE5Q2n+wii9t9c72gYxDvIY6jyrkgvrK8JYxQVO0q7h8zCQ7
         QhA6QlIQmcrHb4rua1t3juI/foQalH7kK3DAZLhxMWMaQPpeVGQIGJaKpQ/SVA9dLXNr
         TQtPN3zNxus+wL/QDpzyj9sx0f/rdJ1yOFfEAkp11lR2m6ru0rNqGg7I/bjPDMfBOcOZ
         wfMEk7qdQFvX3sjA0YJw63iQmjrLsaBb2S1NlQ0Vv7pst8bBoyTQITmutj4Sq8xqio6h
         DaKg==
Received: by 10.180.92.130 with SMTP id cm2mr6233540wib.4.1333111607291; Fri,
 30 Mar 2012 05:46:47 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Fri, 30 Mar 2012 05:46:06 -0700 (PDT)
In-Reply-To: <201203301305.23567.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194354>

>> > =C2=A0 =C2=A0 1. Where can I find general instructions on "Contrib=
uting to git? "
>> > more specifically, gitweb?
>>
>> Documentation/SubmittingPatches in the git.git repository.

Generally informative, thank you.

> For GSoC we prefer if you had a public git repository with your stuff
> (GitHub, repo.or.cz or wherever), and that patches were Cc-ed to ment=
or.

I just started some experiments with code. I branched 'gsoc'  from
'next' and pushed to github. From the docs I understand that I should
have branched from master. What should I be doing now?
[github clone](https://github.com/jaseemabid/git/tree/gsoc)


>> > =C2=A0 =C2=A0 2. Where can I find coding standards for git? I am l=
ooking for the
>> > git version of this document.
>>
>> Documentation/CodingGuidelines
>
> There are no special rules for JavaScript (and neither for that matte=
r
> for Perl), but:

Parts of my mail are not quoted so I'm mentioning some points again.

Since we don't have a strict coding guidelines for JavaScript till
now, and since we are thinking of an almost rewrite, I would suggest
that we can follow guidelines from the Jquery project.
[http://docs.jquery.com/JQuery_Core_Style_Guidelines]. Since this is
the library we are going to use mostly, I think this will be a good
choice, considering we might write few plugins ourselves for the
project.

[Tips from Douglas
Crockford](http://javascript.crockford.com/code.html ) are very
important in the context of JavaScript. Following this will make it
pass [JSLint](http://www.jslint.com/) which is a good measure for
JavaScript code quality. Will try to make sure that every piece of
JavaScript I write pass JSLint (which is not very easy). I think it is
like the POSIX example from Documentation/CodingGuidelines for C :P

I have tried to follow these till date and wont be hard to continue
doing it for gitweb.

> For JavaScript this includes using subset of JSDoc in comments.

[JSDoc]((http://code.google.com/p/jsdoc-toolkit/)) tool kit seems like
a very good choice.

>> > =C2=A0 =C2=A0 3. Is JavaScript code unit tested? I cant find much =
docs regarding
>> > this anywhere.

> The problem with automated testing of JavaScript is integrating it wi=
th
> our testsuite, which is run from command line and outputs TAP (Test
> Anything Protocol), so it can e.g. be run by 'prove'.

This is what I proposed originally,

		I have shortlisted the following for JavaScript unit testing in
priority order.
		[JSDev by Douglas
Crockford](https://github.com/douglascrockford/JSDev) for its
simplicity and elegance.
		[Jasmine](http://pivotal.github.com/jasmine/) for its power.
		[Sinon.js](http://sinonjs.org/)	- overall goodness.

After reading through the mail and the TAP requirement, I would love
to recommend JSDev and [node.js](http://nodejs.org/) for this task. I
think it can be integrated with TAP well afaik. I need to learn more
about TA. I wont be able to confirm something without knowing much
about it now. I know that we should not be adding more requirements to
git project, but node.js seems trivial for testing JavaScript in a
terminal. Since not many will be developing JavaScript for gitweb, I
dont think its a bad idea.

> But even if the JavaScript tests would have to be run in browser

Not necessarily.


--=20
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
