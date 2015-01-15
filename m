From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unused #include statements
Date: Thu, 15 Jan 2015 15:20:09 -0800
Message-ID: <xmqqy4p34onq.fsf@gitster.dls.corp.google.com>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
	<CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
	<20150115063307.GA11028@peff.net>
	<xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
	<20150115223836.GC19021@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Robert Schiele <rschiele@gmail.com>,
	Zoltan Klinger <zoltan.klinger@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBtiB-0002bN-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbAOXUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:20:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752147AbbAOXUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:20:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C99D30411;
	Thu, 15 Jan 2015 18:20:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ipfzCSo/HqjZex7bZa8CgcPjgbI=; b=O8CrAC
	wSnbIxBIvegnZK//bbVial8EKEpQy8MxMYYbDTDxb3WBnjqUWFcD1mjz86mobf3R
	LZewlmt9V6RVrkPLBomhn7VvnSdL/kk1dRs2XUwC0ZcrP/d759HX1NhFyIV9ymFp
	dktV22eCFPfh8/Cwg7O9FJZGD90y/mdYbBXIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=phixsP/IHKINTwzEwdmkOL05vDywMe+M
	ef3Vjd3Kn8mW301A159ItP3U7dadXHGVocuJxLsKrma7GB80P2d4FRvf61z/Yrkt
	IDXagCeBVvj6/ucQAw/7Jfx88v7QVGfB/7Cd1teqNlnQR9UgtceDaaLsTF/ApYEJ
	F3k+ixFpenE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 300DA30410;
	Thu, 15 Jan 2015 18:20:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18BEF3040F;
	Thu, 15 Jan 2015 18:20:11 -0500 (EST)
In-Reply-To: <20150115223836.GC19021@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 17:38:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D4B2970-9D0D-11E4-814A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262520>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 15, 2015 at 10:50:45AM -0800, Junio C Hamano wrote:
>>  ...
>> Thoughts?  I am not looking forward to a torrent of patches whose
>> sole purpose is to make the existing C files conform to any such
>> rule, though.  Clean-up patches that trickle in at a low rate is
>> tolerable, but a torrent is too distracting.
>
> I don't think the "optionally" one above is that necessary. Not because
> I don't agree with it, but because I do not know that we want to get
> into the business of laying out every minute detail and implication.
> The CodingGuidelines document is meant to be guidelines, and I do not
> want to see arguments like "well, the guidelines do not explicitly
> _disallow_ this, so you must accept it or add something to the
> guideline". That is a waste of everybody's time.

Totally.  I know we do not want to get into that business.

> A general philosophy + good taste (from the submitter and the
> maintainer) should ideally be enough.

Yes, "ideally" ;-)

> Which isn't to say we shouldn't clarify the document when need be. But I
> think what I quoted at the top already is probably a good improvement
> over what is there.

OK, thanks.  Let's queue something like this for post 2.3 cycle,
then.

-- >8 --
Subject: CodingGuidelines: clarify C #include rules

Even though "advice.h" includes "git-compat-util.h", it is not
sensible to have it as the first #include and indirectly satisify
the "You must give git-compat-util.h a clean environment to set up
feature test macros before including any of the system headers are
included", which is the real requirement.

Because:

 - A command that interacts with the object store, config subsystem,
   the index, or the working tree cannot do anything without using
   what is declared in "cache.h";

 - A built-in command must be declared in "builtin.h", so anything
   in builtin/*.c must include it;

 - These two headers both include "git-compat-util.h" as the first
   thing; and

 - Almost all our *.c files (outside compat/ and borrowed files in
   xdiff/) need some Git-ness from "cache.h" to do something
   Git-ish.

let's explicitly specify that one of these three header files must
be the first thing that is included.

Any of our *.c file should include the header file that directly
declares what it uses, instead of relying on the fact that some *.h
file it includes happens to include another *.h file that declares
the necessary function or type.  Spell it out as another guideline
item.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 894546d..578d07c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -328,9 +328,14 @@ For C programs:
 
  - When you come up with an API, document it.
 
- - The first #include in C files, except in platform specific
-   compat/ implementations, should be git-compat-util.h or another
-   header file that includes it, such as cache.h or builtin.h.
+ - The first #include in C files, except in platform specific compat/
+   implementations, must be either "git-compat-util.h", "cache.h" or
+   "builtin.h".  You do not have to include more than one of these.
+
+ - A C file must directly include the header files that declare the
+   functions and the types it uses, except for the functions and types
+   that are made available to it by including one of the header files
+   it must include by the previous rule.
 
  - If you are planning a new command, consider writing it in shell
    or perl first, so that changes in semantics can be easily
