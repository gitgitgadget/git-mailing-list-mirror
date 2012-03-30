From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Sat, 31 Mar 2012 00:37:59 +0100
Message-ID: <201203310137.59657.jnareb@gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com> <201203301305.23567.jnareb@gmail.com> <CAH-tXsAMJXNs7fM=9msiZT+F_s_06o526kPXLLcQzABBePHxwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:38:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDlOU-0005Ys-0P
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 01:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab2C3XiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 19:38:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50907 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2C3XiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 19:38:00 -0400
Received: by wejx9 with SMTP id x9so657863wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=nb/MHhMm399v3jIRRpHTKw3K3zHfNQRsKKTuW/R3rDw=;
        b=LuU2TXSrC+VMywa0wRsVCW9nTgBmKIY0WrATI5mWZfrOS5LHKhAZCoOizYwwG+b3X8
         gsFKyozxzcPBHP8w1ARCjYN6b+ER2IzwDkOUFdBM8r/NL1hO1OeX2A7cDSBKWz+lnsij
         2DpBvXrK3vUzWC1wV56d4i05y9peq1JYdfadrQZGXFzXi8Jm/bQeL12OJ4aQS2AyKV4M
         nhiOxJkqYHMNAcxMKdOjd6+VF1/Jjb4bokI6S0dxdlurlxugdCmTQf4QFZEWzINsW87F
         RWwcoYYccdApaL5Xsa+IjPBv8lRve+DtkNAwK2I6uYW0adsqLaLoYmCTcGCqsAmkCHw/
         Rayg==
Received: by 10.180.73.143 with SMTP id l15mr1033517wiv.11.1333150678633;
        Fri, 30 Mar 2012 16:37:58 -0700 (PDT)
