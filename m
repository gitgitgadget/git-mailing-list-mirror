From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Checkout first version of each file?
Date: Tue, 8 Nov 2011 16:00:07 +0100
Message-ID: <20111108150007.GA5261@kolya>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
 <20111108140243.GA4866@kolya>
 <CABLeVKFkSP=2-kwsN4N+oLrPnijkpvV8Ki=Si4dpYXdzc+8ibQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 16:00:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNn9f-0000zQ-5U
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 16:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872Ab1KHO7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 09:59:55 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36629 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852Ab1KHO7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 09:59:53 -0500
Received: by bke11 with SMTP id 11so466006bke.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 06:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ft6Wq7DwGWoTH7P3zYtGhvq+vMWMS8nyRsWHkqKXYXo=;
        b=N0v6/40a8CkKp4aReyie5UU8/yFyfJuPQ+t9EcWYE2hApSnzyG2rdNeZxJ12H/D4oO
         QeRG6mWUaHLmBftKMRelr67atBGIiUP8xpb7vlmbR8IXfECeFG6E5NG1tbXTP/phQLCu
         WhZvc93oP2OvYrfvKw3K9SCsl9r07aPm/lNK4=
Received: by 10.204.148.75 with SMTP id o11mr11536632bkv.95.1320764392244;
        Tue, 08 Nov 2011 06:59:52 -0800 (PST)
Received: from kolya ([194.47.208.238])
        by mx.google.com with ESMTPS id r12sm1829052bkw.5.2011.11.08.06.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 06:59:51 -0800 (PST)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1RNn9j-0001nv-EN; Tue, 08 Nov 2011 16:00:07 +0100
Content-Disposition: inline
In-Reply-To: <CABLeVKFkSP=2-kwsN4N+oLrPnijkpvV8Ki=Si4dpYXdzc+8ibQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185090>

On Tue, Nov 08, 2011 at 11:17:27AM -0300, Dario Rodriguez wrote:
> On Tue, Nov 8, 2011 at 11:02 AM, Fredrik Gustafsson <iveqy@iveqy.com>=
 wrote:
> > On Tue, Nov 08, 2011 at 10:58:05AM -0300, Dario Rodriguez wrote:
> >> Hello,
> >>
> >> My "issue" comes with my usage of git at work. I work with lots of
> >> applications, each of them part of each system. There are lots of
> >> processes and lots of subsystems, so I never clone the entire repo
> >> into GIT, since it could be painful and slow. Even if I do so,
> >> everyone else is using ClearCase, and their changes cannot be incl=
uded
> >> into my git repo until they "chickin". Sometimes, I must update
> >> sources from FTP because the changes are not up to date in
> >> ClearCase...
> >>
> >> So, I clone every file that I will need to work into GIT, so i can
> >> work with these files having a better control (With ClearCase it's=
 a
> >> foolish "checkout>>lots of changes>>checkin" flow). But sometimes =
I
> >> don't know how many files I am going to change until I start codin=
g
> >> the requisites.
> >>
> >> In this cases, there is a situation that I don't know how to handl=
e.
> >> If I need to rollback every change made to every file I cannot jus=
t
> >> checkout the initial commit, cause I've added files after that, an=
d I
> >> need their initial versions too.
> >>
> >> So, how can I checkout the first version of each file? (I know tha=
t
> >> GIT tracks contents and not files, but the fact is that I need to =
keep
> >> track on files, it's the real thing I work with)
> >>
> >> pd: Sorry about my Argentinian-English (if it sounds so)
> >>
> >> Thanks,
> >> Dario
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe git" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> > Is all files present in your latest commit? Or can there be deleted
> > files that you also need to recover?
> >
> > --
> > Med v=E4nliga h=E4lsningar
> > Fredrik Gustafsson
> >
> > E-post: iveqy@iveqy.com
> > Tel. nr.: 0733 60 82 74
> >
>=20
> Every file in the latest working tree is also a tracked file. The
> files are being added to the git repo, but not removed from it.
>=20
> In other words, the biggest set of files is the latest working tree,
> and the smallest one is the first commit.
>=20
> Dario

I can't see a pure git way of doing this. However, you already seem to
use git in a very hackish-way. So here's a quick n' dirty solution (tha=
t
is not very efficient).

(not tested example code, that should be runned from the root-gitdir.):

#!/bin/sh
git reset --hard HEAD
for f in `find`
do
	commit=3D`git log $f | grep commit | tail -1`
	git checkout $commit $f
done

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

E-post: iveqy@iveqy.com
Tel. nr.: 0733 60 82 74
