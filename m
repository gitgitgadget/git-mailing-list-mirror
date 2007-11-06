From: Pascal Obry <pascal@obry.net>
Subject: Re: git pull opinion
Date: Tue, 06 Nov 2007 19:07:04 +0100
Organization: Home - http://www.obry.net
Message-ID: <4730AD48.2050907@obry.net>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 19:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpSps-0008Le-OQ
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 19:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbXKFSHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 13:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbXKFSHS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 13:07:18 -0500
Received: from smtp20.orange.fr ([80.12.242.26]:44980 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbXKFSHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 13:07:17 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2029.orange.fr (SMTP Server) with ESMTP id 50E881C00053
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 19:07:15 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-79-163.w81-249.abo.wanadoo.fr [81.249.105.163])
	by mwinf2029.orange.fr (SMTP Server) with ESMTP id E90E01C00094;
	Tue,  6 Nov 2007 19:07:14 +0100 (CET)
X-ME-UUID: 20071106180714954.E90E01C00094@mwinf2029.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63694>

Aghiles a =E9crit :
> Hello,
>=20
> I am not sure this is the best place to write about this. Anyway,
> we just switched a couple of repositories to git (from svn) here
> at work and one thing people find annoying is a pull into
> a dirty directory. Before the "stash" feature it was even worse
> but now we can type:
>=20
>     git stash
>     git pull
>     git stash apply
>=20
> But isn't that something we should be able to specify to the "pull"
> command ? Additionally and if I am not mistakn, those commands will
> create "dangling" commits and blobs. So one has to execute:
>=20
>     git prune
>=20
> Is there an "easier" way to pull into a dirty directory ?=20

I'm using:

$ git config --global alias.update '!git stash && git pull && git stash
apply'

Then in a git repository just do:

$ git update

> ps; if someone is interested to hear what is the general opinion
> on switching to git from svn in our company, I could elaborate.

Would be nice to hear about that indeed.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
