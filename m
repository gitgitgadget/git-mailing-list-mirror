From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Wed, 25 Mar 2009 18:32:37 +0100
Message-ID: <adf1fd3d0903251032kba19d27gc066b04081a88082@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
	 <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
	 <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
	 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
	 <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
	 <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
	 <alpine.LNX.1.00.0903242304530.19665@iabervon.org>
	 <7001b7a00903251023r1ce5cc0dnb29b7f9379408c42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Irene Ros <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmWzk-0006l4-2f
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 18:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188AbZCYRcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 13:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757868AbZCYRcm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 13:32:42 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:42667 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbZCYRcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 13:32:41 -0400
Received: by bwz17 with SMTP id 17so145775bwz.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 10:32:38 -0700 (PDT)
Received: by 10.103.175.8 with SMTP id c8mr4296220mup.117.1238002357916; Wed, 
	25 Mar 2009 10:32:37 -0700 (PDT)
In-Reply-To: <7001b7a00903251023r1ce5cc0dnb29b7f9379408c42@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114625>

2009/3/25 Irene Ros <imirene@gmail.com>:
> Hi Daniel,
>
> Thank you for the explanation, doing a git fetch actually did do the
> trick although I still don't quite see the difference between
> git pull origin myBranch

This fetches myBranch from origin, and merges with the current branch.

> and
> git fetch

This fetches and *saves* the configured branches (all by default) from
the configured remote (origin by default).

>
> When I push to origin myBranch it's clear that it actually pushes my
> changes to our remote repository since others can then pull and get
> them. So is it the case that:
>
> git push ==> actual remote repository
> while
> git pull <== local copy of remote repository for this branch ?

I don't know if I understand correctly, but pull always uses the
branches from the remote repository, but depending on how you call it
it will also update the local copy (origin/*).

HTH,
Santi
