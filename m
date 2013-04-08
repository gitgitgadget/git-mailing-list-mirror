From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: RFC: Very useful script to SVG graph the git commits from a
 file orientated view
Date: Mon, 8 Apr 2013 12:49:55 +0200 (CEST)
Message-ID: <1230283897.1259692.1365418195898.JavaMail.root@openwide.fr>
References: <CAHQ6N+r7RpV3n+Mb3GEyJim7-bwML_OUmveLZjWcRWp_HF-rNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:27:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEv6-0003oz-KH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935276Ab3DHKt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 06:49:58 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:43068 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934591Ab3DHKt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 06:49:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 7548F280B0;
	Mon,  8 Apr 2013 12:49:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZuzMucNkMcjl; Mon,  8 Apr 2013 12:49:56 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 0574228068;
	Mon,  8 Apr 2013 12:49:56 +0200 (CEST)
In-Reply-To: <CAHQ6N+r7RpV3n+Mb3GEyJim7-bwML_OUmveLZjWcRWp_HF-rNQ@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220417>

so, I started using it this WE for my big rebase=20

I had aproximately 130 non-merge commits in my branch, a feature branch=
 in which I had regularly merged master, but I needed to rebase everyth=
ing and then reorganise most commits to make the whole thing reviewable

* merge bug-fix with the commit that introduced the bug
* change sloppy commit messages
* separate sloppy commit into multiple commits

I did my initial rebase and I am now doing repetitive "git rebase -i" t=
o get everything going

your script is very usefull to me because it allows me to easily see th=
e overall layout of things and figure what commit are "suspect" (touchi=
ng files from different areas that have no reasons to be touched at the=
 same time)

it also allows me to easily find commits that are highly connected to o=
ther ones and are the most likely to be problematic when reordering com=
mits. Overall that script is awesome.

couple of ideas to refine things

* The tooltips are very handy, but it would be nice if the tooltip woul=
d activate on the whole commit ellipsis, not just the text inside the e=
llipsis
* I would love to have tooltips on the arrows too. when trying to follo=
w what arrow is what file it makes things really handi

It would be nice if there were a way to filter only some files in the o=
utput... there probably is with the git-log like syntax but i'm not a m=
aster of that... hints would be welcome

is there a public repo for this script so I can point other people to i=
t ?


    Cordialement

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim

----- Mail original -----
> Opps, somehow I forgot to actually attach it.
>=20
> It's now attached
>=20
