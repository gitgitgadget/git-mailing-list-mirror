From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Suggestions for "What's cooking"
Date: Fri, 14 Sep 2012 12:11:49 +1000
Message-ID: <CAH5451n3bAkidWrtu4sy=NXPYZ7wWc+WFoReOm98xq2S22+55w@mail.gmail.com>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org> <504F8427.1020507@web.de>
 <7vhar4gxdq.fsf@alter.siamese.dyndns.org> <5050E0CA.7080907@web.de>
 <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley> <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com>
 <7vmx0t94rc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 04:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCLOH-0000FO-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 04:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2INCMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 22:12:13 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53105 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2INCML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 22:12:11 -0400
Received: by qcro28 with SMTP id o28so2458906qcr.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xyL4sBoiJQfH0K7FY9TPjo0mH9FdvVt8Nj/+Uz63Qc8=;
        b=PJP4Qa21ISkCaX/9EtIc4wJcBLzeKYkePW43zEjqQABYoDPNzCWKoiVYql6QFMmqZ5
         2Mctmo05Yg9Sjigx4Br890QqGTLCp90ONeuD6QlO9V6DY2M/hEMu55/ocw0C6vFohHxR
         qGQme7urwDnmOSohMtnMjRUH731r6OA/5d2qb2hXo2Yln7y6XCrobL03cnEeCTB8l081
         c6ZThLVcn0sKgeQdwuGJRvWzCeQKSFOEsPdCSe9VnkonCDcyJQFDgLazG1E1pt8TxEjp
         +g+0oheRNiIXpaZnLj2ysQdA1WPKn4AtTC2/jy5PBa4NrxkaQkZTIvDkMHYwqKzqyTd2
         nLOA==
Received: by 10.229.136.145 with SMTP id r17mr805544qct.43.1347588730550; Thu,
 13 Sep 2012 19:12:10 -0700 (PDT)
Received: by 10.49.95.135 with HTTP; Thu, 13 Sep 2012 19:11:49 -0700 (PDT)
In-Reply-To: <7vmx0t94rc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205445>

On 14 September 2012 04:06, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> Currently, the output for each branch looks something like:
>> * <branch-name> (<creation-date>) <number-of-commits>
>>   (<merge-status>)
>>  [list-of-commits]
>>   (<branch-usage>)
>> <long-description>
>> <notes-and-memoranda>
>> <next-steps>
>>
>> and these are grouped by current integration status (new, graduated,
>> stalled etc)
>
> Yes.  Thanks for a concise summary.
>
>> A format that would make this information easier for me to parse would
>> be something like:
>>
>> <short-branch-description>
>>   <long-branch-description>
>>   <notes>
>>   <next-steps>
>>   * <branch-name> (<creation-date>) <number-of-commits>
>>     (<merge-status>)
>>    [list-of-commits]
>>     (<branch-usage>)
>
> I do not see how it makes any sense to have the "This is where the
> section begins with, and its name is this" line in the middle of a
> block indented in such a way.  Care to explain?

I'm not quite sure what aspect you are referring to, so let me just
expand my reasoning a little bit and hopefully that clears things up.

First of all, I didn't spend that much time thinking through the
layout, merely re-arranged things so that what I considered most
important was at the start of each listing. I kept everything else the
same, with an extra level of indentation for everything except the
first line of each listing. Perhaps modifying the existing indentation
to better fit in this layout is in order, but that is in some ways
orthogonal to the ideas I was trying to present.

I am not against changing how each listing is laid out in a more
disruptive way, this was just a first attempt at making it easier to
parse.

I like the idea proposed by others to increase whitespace between
listings to make each stand out, however I think indentation is a
better method.
* Increased whitespace between listings lengthens the entire list,
requiring more scrolling and decreasing the amount of information on
each page. Simply indenting most lines by a few columns of whitespace
may cause some lines to wrap, but in general will not lengthen the
listing or decrease information density. [edit] I realised after
writing this that the addition of a <short-branch-description> does
actually increase the length of the listing, however it does not
decrease information density as much as a blank line.
* The visual difference between two blank lines and one is
significant, but not as distinct as the presence (or not) of a
character in the first column of text. In scanning a long document, I
propose that finding a line that starts in the first column of text is
easier than finding the next line which is preceded by two blank
lines. Similarly jumping forwards or backwards a listing would be
easier.

