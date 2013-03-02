From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Subtree in Git
Date: Sat, 2 Mar 2013 17:43:11 +0000
Message-ID: <CALeLG_=Yy0TkY-vY8AE9CtXhs4zF8kjdQBNdp+N4yhFmHM79RA@mail.gmail.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
	<4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl>
	<nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org>
	<4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com>
	<50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<nnga9vefu1v.fsf@transit.us.cray.com>
	<508A8BD3.9020901@initfour.nl>
	<2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
	<loom.20130301T032627-983@post.gmane.org>
	<CALeLG_maSpjVtO3swZAWV12Cr7rDWOaJ=Jh8zw5tJn0EGGW+fA@mail.gmail.com>
	<CACPE+fvuKiYmmGfJ=A_DZyOi+MiQQ3SgY+QyX5L08XK8TMwzEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kindjal <kindjal@gmail.com>, git <git@vger.kernel.org>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Sat Mar 02 18:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBqTK-00054E-LO
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 18:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab3CBRnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 12:43:13 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:52268 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab3CBRnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 12:43:12 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so7410843oag.36
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 09:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=Y27+G5Ka5ZXNuIMFc15PbaSiiooICbNXL1VmjQbv1bs=;
        b=cQnZibq+q7FGKkuZLOIYvJIxsEid0285e3GOvoZLcAN/KIXASKsRPRLR9sn5GjFEIa
         khO+BUr+uDxCrhmOfemayAPjRapHT9u2h/CW9xyl46zywod45aqthvPeDSDsa5V4P6Hs
         kaMo0HVdu997IeVcSaHi96P45EpNPrvQvC6yYwwgd+k3hYRrF5XM5HzR4KpjgtQD47NT
         N9TQRu/66DY8YKxwhA1dRQl0wh5PhV6yXPLhUsRMt3Ieq5MJlfzQOW8uL/CYxis/66he
         g/OsShhmtDLK9FNsnHviSazd8T1hRZiaqXe5QPINWgPgp8PmOR3nrPyZpAnxKcMkZX9F
         R0Jg==
X-Received: by 10.182.117.7 with SMTP id ka7mr11994873obb.29.1362246191484;
 Sat, 02 Mar 2013 09:43:11 -0800 (PST)
Received: by 10.76.93.37 with HTTP; Sat, 2 Mar 2013 09:43:11 -0800 (PST)
X-Originating-IP: [2.102.85.176]
In-Reply-To: <CACPE+fvuKiYmmGfJ=A_DZyOi+MiQQ3SgY+QyX5L08XK8TMwzEw@mail.gmail.com>
X-Gm-Message-State: ALoCoQlOZxxXfn7MOAB4Brjghefr1M6CnSIkMZTt97iBBtFQ8hNfEzexZee06jRbcEb8zUdpv8X5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217332>

On Sat, Mar 2, 2013 at 11:21 AM, David Michael Barr <b@rr-dav.id.au> wrote:
> On Sat, Mar 2, 2013 at 9:05 AM, Paul Campbell <pcampbell@kemitix.net> wrote:
>> On Fri, Mar 1, 2013 at 2:28 AM, Kindjal <kindjal@gmail.com> wrote:
>>> David Michael Barr <b <at> rr-dav.id.au> writes:
>>>
>>>> From a quick survey, it appears there are no more than 55 patches
>>>> squashed into the submitted patch.
>>>> As I have an interest in git-subtree for maintaining the out-of-tree
>>>> version of vcs-svn/ and a desire to improve my rebase-fu, I am tempted
>>>> to make some sense of the organic growth that happened on GitHub.
>>>> It doesn't appear that anyone else is willing to do this, so I doubt
>>>> there will be any duplication of effort.
>>>>
>>>
>>> What is the status of the work on git-subtree described in this thread?
>>> It looks like it's stalled.
>>>
>>
>> I hadn't been aware of that patch. Reading the thread David Michael
>> Barr was going to try picking the patch apart into sensible chunks.
>>
>
> Sorry for not updating the thread. I did end up moving onto other things.
> I quickly realised the reason for globbing all the patches together was
> that the individual patches were not well contained.
> That is single patches with multiple unrelated changes and multiple
> patches changing the same things in different directions.
> To me this means that the first step is to curate the history.
>
>> If this work is still needing done I'd like to volunteer.
>
> You're most welcome. Sorry again for abandoning the thread.
>
> --
> David Michael Barr

Okay, I'll start picking the patch apart this week then feedback when
I have a plan to tackle it all.

-- 
Paul [W] Campbell
