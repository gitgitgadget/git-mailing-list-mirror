From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Sat, 13 Jun 2009 00:48:36 +0300
Message-ID: <94a0d4530906121448m57f272eej32e8d57e48002f1f@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <200906110242.57475.jnareb@gmail.com>
	 <94a0d4530906121357h63723278i7663c25707d3c754@mail.gmail.com>
	 <200906122321.57479.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEcE-0008Ey-48
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 23:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759757AbZFLVsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbZFLVsg
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 17:48:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:46326 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878AbZFLVsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 17:48:35 -0400
Received: by fg-out-1718.google.com with SMTP id d23so39715fga.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DK+rKr7R1v83a7aq26b/GDH0H1LOEWPHxm1HRVkOiYo=;
        b=WmEUDjGB+Wjo7l3kzkp+lDrzSAZURY/OQqw6hnIx3VJvJ6vRZeVezGVM9APyAiV1gk
         uXMi/kDnVr7Ff+qp9Vg8g2whbzxPN5FypsP7zICiCemeB9JHqB5kD7RfGqw+z0d1CAkh
         9smEqLFcIb7P9kk1ztbHE8UCcaIkV+sgXfmec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uRCeu2mkdK9+AOqE6eAGJNk7OieDMHh2QPdkEW5koXEvEdWOzXbMKUsJK8WEd0pzaK
         mbZSrC2UZGiNtpMu6eJHLFci7AYwD7UjbEAmbn33b/T3a0Deph772vIOYisughfNfK9b
         BCk7i58EClG6Mx8U892ZwxKItXcNWoxgePxnU=
Received: by 10.86.3.11 with SMTP id 11mr4390758fgc.11.1244843317076; Fri, 12 
	Jun 2009 14:48:37 -0700 (PDT)
In-Reply-To: <200906122321.57479.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121452>

On Sat, Jun 13, 2009 at 12:21 AM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
> On Fri, 12 Jun 2009, Felipe Contreras wrote:
>> On Thu, Jun 11, 2009 at 3:42 AM, Jakub Narebski<jnareb@gmail.com> wr=
ote:
>>> On Thu, 11 June 2009, Felipe Contreras wrote:
>
>>>> 'git reset' also gets something out of the repository and into the
>>>> working area, that's not reason enough to put them under the same
>>>> 'checkout' command, is it?
>>>
>>> Nope. 'git reset' resets something to the state in repository (to g=
iven
>>> commit). =C2=A0The fact that some combination of options for 'git r=
eset' gives
>>> the same result as some specific combination of options of 'git che=
ckout'
>>> means only that one can arrive at some destination in two different=
 ways.
>>
>> You can describe what 'git reset' does in many ways, but in the
>> process it's still getting something out of the repository and into
>> the working directory, does it not? 'git checkout <commitish>' and
>> 'git checkout <commitish> -- <path>' also do that.
>
> Nope. 'git reset' always reset some part of state to a given commit,
> HEAD by default. =C2=A0It can reset current branch with --soft, branc=
h plus
> index with --mixed (default), and branch plus index plus working
> directory with --hard. =C2=A0Source is always commit.

You said it: 'git reset --hard' gets something out of the repository
and into the working directory.

Try this:
git checkout <random sha-1 with no ref>

Then what is the difference between:
git checkout HEAD^
git reset --hard HEAD^

In this case they do exactly the same thing, don't they?

> 'git checkout' however checks out something into working directory.
> It can be branch, in which turns it sets HEAD to point to it, and
> index too. =C2=A0It can be file, in which it gets version of file fro=
m
> index or (if specified) from given commit. =C2=A0Destination is alway=
s
> working area (and sometimes something else beside it).
>
>>
>> Is that relevant? No. What is relevant is the final action the user =
is
>> expecting to achieve.
>>
>> Therefore, the fact that 'git checkout <commitish>' modifies the
>> working directory is irrelevant, it's still doing an extra step;
>> update HEAD, and that final action is what is important for this
>> particular command; it switches to another commitish.
>
> It is not uncommon for a word to have different meaning depending on
> context, or on some auxiliary word used in addition...

We are talking about a command here, not a command that has two slight
variations of the same main action, a command that is doing *two*
completely unrelated actions depending on the context.

Think about these 3 actions:
a) get a path out of a commit in the repository and into the working di=
rectory
b) switch to another commit, reseting the working directory
c) reset current branch to certain commit, and checkout into the
working directory

The 3 actions require putting something into the working directory;
what makes a) and b) so similar they belong to the same command?

--=20
=46elipe Contreras
