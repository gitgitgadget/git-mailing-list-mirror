From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Fri, 22 Oct 2010 17:00:43 -0400
Message-ID: <AANLkTinUc2BW+BOTNMOC1t=3=rYzYgedyS5LFu37J+Yo@mail.gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<vpq8w1v5gce.fsf@bauges.imag.fr>
	<buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
	<8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
	<AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
	<6FCE62E3-A27E-43D6-9FDF-0133ABD851C2@wincent.com>
	<AANLkTinGuVm8gib9r7omVV9hHw8B-iBQGgsv+b6wb5=Q@mail.gmail.com>
	<1287778585.2025.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9OjM-0001z8-5O
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab0JVVAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 17:00:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56971 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab0JVVAp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 17:00:45 -0400
Received: by bwz11 with SMTP id 11so949797bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6Ylh3LNvQvTXb27NyB/f6QHu2j0WG+g2nBQtfZiiGhA=;
        b=LrJWD0GBaVKwNj2X06SgXLcEpwjh9DmF7ded0nobeajRWYL4MYEP1DZY0EfsnsqchR
         yp2Xyq28rxhXonWLznd0X0NretUwCiJk2l6mWiKV6lCIxWsOtBMC9KVVdQ6g7Otg6nd3
         u56E839nIOxpaQ89ZUrt+0cTq3SwthjhZ87pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sy21aFWXx2EaCC35hAnd8onlBRcN0Ft1cs3p7HQ59zpRvHamGdqQCoTFmf3oXV6kDM
         bZdQCKM9gRpY+CptKPFzqhG6fWvhv5n35aqrJZ8qRrNCfHyKYxJjRcMxJ6j1lbDfZSKA
         +xClQebTbS7+SmFaC+5Nf7iV0gk4lQvwhnG7E=
Received: by 10.204.99.131 with SMTP id u3mr2651095bkn.41.1287781243684; Fri,
 22 Oct 2010 14:00:43 -0700 (PDT)
Received: by 10.204.46.207 with HTTP; Fri, 22 Oct 2010 14:00:43 -0700 (PDT)
In-Reply-To: <1287778585.2025.14.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159749>

On Fri, Oct 22, 2010 at 4:16 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Tue, 2010-10-19 at 11:09 -0400, Eugene Sajine wrote:
>> There should be some different consistent and not inter-crossing
>> naming for the origin's master branch (on the remote side), for the
>> local origin/master and for local master that is a tracking branch.
>> The only way i found so far to explain this is actually via the nami=
ng
>> syntax where having / in the name of the branch means remote branch.=
 I
>> was a bit surprised that i can create a local branch with a slash in
>> the name - probably it should be prohibited.
>
> Allowing local branches with a slash in their name is a feature I use
> heavily. Ie, in general my local repositories use this scheme:
>
> $ git branch
> * master
> =C2=A0$BRANCH_F00
> =C2=A0$USER/$TOPIC_FOO
> =C2=A0$USER/$TOPIC_BAR
> =C2=A0[...]
> =C2=A0$USER/$TOPIC_BAZ
>
> This makes it trivial to quickly distinguish my (local) work from oth=
er
> people's (remote) work. Does the benefit of naming clarity justify
> prohibiting that scheme?
>
>
> Paul Bolle
>
>

Well, my approach is to use:
master - local
mybranch - local

remote from user
$ git remote add jdoe ~jdoe/project/.git

Then remote-tracking branches will be
jdoe/master
jdoe/featurex

my local branches tracking remote-tracking branches (automatic push, pu=
ll)
jd_master
jd_featurex

in this case there is no confusion between jdoe/master that is a
remote-tracking branch checkout to which will lead to detached HEAD
state and jd_master that is a local branch.

As in this syntax the slash is that meaningful, i think that reserving
this syntax "remote/branch" to the remote-tracking branches only makes
sense.

Thanks,
Eugene
