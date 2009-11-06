From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Preserving branches after merging on ancestor
Date: Fri, 6 Nov 2009 16:52:50 -0600
Message-ID: <20091106225250.GA14642@progeny.tock>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
 <20091105232848.GA1939@atjola.homenet>
 <20091106010947.GB4425@progeny.tock>
 <20091106021038.GA27206@atjola.homenet>
 <20091106050353.GA8824@progeny.tock>
 <1257520877359-3959325.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Richard Lee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:47:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xau-0005cb-4a
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933280AbZKFWnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 17:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbZKFWnU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:43:20 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:61623 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbZKFWnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:43:14 -0500
Received: by gxk4 with SMTP id 4so1551918gxk.8
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H/29p/IcC2CfRiOCnytdFVxeL0KiENUJu6GXZ8w2UJc=;
        b=QAHzkaRn1ttDEBDVbAANHeh5dCsKuXtjWt7pPEll9Xo0c4/Pd9eVOWcHt+1TPy2sVa
         o7P9aMBUdWcuiweWOZ2Bk1SX3VuL55sMYimhj17tQ1NFkP2osbkcQ7Nqe0NrayiaM4v4
         f7i4FljOKLkRUz6Ne4Q1Vrv9Q9fYeMm/DvTLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UIyhOqwYppevh4GWjE6OUpTiJScp23liFHQNfpG/UcGNWkEknfjrP0HISuKjnZL4ES
         3UuV6EBbjcm5OJ7DOer30e0VjwKDzVQIlDU28yDCeLMGzUlZfevyPlAweaKWAHFPHfed
         iKPAPDHy9gOHgEUHAhHR0GIn5l3RvGjEHpqDc=
Received: by 10.100.249.3 with SMTP id w3mr5395006anh.118.1257547399114;
        Fri, 06 Nov 2009 14:43:19 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm211369yxg.12.2009.11.06.14.43.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:43:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257520877359-3959325.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132327>

Richard Lee wrote:
> Jonathan Nieder wrote:

>> Then your response pushed me towards the question of whether --no-ff=
 is a
>> good idea in general
>>=20
>=20
> John, I get the feeling from what you say in general that fast forwar=
ds are
> default behaviour for merges for a reason and by using the --no-ff op=
tion I
> am making my workflow and git history uncessesarily awkward and worki=
ng
> against best practices?

Well, no.  Some of us (read: I) just haven=E2=80=99t figured out yet ho=
w to fit the
--no-ff option into a broader workflow yet.  It is only two years old. =
:)

There are pros and cons to using --no-ff to merge topic branches.  Pros=
:

 * 'git log --first-parent' will give the list of topics now.
 * The beginning and end of each topic is not forgotten by a clone any
   more.

Cons:

 * The perceived beginning and end of a topic might be irrelevant or
   misleading.
 * Every topic needs a good name. :)
 * More commits for a person looking through the history to deal with.
   A merge commit from a would-be fast-forward records content identica=
l
   to its second parent, and it is not necessary as glue to tie the
   content-changing commits together any more.

After thinking about it a little, the pros seem to far outweight the co=
ns.

>> Bj=C3=B6rn Steinbrink wrote:
>>
>>> I guess Richard took the "branch topic1, merge topic1, branch topic=
2,=20
>>> merge topic2" thing just as an example because that ends up with tw=
o=20
>>> fast-forwards.
>>=20
>> Hmm, I found Richard=E2=80=99s example pretty realistic.  I used to =
work like
>> that, and I don=E2=80=99t think I am the only one.
>>=20
>=20
> I'm not saying there is any one "right" workflow. But is there a more
> suitable workflow than than "branch topic1, merge topic1, branch topi=
c2,
> merge topic2"?

Yes, in my opinion.  I prefer to branch topic1, branch topic2, ...
and only later (after some time to reflect) decide which topics to
merge.  For this to work, each topic should not have all previous
topics as ancestors, or there is no way to postpone merging any one.

This is especially nice when a topic turns into a long-term project.
By not merging in the partial work, I keep the code in the master
branch a little cleaner, but more importantly, bugs in the partial
work do not interfere with work on other topics.  Once it is finally
time to merge the topic back to master, it is in one clean merge, and
all the commits are together for someone looking at the history.

=E2=80=9CWhat about testing?=E2=80=9D one might ask.  =E2=80=9CHow can =
I tell when it is safe
to merge the topic to master, when the topic and other features since
then might work well separately but not together?=E2=80=9D  The =E2=80=9C=
Throw-away
integration=E2=80=9D section in gitworkflows(7) [1] discusses how to de=
al with
this.

Taking the idea of forking from the oldest relevant commit to an
extreme in a single-person project, you can end up with history like
this:

initial---------------final
       \             /|
        \---A-------/ |
         \         / /|
          \---B---/ / |
           \       /  |
            \---C--   |
             \       /
              \--D---
               \
                -E- ...

i.e., full of octopus merges and basically unreadable in gitk.
Arguably, this is at least partially a gitk bug.  [Aside: a dream
feature for gitk would be to give the --first-parent history at first
and then fill in topics when the user requests them.  That is, in this
example, it would show

  initial---final

but after a click on the parent A, it would show

  initial---final
         \ /
          A

and so on.]  To avoid this, it is best not defer merging topics into
the mainline for too long, and to base each topic branch not on the
oldest relevant commit but on the tip of the oldest branch it might be
merged to (which in the simplest case is usually the mainline).

A single person has a lot of control over the shape of the history,
so that it is easy to make it totally linear or sequence of enormous
octopuses.  The nicest history for others to read, I think, is that
most like one created by many people in a healthy project.  But that=E2=
=80=99s
a hard ideal to achieve, and more important than crafting well shaped
history is to write good code, so it is not worth obsessing over.

I hope that is a little clearer.

Regards,
Jonathan

[1] http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html#_=
throw_away_integration
