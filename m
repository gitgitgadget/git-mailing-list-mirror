From: Irene Ros <imirene@gmail.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Wed, 25 Mar 2009 13:23:43 -0400
Message-ID: <7001b7a00903251023r1ce5cc0dnb29b7f9379408c42@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
	 <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
	 <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
	 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
	 <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
	 <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
	 <alpine.LNX.1.00.0903242304530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:25:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmWqt-0002wR-7A
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 18:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbZCYRXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 13:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755664AbZCYRXs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 13:23:48 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39300 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbZCYRXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 13:23:46 -0400
Received: by qyk16 with SMTP id 16so284722qyk.33
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Me/DXQyw557guOLyC5M4huo42ZbiyOhRZj0whGUos1Y=;
        b=bcRJlIAWO/+FGEcpIRa1R/qa9iUDQ4l82MVm9E/bJ+j7OTuEB/FXG2AWLv6Bv+cu2E
         A+Vc3AVn9cHgicL30b8oxVOGdcBQmCLWHIjHGK8W357M0fbDpvbu59XFIlvLi+NbupgO
         oDiA24RowDltfXVBAOwlCDRxg7P/ICLMrGuL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tAphb1vaMeHvpx/N5OojuOXfNVO3Z/ZPhmyK+RvpJygmNzXi4nDr/8YACabVYdZawE
         9l3BLk16tboIrc7kxsopQgwGoG4dUVbpqlpN+m2egaXpzE2MBeNNShzn/w2apZdPoLzN
         Zl6HAmkzESCA3P8hvqzQvMiqSsB864DofjiXQ=
Received: by 10.220.76.1 with SMTP id a1mr3518723vck.101.1238001823088; Wed, 
	25 Mar 2009 10:23:43 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903242304530.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114624>

Hi Daniel,

Thank you for the explanation, doing a git fetch actually did do the
trick although I still don't quite see the difference between
git pull origin myBranch
and
git fetch

When I push to origin myBranch it's clear that it actually pushes my
changes to our remote repository since others can then pull and get
them. So is it the case that:

git push =3D=3D> actual remote repository
while
git pull <=3D=3D local copy of remote repository for this branch ?

In that case why is it that in all branches that I have, besides this
one, doing a 'git pull origin whateverBranch' actually pulls from the
remote branch and not the local copy? This case has been quite unique
given dozens of branches that we constantly switch to and from. We've
never actually used (or clearly saw the need for) git fetch until now.

Thank you so much for your insight, it's very helpful in understanding
these subtleties.

-- Irene



On Tue, Mar 24, 2009 at 11:19 PM, Daniel Barkalow <barkalow@iabervon.or=
g> wrote:
> On Tue, 24 Mar 2009, Irene Ros wrote:
>
>> Hi All,
>>
>> Thank you for the good advice. I may be the case I am somehow misusi=
ng
>> git... I couldn't resolve the issue and so I created a new project o=
ff
>> of the same repo. Switching to the same branch in question yielded a=
n
>> even stranger result: In this new project, the commits were there (I
>> could see them in git log and in git log origin/myBranch) whereas in
>> the previous older project I did not... does that make sense? Our
>> origin branches are located on a central server so can't quite figur=
e
>> out why viewing the log of the same remote branch from two different
>> projects would yield different results. Any suggestions? At this
>> point, I'm just really curious.
>
> origin/* is a copy of what git saw the last time it talked to the rem=
ote
> repository. This may be different from what the remote repository now
> contains. (Also, there are a few cases in which pushing to a remote
> repository doesn't count as talking to it; fetching with a configured
> remote always counts.) The local copies are handy for being able to
> compare the work you've done locally with what is in the remote repos=
itory
> when you don't necessarily have a network connection, don't expect
> constant updates remotely, or don't want to be distracted by remote
> changes. For example, you might have your local work, and you might w=
ant
> to compare it with what other people have done. You want to avoid hav=
ing
> additional changes that other people make while you're making this
> comparison show up in the middle.
>
> Of course, when you make a new clone of the same repository, this clo=
ne
> will look at the repository when you make the clone, and will have th=
e
> latest information (as of that time).
>
> In order to get an existing repository to see changes to a remote
> repository, use "git fetch <remote>" (you can leave off the <remote> =
to
> get the oone you gave to "clone", which is configured as "origin").
> Alternatively, you can use "git pull" to get the data and also merge =
it in
> the same command, which may or may not be a useful addition depending=
 on
> your workflow.
>
> =A0 =A0 =A0 =A0-Daniel
> *This .sig left intentionally blank*
>
