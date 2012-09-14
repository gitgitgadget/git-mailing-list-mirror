From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Suggestions for "What's cooking"
Date: Fri, 14 Sep 2012 13:58:05 +1000
Message-ID: <CAH5451m28z_5Hbtyqx3+YkR-CoTNFB9bjLx6A1cJJXtj3hVjQQ@mail.gmail.com>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org> <504F8427.1020507@web.de>
 <7vhar4gxdq.fsf@alter.siamese.dyndns.org> <5050E0CA.7080907@web.de>
 <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley> <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com>
 <7vmx0t94rc.fsf@alter.siamese.dyndns.org> <CAH5451n3bAkidWrtu4sy=NXPYZ7wWc+WFoReOm98xq2S22+55w@mail.gmail.com>
 <7vboh99w1z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 05:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCN3o-0000Cd-If
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 05:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab2IND63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 23:58:29 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43270 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab2IND61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 23:58:27 -0400
Received: by qcro28 with SMTP id o28so2506938qcr.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 20:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xBWwE4GJqNWPJfqYbUWDeuSj78OUUXmzhmHe7aioG1M=;
        b=s0wc/bScOYvPdooRbxyD1CAP4mw87kI9xyP3ecLTVmT6KHts+p9f2+uz+kSsbEKop3
         35WBiS1dNRyUr6Q+H926hadNpsuDJ4j14wXliCyOLxZG2WIG4cxgIUAXSOQddEqhwgTy
         HI6bHqP4vwwQMSeh7eaJoX4n10BBsfkgU+KPvLdT1gqwqvyAuC0an5MsvZ2fhbyISvvp
         t/LueaXnWxArjNs/w+l3ee8KyRDrgVqx80U0yQ7BXiSa/4yTdLMiFPyhDBDeQtTDJicG
         cZIAk9OSezxRnR2DpvcAhRH5PJlA7q2uC1ACh83zdprxOQ+DS9hfaPhXeZ4dpL963/FR
         ht1A==
Received: by 10.229.137.146 with SMTP id w18mr957986qct.12.1347595106675; Thu,
 13 Sep 2012 20:58:26 -0700 (PDT)
Received: by 10.49.95.135 with HTTP; Thu, 13 Sep 2012 20:58:05 -0700 (PDT)
In-Reply-To: <7vboh99w1z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205447>

On 14 September 2012 12:29, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> On 14 September 2012 04:06, Junio C Hamano <gitster@pobox.com> wrote:
>>> Andrew Ardill <andrew.ardill@gmail.com> writes:
>>>
>>>> <short-branch-description>
>>>>   <long-branch-description>
>>>>   <notes>
>>>>   <next-steps>
>>>>   * <branch-name> (<creation-date>) <number-of-commits>
>>>>     (<merge-status>)
>>>>    [list-of-commits]
>>>>     (<branch-usage>)
>>>
>>> I do not see how it makes any sense to have the "This is where the
>>> section begins with, and its name is this" line in the middle of a
>>> block indented in such a way.  Care to explain?
>>
>> I'm not quite sure what aspect you are referring to,...
>
> Just this part, as I do not have much time.  Here is your reordered
> one I will reject:
>
>   A > jc/maint-blame-no-such-path
>     >   "git blame MAKEFILE" run in a history that has "Makefile" but not
>     >   "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
>     >   confused on a case insensitive filesystem.
>     >
>   B >   * jc/maint-blame-no-such-path (2012-09-10) 1 commit
>     >    - blame $path: avoid getting fooled by case insensitive filesystems
>
> I was noting that B which *is* formatted as a header line (it EVEN
> has a leading asterisk to make it clear that it begins something
> new) is in the middle, and you added a redundant A that is not even
> marked clearly as a header line.

The leading asterisk is actually not as useful to me, as indicating a
header line, as the 'out-denting' I am proposing. I think this is due
to the similarities between the asterisk and the other symbols used to
indicate commits. This is maybe just a typographic issue, but I think
in general the contrast between letters and spaces appearing in the
first columns of text is stronger than either of characters and
letters, or spaces and characters. A quick comparison of all three:

--Letters and Spaces--
jc/maint-ident-missing-human-name
  "git show --format='%ci'" did not give timestamp correctly for...
   + split_ident_line(): make best effort when parsing author/committer line

--Characters and Letters--
* jc/maint-ident-missing-human-name
"git show --format='%ci'" did not give timestamp correctly for...
 + split_ident_line(): make best effort when parsing author/committer line

--Characters and Spaces--
* jc/maint-ident-missing-human-name
  "git show --format='%ci'" did not give timestamp correctly for
   + split_ident_line(): make best effort when parsing author/committer line

My preference would be first for letters and spaces, or if that is not
good enough then characters and spaces.


With regards to the comment that the old header line appears in the
middle of the output, as I said earlier that was a consequence of
reordering and indenting everything but otherwise leaving it as is.
This should be changed, so how about:

<branch-name> (<creation-date>)
  <branch-description?>
  <notes-and-memoranda?>
  <next-steps?>

  <#-commits> (<merge-status?>)
   [list-of-commits]
  (<branch-usage?>)

eg:
jc/maint-ident-missing-human-name (2012-08-31)
  "git show --format='%ci'" did not give timestamp correctly for
  commits created without human readable name on "committer" line.

  1 commit (merged to 'next' on 2012-09-07 at 0e99b20)
   + split_ident_line(): make best effort when parsing author/committer line


with no description:
sl/autoconf (2012-09-11)
  2 commits
   - build: don't duplicate substitution of make variables
   - build: improve GIT_CONF_SUBST signature


Hopefully that makes more sense and addresses the concerns you raised.
Adding an asterisk at the start is ok by me, if that is something you
think is needed.

One thing I did think about, when leaving the asterisk in the middle
of the listing in the first version, was how machine readable the
format was. I'm not sure if that is important, but the asterisk was a
clear signal that what followed was a listing of commits. In any case,
the new and revised format is perhaps slightly less machine readable
as a result.


I feel a little bit like I might be bikeshedding this, however I do
think an improvement to the formatting of "What's cooking" is a
meaningful one for the project!

Regards,

Andrew Ardill
