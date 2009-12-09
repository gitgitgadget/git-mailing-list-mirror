From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: help: bisect single file from repos
Date: Wed, 09 Dec 2009 17:27:37 +0900
Message-ID: <20091209172737.6117@nanako3.lavabit.com>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net> <4B1D27B6.7010900@bfs.de> <200912080917.17220.chriscool@tuxfamily.org> <4B1E5796.2090201@bfs.de> <7vein5e2lc.fsf@alter.siamese.dyndns.org> <20091209012855.GA3208@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>, wharms@bfs.de
To: szeder@ira.uka.de
X-From: git-owner@vger.kernel.org Wed Dec 09 09:28:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIHu5-0007Sm-Aa
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 09:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbZLII16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 03:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZLII16
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 03:27:58 -0500
Received: from karen.lavabit.com ([72.249.41.33]:43236 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbZLII1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 03:27:54 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id A8D7F15754A;
	Wed,  9 Dec 2009 02:28:01 -0600 (CST)
Received: from 8275.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id UA92KWVNRYMC; Wed, 09 Dec 2009 02:28:01 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=E5A+jq44Ul0w5wdnMBv1cq2qg9oQjpMrUwMtJbNASFR0ERT7F+AM+YUNgKtsprvZmrAMIaNMwHWX0tgXAuX8Ki15BYDmqOY+T0J6eKdmC2QzZYFXASSpDEhwLjl81uXmj2HodsG2eFN/kGbfBpFJbczPz4BLyRb8kCOWPP6PFpw=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091209012855.GA3208@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134946>

Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>

> [1] - 'git cherry-pick' doc says the following:
>
>   <commit>
>     Commit to cherry-pick. For a more complete list of ways to spell
>     commits, see the "SPECIFYING REVISIONS" section in git-rev-parse(=
1).
>
> What?  "A _more_ complete list"!?  Well, it's not very hard to be mor=
e
> complete than this, there is not a single way described here (;

I agree that "more" shouldn't be in that sentence, and I understand you=
r hesitation to read plumbing manual pages, but I don't think it is a s=
ane solution to the issue to repeat how to name a commit in manual page=
s for every single command to bloat the two line description you quoted=
 into a half-page paragraph. Even within that two lines, the real infor=
mation that should be in the manual for cherry-pick is only three words=
 "Commit to cherry-pick" and the rest is to help people who don't know.

Maybe it is a better idea to rewrite this to "See 'basic concepts' manu=
al for how to specify a commit", and create a new 'basic concepts' manu=
al that describes these things the readers must know to effectively use=
 the main part of the manual.  And make sure that we try very hard to k=
eep the 'basic concepts' manual short, by eg. making a goal to keep it =
less than N printed pages.

To decide the value of 'N', somebody needs to first think and list the =
topics that need to be covered by 'basic concepts'. Something like this=
?

 * What are committed states, the state in the index and the state in t=
he working tree.
 * How to name a commit.
 * How to name a range of commit (move part from the rev-parse manual).
 * How to specify options, revisions and files on command line (move pa=
rt from the gitcli manual).

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
