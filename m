From: Pascal Obry <pascal@obry.net>
Subject: Re: drawbacks to svn server + git-svn vs git server?
Date: Wed, 21 Oct 2009 17:19:02 +0200
Organization: Home - http://www.obry.net
Message-ID: <4ADF2666.1070908@obry.net>
References: <25994334.post@talk.nabble.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dexter Riley <edbeaty@charter.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 17:19:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0cxi-00066t-Ap
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 17:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbZJUPSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 11:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZJUPSn
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 11:18:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:12193 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZJUPSn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 11:18:43 -0400
Received: by qw-out-2122.google.com with SMTP id 9so914503qwb.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 08:18:47 -0700 (PDT)
Received: by 10.102.236.11 with SMTP id j11mr3521450muh.3.1256138326973;
        Wed, 21 Oct 2009 08:18:46 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-56-169.w83-199.abo.wanadoo.fr [83.199.38.169])
        by mx.google.com with ESMTPS id j9sm135128mue.26.2009.10.21.08.18.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 08:18:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <25994334.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130927>

Le 21/10/2009 17:05, Dexter Riley a =E9crit :
> Hello.  My group is currently using subversion on our version control=
 server,
> but would like to move to git as a client.  We are considering using
> git-svn, to avoid revalidating the server software.  My question is, =
are
> there any major disadvantages to using git-svn versus git?  I know th=
at the
> git repository would be smaller.  I'm more concerned about possible s=
vn
> repository corruption, performance when pushing large merges back to =
svn,
> and any gotchas you might have encountered.

Something that come to mind immediately is that you'll loose merge=20
information as Subversion has linear history. I understand that recent=20
Subversion versions have added some information about merges but I don'=
t=20
think git-svn handles this (I don't even know if it makes sense or not:=
).

If you have a single integrator you'll also loose the author name. Keep=
=20
in mind also that git-svn is slower to get new commits from the upstrea=
m=20
repository.

I've used git-svn for a while now without any trouble. And I can say=20
that I won't move back to using an svn client.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
