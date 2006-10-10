From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 15:14:58 -0700 (PDT)
Message-ID: <20061010221458.85789.qmail@web31804.mail.mud.yahoo.com>
References: <200610102300.16935.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPsR-0006gH-I4
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWJJWPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 18:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbWJJWPA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:15:00 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:26985 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030581AbWJJWO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 18:14:59 -0400
Received: (qmail 85791 invoked by uid 60001); 10 Oct 2006 22:14:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EOKXNWSOeQnRUIGJvpti6Pa34G6Grh9BCBeAC/S93hD/7cz1MMmrVdvEABJ05zB0sBXLIrmFKvXtzCl7EQpmxtFUGP1/NhjWvNJII6cupz8yF+oxx57LW13bnCuIMVL7/wLYFOaVoZMM41cLByQ2TKE/04StQugmWJrSvhC056o=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 15:14:58 PDT
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610102300.16935.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28676>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> > P.S. Notice how there is a "snapshot" link on each line of
> > shortlog, but there is no "snapshot" link in the nav bar
> > of a=3Dcommit. =EF=BF=BDThe "snapshot" link is next to "tree" down
> > in the commit data. =EF=BF=BDThere is also a "tree" link which is a=
lso
> > in the navbar, but "shortlog" is missing.
>=20
> The problem with snapshot is that we can have snapshot of a commit
> (and all links in the top part of navigation bar till now deals with=20
> current commit), and snapshot of a tree, which can be subdirectory
> (and all links in the bottom part of navigation bar deals with=20
> the views/presentations of a current object).

Oh, yes, that's exactly what we need: two links of the same name
("snapshot") in the top row of navbar and in the bottom row of navbar.

     Luben
