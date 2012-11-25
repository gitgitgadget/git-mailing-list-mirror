From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 11:44:20 +0100
Message-ID: <50B1F684.5020805@alum.mit.edu>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 11:44:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZhc-0004SP-1k
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab2KYKoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:44:25 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63828 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab2KYKoY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 05:44:24 -0500
X-AuditID: 1207440d-b7f236d000000943-c8-50b1f687a8fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FB.DF.02371.786F1B05; Sun, 25 Nov 2012 05:44:23 -0500 (EST)
Received: from [192.168.69.140] (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPAiKR4001815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 05:44:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqNv+bWOAwcPVnBZXt/hYHHycZ9F1
	pZvJgdlj56y77B7LvnayeHzeJBfAHMVtk5RYUhacmZ6nb5fAnbH99mPmgjabin9t7xkbGH/p
	dzFycEgImEisbeHrYuQEMsUkLtxbz9bFyMUhJHCZUaLj4FsWCOc0k8Ttm3vYQap4BbQlHtyY
	DmazCKhK7Dj6ggnEZhPQlVjU0wxmiwqESazZc4gJol5Q4uTMJywgtoiAocTe9qlgNrOAjcSz
	9gYwW1jAU+LBgX5mEFtIoE7ixt8LrCA2p0CgxLzDR1lBDmUWUJdYP08IolVeYvvbOcwTGAVm
	IdkwC6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCgpZ3B+P/
	dTKHGAU4GJV4eG8lbgwQYk0sK67MPcQoycGkJMq74QtQiC8pP6UyI7E4I76oNCe1+BCjBAez
	kghv6DOgHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgjfrK1CjYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChK44uBcQqS4gHa2wTSzltckJgLFIVoPcWo
	y7FhffsTRiGWvPy8VClx3jiQIgGQoozSPLgVsBT1ilEc6GNh3iCQKh5geoOb9ApoCRPQkuTr
	YEtKEhFSUg2MM5+nC16c3n28eZlezOZwR611G+R+Se7sv1D4sPlXkE9N2NWs778jPHJPcxz6
	3nlztWzW1rqr26QehVkdMv+WVb65qUbB+HL9rtOhU9c6X6p+sKdigknLJJ/LNw2a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210353>

On 11/25/2012 09:53 AM, Felipe Contreras wrote:
> On Sun, Nov 25, 2012 at 3:44 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
>> 1) In 2012, we can specify a "floor" Python version of 2.6 (shipped in
>> 2008) and be pretty much guaranteed it will be anywhere we want to
>> deploy except Windows.  Windows will remain a problem because Python
>> isn't part of the stock install, but that's an equal or worse problem
>> for shell and Perl - and at least the Python project ships a binary
>> installer for Windows.
> 
> What if my extension only supports python 2.7? Or what if my extension
> wants to support 2.0?

There would obviously have to be a policy like "all Python code in core
git must run on any Python interpreter with 2.6 <= version < 3.0", just
as there are policies about what C and shell features are allowed.  If
you happen to want to support earlier versions of Python, I don't see
why anybody would stop you as long as your code also runs in the
mandated versions.

(In practice, backwards compatibility within Python versions 2.x is very
good and almost any code that runs in Python 2.6 would automatically run
in all later 2.x versions.  Moreover, the Python documentation covering
what is available in each version and the deltas between versions is
high-quality and easily available online.)

There is, of course, the awkward issue of how/when to transition to
Python 3.x, which is *not* backwards compatible with Python 2.x.  I
expect that when the time comes there will be volunteers (myself
included) willing to help adapt Python scripts to the new version, but
the problem shouldn't be minimized.

Of course Perl will have the same problem if Perl6 ever materializes.

>> 2) Python extension commands should test the Python version on startup
>> and die loudly but gracefully in the rare case that they don't find
>> what they need.
> 
> Yes, they should _if_ they know what version they need. In my
> extensions I really have no idea.

Then simply (with the help of the mailing list) ensure that your
extensions run under 2.6 (or whatever the chosen minimum version is) and
everything will be OK.  It is not an error to specify 2.6 as the minimum
version even though your script happens also to run on older versions :-)