This is all a little academic though, so lets compare both versions
with an excerpt from the most recent "What's cooking"!

First, the extra blank line

-- >8 --
* jc/maint-blame-no-such-path (2012-09-10) 1 commit
 - blame $path: avoid getting fooled by case insensitive filesystems

"git blame MAKEFILE" run in a history that has "Makefile" but not
"MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
confused on a case insensitive filesystem.


* sl/autoconf (2012-09-11) 2 commits
 - build: don't duplicate substitution of make variables
 - build: improve GIT_CONF_SUBST signature


* cn/branch-set-upstream-to (2012-09-11) 2 commits
 - completion: complete branch name for "branch --set-upstream-to="
 - completion: add --set-upstream-to and --unset-upstream

Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* jc/maint-ident-missing-human-name (2012-08-31) 1 commit
  (merged to 'next' on 2012-09-07 at 0e99b20)
 + split_ident_line(): make best effort when parsing author/committer line

"git show --format='%ci'" did not give timestamp correctly for
commits created without human readable name on "committer" line.


* jc/merge-bases (2012-08-31) 9 commits
  (merged to 'next' on 2012-09-07 at ab0974d)
 + reduce_heads(): reimplement on top of remove_redundant()
 + merge-base: "--is-ancestor A B"
 + get_merge_bases_many(): walk from many tips in parallel
 + in_merge_bases(): use paint_down_to_common()
 + merge_bases_many(): split out the logic to paint history
 + in_merge_bases(): omit unnecessary redundant common ancestor reduction
 + http-push: use in_merge_bases() for fast-forward check
 + receive-pack: use in_merge_bases() for fast-forward check
 + in_merge_bases(): support only one "other" commit

Optimise the "merge-base" computation a bit, and also update its
users that do not need the full merge-base information to call a
cheaper subset.

-- 8< --

Now, the extra indentation and re-organised contents

-- >8 --
jc/maint-blame-no-such-path
  "git blame MAKEFILE" run in a history that has "Makefile" but not
  "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
  confused on a case insensitive filesystem.

  * jc/maint-blame-no-such-path (2012-09-10) 1 commit
   - blame $path: avoid getting fooled by case insensitive filesystems

sl/autoconf
  * sl/autoconf (2012-09-11) 2 commits
   - build: don't duplicate substitution of make variables
   - build: improve GIT_CONF_SUBST signature

cn/branch-set-upstream-to
  Will merge to 'next'.

  * cn/branch-set-upstream-to (2012-09-11) 2 commits
   - completion: complete branch name for "branch --set-upstream-to="
   - completion: add --set-upstream-to and --unset-upstream

--------------------------------------------------
[Graduated to "master"]

jc/maint-ident-missing-human-name
  "git show --format='%ci'" did not give timestamp correctly for
  commits created without human readable name on "committer" line.

  * jc/maint-ident-missing-human-name (2012-08-31) 1 commit
    (merged to 'next' on 2012-09-07 at 0e99b20)
   + split_ident_line(): make best effort when parsing author/committer line

jc/merge-bases
  Optimise the "merge-base" computation a bit, and also update its
  users that do not need the full merge-base information to call a
  cheaper subset.

  * jc/merge-bases (2012-08-31) 9 commits
    (merged to 'next' on 2012-09-07 at ab0974d)
   + reduce_heads(): reimplement on top of remove_redundant()
   + merge-base: "--is-ancestor A B"
   + get_merge_bases_many(): walk from many tips in parallel
   + in_merge_bases(): use paint_down_to_common()
   + merge_bases_many(): split out the logic to paint history
   + in_merge_bases(): omit unnecessary redundant common ancestor reduction
   + http-push: use in_merge_bases() for fast-forward check
   + receive-pack: use in_merge_bases() for fast-forward check
   + in_merge_bases(): support only one "other" commit
-- 8< --

I personally find the second much more useful, but perhaps the
comparison will help other people evaluate them both.

>
> I can see some people may care more about the description than the
> list of commits [*1*], though.
>
>
> [Footnote]
>
> *1* It however is an indication that the title of each commit needs
> to be improved to convey enough information so that I do not have to
> write the branch description myself for them.

I remember something about including topic descriptions being
described when signed tag pull requests were being designed, could
that information potentially be coerced if available?

Regards,

Andrew Ardill
