From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 19:34:46 -0600
Message-ID: <CAEUsAPYdpsbhCZfp-1w91ZiyqgEa=8TNf2MJihMViqVZmW3sRw@mail.gmail.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
	<20130120125838.GK31172@serenity.lan>
	<CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
	<20130120152857.GM31172@serenity.lan>
	<7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
	<CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 02:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6I1-0008R4-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab3AUBet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:34:49 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61016 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3AUBes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:34:48 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so78214lbb.22
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 17:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=lwC7ByY+WVsqmFvkqkc/uQ5O9p460MrVgMS/R+xjmQ4=;
        b=KF/Bom8DTYnYD9qh11hNow9/pxE0O2GqYvu2i74W0A/N11C5Ox3bA3HnUMDaDSzwVz
         j/zP88h9RkGINwfrdEqmVhfProZFkpcZt0qtY0e7ReoEeWxIb3KlFb5g0sCSlfdsAVvj
         JF6iYFRKG1vPLpZfhM2o8pbVMJldQwxXz/A+wS9o3+cFEsqNmUxfKKwb+q1vsshQli0y
         +KwbV+MpdtY6RA6oMOUU2dja1HD7ibdGdwRdB2aOiDYLdQ5AsZddEkYaOmJFAnC4H/vJ
         H5H+o6FETBvtbtJGEzxHlAOzcD1FwuLlpRLhVgXpRlchgI7pJ6Lp8JVJLTvDVW9ReoFy
         17fg==
X-Received: by 10.152.144.103 with SMTP id sl7mr15593330lab.23.1358732086465;
 Sun, 20 Jan 2013 17:34:46 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Sun, 20 Jan 2013 17:34:46 -0800 (PST)
In-Reply-To: <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
X-Google-Sender-Auth: e9xgW5ZSTq2w2x058kWE1F5t80M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214067>

On Sun, Jan 20, 2013 at 2:17 PM, Chris Rorvick <chris@rorvick.com> wrote:
> On Sun, Jan 20, 2013 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Keeping <john@keeping.me.uk> writes:
>>
>>> On Sun, Jan 20, 2013 at 09:22:03AM -0600, Chris Rorvick wrote:
>>>> On Sun, Jan 20, 2013 at 6:58 AM, John Keeping <john@keeping.me.uk> wrote:
>>>>> On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
>>>>>> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
>>>>>> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
>>>>>> to Eric (fixes revision map.)
>>>>>
>>>>> Did you post the fix for the revision map publicly anywhere?
>>>>
>>>> It's in Eric's repo and included in version 3.8:
>>>>
>>>> https://gitorious.org/cvsps/cvsps/commit/abe81e1775a8959291f629029513d1b7160bbde6
>>>
>>> Thanks.  For some reason I thought the fix would be to
>>> git-cvsimport-3.py.  Obviously I should have read more carefully.
>>>
>>> Sorry for the noise.
>>
>> This is not a noise, though.
>>
>> Chris, how would we want to proceed?  I'd prefer at some point to
>> see cvsimport-3 to be in sync when the one patched and tested in
>> Eric's repository is proven enough.  Will Eric be the gatekeeper, or
>> will you be sending patches this way as well?
>
> I probably won't be sending any more patches on this.  My hope was to
> get cvsimport-3 (w/ cvsps as the engine) in a state such that one
> could transition from the previous version seamlessly.  But the break
> in t9605 has convinced me this is not worth the effort--even in this
> trivial case cvsps is broken.  The fuzzing logic aggregates commits
> into patch sets that have timestamps within a specified window and
> otherwise matching attributes.  This aggregation causes file-level
> commit timestamps to be lost and we are left with a single timestamp
> for the patch set: the minimum for all contained CVS commits.  When
> all commits have been processed, the patch sets are ordered
> chronologically and printed.
>
> The problem is that is that a CVS commit is rolled into a patch set
> regardless of whether the patch set's timestamp falls within the
> adjacent CVS file-level commits.  Even worse, since the patch set
> timestamp changes as subsequent commits are added (i.e., it's always
> picking the earliest) it is potentially indeterminate at the time a
> commit is added.  The result is that file revisions can be reordered
> in resulting Git import (see t9605.)  I spent some time last week
> trying to solve this but I coudln't think of anything that wasn't a
> substantial re-work of the code.
>
> I have never used cvs2git, but I suspect Eric's efforts in making it a
> potential backend for cvsimport are a better use of time.
>
> Chris

Hi Eric,

I noticed you were taken off this thread.  As I mention above, I
looked into the bug tested in the t9605 patch Junio applied on top of
your cvsimport patch.  The test was actually written for master to
test the Perl/cvsps2 import, but with minor modification you can
verify the problem still exists in the 3.x versions of cvsps.

I think the email above explains the problem pretty well.  It's not
clear to me what all the nastiness is that you've resolved with cvsps
since taking over; I've been mostly concerned with importing an almost
branchless repository which I thought avoided the types of problems
you were addressing.  But this bug can actually cause Git's main
import branch to become inconsistent with CVS HEAD and you don't have
to do anything too weird to get hit by it.

Fixing this seemed like it would require splitting the processing out
into a couple phases and would be a fair amount of work, but maybe I'm
just not looking at the problem right.

Chris