Received: from [192.168.1.13] (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id fl2sm16797830wib.4.2012.03.30.16.37.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 16:37:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAH-tXsAMJXNs7fM=9msiZT+F_s_06o526kPXLLcQzABBePHxwQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194425>

On Fri, 30 Mar 2012, jaseem abid wrote:

>>>> =C2=A0 =C2=A0 1. Where can I find general instructions on "Contrib=
uting to git? "
>>>> more specifically, gitweb?
>>>
>>> Documentation/SubmittingPatches in the git.git repository.
[...]
>> For GSoC we prefer if you had a public git repository with your stuf=
f
>> (GitHub, repo.or.cz or wherever), and that patches were Cc-ed to men=
tor.
>=20
> I just started some experiments with code. I branched 'gsoc'  from
> 'next' and pushed to github. From the docs I understand that I should
> have branched from master. What should I be doing now?
> [github clone](https://github.com/jaseemabid/git/tree/gsoc)
=20
As GSoC project wouldn't start until May 21, you can either re-create
'gsoc' branch or rebase it on top of 'master', then force push to GitHu=
b.
=20
Note however that it is not given that "Use JavaScript library / framew=
ork
in gitweb" would be one of accepted topics in general, and that your
application will be accepted in particular.

>>>> =C2=A0 =C2=A0 2. Where can I find coding standards for git? I am l=
ooking for the
>>>> git version of this document.
>>>
>>> Documentation/CodingGuidelines
>>
>> There are no special rules for JavaScript (and neither for that matt=
er
>> for Perl), but:
>=20
> Parts of my mail are not quoted so I'm mentioning some points again.
>=20
> Since we don't have a strict coding guidelines for JavaScript till
> now, and since we are thinking of an almost rewrite, I would suggest
> that we can follow guidelines from the Jquery project.
> [http://docs.jquery.com/JQuery_Core_Style_Guidelines]. Since this is
> the library we are going to use mostly, I think this will be a good
> choice, considering we might write few plugins ourselves for the
> project.

Iam not sure if we would be writing jQuery plugins at all, as opposed
to simply using jQuery.  When writing jQuery plugins we should follow
jQuery Style Guidelines you linked, but for main gitweb.js code...
=2E..I am not sure if following Documentation/CodingGuidelines for C
also in JavaScript wouldn't be a better idea (style consistency),
especially that such style is used already -- no code churn changing
style.

In particular:

* "Be sure to use liberal spacing in your code." =20

  I'd rather use liberal but not too liberal spacing:

   if (blah =3D=3D=3D "foo") {
     foo("bar", "baz", {zoo: 1});
   }

* "if/else/for/while/try always have braces and always go on
  multiple lines"
=20
  We don't use braces (blocks) for single-line "if" statements, as
  stated in Documentation/CodingGuidelines: "We avoid using braces
  unnecessarily."  In this case I think that jQuery style might be
  better for JavaScript (less fragile).

* "Always include extra spaces around the arguments."

  I'd rather not.

* "All RegExp operations should be done using .test() and .exec().
  "string".match() is no longer used."

  Perhaps in new code.  I'd rather avoid rewriting existing code
  unnecessarily.  I wonder what is reasoning behind this rule.

> [Tips from Douglas
> Crockford](http://javascript.crockford.com/code.html ) are very
> important in the context of JavaScript.

Please remember that those are best practices, and a some of them
are rather matter of taste, for example using spaces to indent,
and not tabs (tabs to indent, spaces to align... or assume 8 spaces
tabs).

> Following this will make it=20
> pass [JSLint](http://www.jslint.com/) which is a good measure for
> JavaScript code quality. Will try to make sure that every piece of
> JavaScript I write pass JSLint (which is not very easy). I think it i=
s
> like the POSIX example from Documentation/CodingGuidelines for C :P
>=20
> I have tried to follow these till date and won't be hard to continue
> doing it for gitweb.

Well, maybe relaxed JSLint; some of checks are "best practice" checks.
I wouldn't expect C code part of git pass lint / splint, nor Perl
parts Perl::Critic, at least not with most strict checking mode.

>> For JavaScript this includes using subset of JSDoc in comments.
>=20
> [JSDoc]((http://code.google.com/p/jsdoc-toolkit/)) tool kit seems lik=
e
> a very good choice.

At least there seems to be some common format for structured comments,
as opposed to C (Doxygen, DOC++, ROBODoc,...).

Not that we use jsdoc-toolkit to actually generate automatic API
description; such documentation is is not that helpful anyway.

>>>> =C2=A0 =C2=A0 3. Is JavaScript code unit tested? I cant find much =
docs regarding
>>>> this anywhere.
>=20
>> The problem with automated testing of JavaScript is integrating it w=
ith
>> our testsuite, which is run from command line and outputs TAP (Test
>> Anything Protocol), so it can e.g. be run by 'prove'.
>=20
> This is what I proposed originally,
>=20
> 		I have shortlisted the following for JavaScript unit testing in
> priority order.
> 		[JSDev by Douglas
> Crockford](https://github.com/douglascrockford/JSDev) for its
> simplicity and elegance.

This is not unit testing framework.  It is not even testing framework.
It is a bloody source filter (think #ifndef NDEBUG ... #endif on acid).

Please correct me if I am wrong.

> 		[Jasmine](http://pivotal.github.com/jasmine/) for its power.

This is behavior-driven development framework for testing JavaScript co=
de,
though it looks to be geared towards BDD development method.

Standalone it doesn't provide running from command line, though Node.js
or equivalent (like jsTestDriver) might help there.  It is to be run in
web browser.

> 		[Sinon.js](http://sinonjs.org/)	- overall goodness.

Hmmm... from description it looks like it is something (stubs and mocks=
)
that you use in addition to unit testing framework like QUnit, not
a testing framework by itself.

>=20
> After reading through the mail and the TAP requirement, I would love
> to recommend JSDev and [node.js](http://nodejs.org/) for this task. I
> think it can be integrated with TAP well afaik. I need to learn more
> about TAP. I wont be able to confirm something without knowing much
> about it now. I know that we should not be adding more requirements t=
o
> git project, but node.js seems trivial for testing JavaScript in a
> terminal. Since not many will be developing JavaScript for gitweb, I
> dont think its a bad idea.
>=20
>> But even if the JavaScript tests would have to be run in browser
>=20
> Not necessarily.

Test.Simple and Test.More (http://search.cpan.org/dist/JS-Test-Simple/)
both output TAP (they are port of Perl's Test::Simple and Test::More);
part of JS::Test::Simple.

Node.js requires V8 JavaScript engine from Google; if we have that, we
can as well use e.g. JavaScript::V8x::TestMoreish[2] from CPAN.

Other solutions include using Test::JavaScript (uses SpiderMonkey
JavaScript engine), or Selenium.

[2] http://search.cpan.org/perldoc?JavaScript::V8x::TestMoreish
--=20
Jakub Narebski
Poland