>> 3) We should be unconditionally be encouraging extensions to move
>> from shell and Perl to Python.  This would be a clear net gain is
>> portability and maintainability.
> 
> NO! It's up to the developer to choose what language to use, and I
> find it very chauvinist of you to say "python is better, so let's all
> use python". So far you have listed a few advantages of python, but
> you haven't explained so far what is wrong with shell and perl.

Given that some languages are accepted in git-core and others are not,
it's already not "up to the developer to choose what language to use".
At best there is a short list of "blessed" languages, and the developer
can choose among only those.

> In fact, while advancing python you have made clear a problem with
> python; the version requirements. So far I have *never* encountered a
> problem with git because of my bash version, or my perl version. And
> we haven't touched to the python3 mess yet. To me, those are
> advantages of shell and perl.

On the contrary, there is *constant* traffic on the mailing list about
incompatibilities between different shell implementations (sh, dash,
bash, etc), not to mention those in other utilities (sed, grep, etc)
that one is forced to work with in shell scripts.  Compatibility is a
*huge* pain when developing shell code for git.  The fact that users
typically don't encounter such problems is due to the hard work of POSIX
lawyers on the mailing list correcting the compatibility errors of
mortal programmers.

> Actually, I don't care if 'git foo' is written in perl, or shell, or
> c; as long as it *works*. And I would hate it if 'git rebase' ever
> told me that I need a newer version of python, or worst; that I don't
> have python in my system (Arch Linux ships 'python2', not 'python').

The configure script would locate the correct interpreter and the build
would adjust the scripts' shebang lines, just as things are tweaked
within Perl scripts at build time.

>> 4) We should be encouraging C code to move to Python, too.  There's
>> little gain in portability on this path because modern C has cleaned
>> up its act a lot, but the drop in expected bug loads would be well
>> worth the porting effort.  Segfaults are not your friend, and the x2 to
>> x5 drop in line count would do very good things for long-term
>> maintainability.
> 
> Definitely NO! I really really doubt git in python would be able to
> achieve the same performance as git in c, but to show me wrong, it
> wouldn't be very difficult to run a few measurements with python
> dulwich *if* we are even to begin considering this point.
> 
> And are segmentation faults really that different from python's
> exceptions? Not to the user.

There is one huge difference: it C it is all too easy to write code that
leads to a security hole due to buffer overflows and other memory
management errors.  Code written in a scripting language are largely
immune to such problems (except of course for any such bugs in the
interpreter itself, but the testing of the interpreter is shared across
many projects and users).

It would be insane to rewrite performance-critical C code in any
scripting language, but there is a huge penumbra of code that is not
performance critical and that mutates rapidly.  Such code is much easier
to write and maintain in a sane scripting language if the portability
issues can be mastered.

The most important issues to consider when imagining a future with a
hybrid of code in C and some scripting language "X" are:

* Portability: is "X" available on all platforms targeted by git, in
  usable and mutually-compatible versions?

* Startup time: Is the time to start the "X" interpreter prohibitive?
  (On my computer, "python -c pass", which starts the Python
  interpreter and does nothing, takes about 24ms.)  This overhead would
  be incurred by every command that is not pure C.

* Should the scripting language access the C functionality only by
  calling pure-C executables or by dynamically or statically linking to
  a binary module interface?  If the former, then the granularity of
  interactions between "X" and C is necessarily coarse, and "X" cannot
  be used to implement anything but the outermost layer of
  functionality.  If the latter, then the way would be clear to
  implement much more of git in "X" (and lua would also be worth
  considering).

* Learning curve for developers: how difficult is it for a typical git
  developer to become conversant with "X", considering both (1) how
  likely is it that the typical git developer already knows "X" and
  (2) how straightforward and predictable is the language "X"?
  In this category I think that Python has a huge advantage over
  Perl, though certainly opinions will differ and Ruby would also be
  a contender.

Personally, I regret wasting my time programming pointer arithmetic in
git modules that are not performance-critical (and correcting bugs by
others in these areas).  And I'm tired of having an idea to improve a
git feature only to find that it is implemented in shell, where not even
arrays are available.  I would therefore welcome more friendliness
towards a decent scripting language in the git project.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
