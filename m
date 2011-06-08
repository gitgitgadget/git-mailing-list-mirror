From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 10:15:45 -0400
Message-ID: <BANLkTik_yw1awh6wM6hmUUxbgW5iVuOzCQ@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<201106081312.46377.jnareb@gmail.com>
	<BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
	<201106081442.37849.jnareb@gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:15:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUJY0-0004tQ-EL
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 16:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab1FHOPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 10:15:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40450 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHOPq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 10:15:46 -0400
Received: by bwz15 with SMTP id 15so452284bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8bLfIGGNYTmnFvnSHmPC/ass/pIoHixuLVMpOjIutc0=;
        b=DHd9dTnzFSOoAcUZIxKtf/rXFnQfzV12AoSQLCaBBWMCtaq6HdUMJpbCzjAYcA227z
         PECp1P0mszrE9mQBSRhOyQt1l2loWIshD+PRWJ79aM+YQb4vHi9Q6RTs/AsjjN6mYACt
         J/gmX3a9h5/QKedUsMJww4ISnIRus4IQDtX2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=rk7MbkXphgu4Y5ZcvnGH6uTdBhjkYIkKx0zjUQ1NbqATUtNQ4N3YKGWXK1HpMzc9nM
         34aj178u0M40Yf6E2i9aj2ttVHNrjVGYfhEYIQYx1+jvAS3ZpSUqy+VsLxpar4DtmC0w
         MVJ1nZnPTY4mVxeXtWJfLhToNVuFUYKHveX6g=
Received: by 10.204.82.149 with SMTP id b21mr607502bkl.196.1307542545120; Wed,
 08 Jun 2011 07:15:45 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Wed, 8 Jun 2011 07:15:45 -0700 (PDT)
In-Reply-To: <201106081442.37849.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175373>

On Wed, Jun 8, 2011 at 8:42 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Wed, Jun 8, 2011, Michael Nahas wrote:
>> On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>
>> > I don't quite think that we need "git diff NEXT WTREE"; the short
>> > and sweet "git diff" is short for a reason,
>>
>> To be clear, I'm not advocating and have never advocated getting rid
>> of zero-argument "git diff". =A0I've advocated that every (whole
>> project) diff command should be expressible by a "git diff TREE1
>> TREE2". =A0I'm fine with defaults if one or zero trees are specified=
=2E
>
> Those pseudo-almost-refs (almost-tree-ish) are to help new users, isn=
't it?
> But shouldn't new user learn that he/she should use "git diff" to rev=
iew
> his changes, rather than use "git diff NEXT WTREE" to compare staged
> contents with working area?

I think we need a new term that refers to NEXT, WTREE, and commits.
It could be "snapshots", but that is closely associated with commit
and has a feeling of being read-only.  Maybe "root-tree"?

I think most users - new or ortherwise - should use "git diff".  It's
the shorter command.  I think a man page saying "git diff" is
equivalent to "git diff NEXT WTREE" is (1) very specific as to what
the command does and (2) illuminates new users to the concepts, so
that when they see "git diff HEAD NEXT" or "git diff HEAD WTREE", they
can imagine what is going on.

>> So "git diff" would default to "git diff NEXT WTREE".
>
> You mean that "git diff NEXT WTREE" output be the same as "git diff",
> except for corner cases (merge conflict), isn't it?

I've addressed the conflict case already.  NEXT should contain HEAD
plus all the resolved files.

As far as I can tell, with that definition, "git diff NEXT WTREE" "git
diff HEAD NEXT" and "git diff HEAD WTREE" would produce the same
results as the current implementation of "git diff", "git diff
--cached" and "git diff HEAD" --- even in a conflicted state.

I've only been able to check that by experimentation; I asked if
someone who knew the code could confirm it.

>
> --
> Jakub Narebski
> Poland
>
