From: "R. Diez" <rdiezmail-temp2@yahoo.de>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 08:41:08 +0100 (BST)
Message-ID: <1314085268.42103.YahooMailClassic@web25406.mail.ukl.yahoo.com>
Reply-To: rdiezmail-temp2@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"in-git-vger@baka.org" <in-git-vger@baka.org>
To: PJ Weisberg <pjweisberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 09:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvlbo-0005qh-42
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 09:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab1HWHlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 03:41:11 -0400
Received: from nm18.bullet.mail.ukl.yahoo.com ([217.146.183.192]:47345 "HELO
	nm18.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753426Ab1HWHlK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 03:41:10 -0400
Received: from [217.146.183.210] by nm18.bullet.mail.ukl.yahoo.com with NNFMP; 23 Aug 2011 07:41:08 -0000
Received: from [217.146.183.43] by tm3.bullet.mail.ukl.yahoo.com with NNFMP; 23 Aug 2011 07:41:08 -0000
Received: from [127.0.0.1] by omp1028.mail.ukl.yahoo.com with NNFMP; 23 Aug 2011 07:41:08 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 659603.84344.bm@omp1028.mail.ukl.yahoo.com
Received: (qmail 40935 invoked by uid 60001); 23 Aug 2011 07:41:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1314085268; bh=KL5PqCuCaQWCQFyyH95TZAVE/BPaGyAvX9Xj5PU0n5w=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=3Ehlz0SAD60HQDE5cMo1CGic7V62dZGx73TUeJzozkWH5GCD6UoeOe9AxzySqedlVj3G1RBtN5I1D/JJxnoucMPa8vj3SGNXkx+N90qZpEamA2g0hzW3PQSWrib4D1gafYEHEHlEkAghiGkWKlg4FJfFV2+2En1yl0ji2XVrVEw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YJ979TWl5MUTbSfkBt2Uh6Hg4Jf3zAKjRIyQhjWaWxAULIa8wxQxwSa1zhVCsxQB2LclHme9RGJcf3NaKlLQntG7z2U1GMDyg4Qxv76SDggN2s9F7MNe8MsKI8W1mT8ey/TYUNFw4HCMshPaMHil727sZF1R1bTZH0hWt46cf/o=;
X-YMail-OSG: aoeMW4AVM1nNsvfa8VeHvaQ9jI3urGqYP_C6AdMUYOerYh7
 .iaf6ixT3EdLpJCPMP8QQ41jY1tcoOEB0EL13BDwIKozGps8ZGqDNGopjFh0
 G5rJftUtgC1VlNd132y4oNxxgDEsi5u.CJhXJbNecwvcJCHq90Wuzl0APrlX
 0MVBTZfX9DPOvOiEud_tTryZOPvatmLCXwODgEYUH0Jlo.n4xdORk1cEQOl8
 aph.5lN4Ye.AQCHCl2FPPhp2qKhjr_d4h._mvhAt3lmflxp6y_hMAVQq_daH
 whslK3bYd34Yy3tPRjANF0u44acYP5K_yrwOT6KqUVNj540ZLaCbTNQOLuso
 HaMmrWb7bjUjKMUEkqBJQ.9QqGXVXxPEWpSBpS7kA2o0fNNK7mXek6yfbYT_
 0HUhbarrGU6m2X5z6IQ--
Received: from [188.72.244.61] by web25406.mail.ukl.yahoo.com via HTTP; Tue, 23 Aug 2011 08:41:08 BST
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179927>


> "master" is nothing more than a pointer to a
> particular commit. =A0The commit has references
> to its parent(s), from which you can build a
> whole history. =A0In general, Git doesn't
> know the name of the branch a developer had
> checked out when a commit was created.
> In fact, in this example, both branches
> could have been called "master" if they
> lived in different developers' workspaces.

I understand. However, let's see if git can cope with this pretty commo=
n scenario:

Say I'm a developer with too many projects and little time. I don't rea=
lly want to find the commit ID at each release and manually make a note=
 on the project's web site. In fact, I have no "official" releases. The=
 "contract" with my users (or co-developers in my team) is simple: chec=
k out HEAD, it should always work. If it doesn't, last week it worked w=
ell, check out at that point in time and wait until I fix the HEAD.

Now you're saying I cannot reliably checkout last week's versions becau=
se yesterday I did a merge from an older branch? You mean that git stor=
es everything with clean graphs and numeric pointers, so it cannot know=
 what this repository looked like last week?

As the developer, I have full control, I can decide what the branches a=
re called and how the public repository is updated/pushed/whatever. I c=
an control the clock so there are no time skews.

What do I have to do in order to be able to reliably checkout last week=
's versions without too much administrative work? I just want to get th=
e same result today as if I had done a checkout last week from the publ=
ic repository and had made a back-up copy of the working directory then=
=2E

With say CVS and Subversion, that's piece of cake, they already work th=
at way, I don't need to manually keep track of revision IDs or visually=
 inspect the merge tree.

Thanks for your answers,
  R. Diez
