From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Wed, 4 Sep 2013 00:45:03 -0400
Message-ID: <CAM9Z-nnjb1wUDH9e=E38QnWvPK44xZqvza77yNLrDpjpj47BKw@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<CAMP44s3ABKMAhp_P+QZBWOfjp_wPkqB0A63v6n2mKZv_Ln+qKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 06:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH4xq-0007y7-Kl
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 06:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761180Ab3IDEpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 00:45:04 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41730 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760245Ab3IDEpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 00:45:03 -0400
Received: by mail-ie0-f177.google.com with SMTP id e14so12347333iej.36
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WfQ44kFyjfvP7WnuJnf7bwnRb+7qDniVmiOt3OKkx5E=;
        b=c/B2hpwE6G2VYMKhfLXcWt0cF2dicW8ENbVingg9oHp9ZjavD3ZkIung9jmdyKoA0K
         k0KLp7Xk1NNhQXDF4568JPNbS66rRTJg+wVn+msMzgzA171BZA4ostk+WNeYdn9antMy
         aA3XtAQvMnbcE2eAACAcnK3X+I6FNuXbA86ZJmqIs0POpuWtbUak/lBZy+xbQ4LVkTqQ
         mZariyHBWl1lCKP3OgUzSaHIZj4ffcD+SuoPxIhno18jpLSZKADFjsXRTjSW87Qrwuxe
         BNWWhbnga35U0qFZXNl9kmPjXnD4dR9DKchtCUeb0dCNsF/sXWdkwf2tVooAFHVbwYBX
         /1Vw==
X-Received: by 10.50.23.76 with SMTP id k12mr417003igf.37.1378269903469; Tue,
 03 Sep 2013 21:45:03 -0700 (PDT)
Received: by 10.43.111.72 with HTTP; Tue, 3 Sep 2013 21:45:03 -0700 (PDT)
In-Reply-To: <CAMP44s3ABKMAhp_P+QZBWOfjp_wPkqB0A63v6n2mKZv_Ln+qKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233804>

On Thu, Aug 29, 2013 at 6:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 4:55 PM, Drew Northup <n1xim.email@gmail.com> wrote:
>> On Thu, Aug 29, 2013 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> It has been discussed many times in the past that 'index' is not an
>>>> appropriate description for what the high-level user does with it, and
>>>> it has been agreed that 'staging area' is the best term.
>>>
>>> "add" is the verb, not "index" (which is a noun that refers
>>> to the thing that keeps track of what will be written as a tree to
>>> be committed next).
>>>
>>> And it will stay that way.

>> I agree with Junio.
>
> All right, you are the only person (presumably other than Junio) that
> thinks "index" is the right name for what high-level users should be
> familiar with.

If that were true it would never have gotten that name. "Add" is the
verb, as we are adding a snapshot. New users don't care how that works
for the most part. Just telling them "it keeps track of it itself" is
usually good enough. If the user is asking for more detail at that
point it is probably because he isn't as much interested in how to use
it as he is in how it works. At that point we're better off just
giving him the actual explanation instead of getting caught up in the
staging area vs index fight (which seems odd to me as the index
contains the entries which act as a "staging area"--a superset /
subset relation).

>> We add content snapshots to the index of content (creating
>> "temporary"--they will be garbage collected eventually if they become
>> orphans--objects into the store at the same time). We build commits
>> from those snapshots (in whole or in part, typically only using the
>> most recent snapshots of new things added to the index) and save those
>> in the object store with the content and tree objects. Sometimes we
>> create tag objects to record something special about commits, trees,
>> and content blobs.
>>
>> That's the real model (with some rough edges). Explaining what that
>> has to do with distributed version control is the hard part.
>
> The user doesn't need to know the format of the index, or the packs,
> in fact, they don't even need to know the index or packs even exist.

I never implied that the end user does need to know these things.
(Note the use of "We"--as in "we who are having this conversation.")

> All the user needs to know about this is that there's an area where
> contents of the next commit are being prepared, and "staging area" is
> the best name for that mental area. How that area is actually
> implemented (the index) is not relevant to the user.

Part of what I am arguing is that the mental area doesn't need to
exist at all. The "staging area" is a part of the index. It is not the
whole thing. There is no one-off complete replacement of one with the
other. Most new users won't care about either, just that it happens
somehow and that git keeps track of that state itself. We need not
change any core items to achieve that.

> Everyone agrees on that, except you, and possibly Junio.

We don't have enough information to say that. Seriously, this is
nowhere near as certain as climate change.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
