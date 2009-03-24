From: Pascal Obry <pascal@obry.net>
Subject: Re: git svn teething problems - initial clone okay - fetches not
 working
Date: Tue, 24 Mar 2009 07:41:59 +0100
Organization: Home - http://www.obry.net
Message-ID: <49C880B7.1030307@obry.net>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP> <49C7F92A.5050809@obry.net> <0381B9A616514FC2A05BACAB07EE3117@HPLAPTOP> <c115fd3c0903231458t7ac8ac69if6b7bdb3a7d8861b@mail.gmail.com> <D9560AEA971144C99A0540C08AAFC3D1@HPLAPTOP>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 07:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm0MB-0005mv-KF
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 07:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbZCXGly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 02:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZCXGlx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 02:41:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:58571 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZCXGlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 02:41:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so495257fgg.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 23:41:50 -0700 (PDT)
Received: by 10.86.49.13 with SMTP id w13mr87113fgw.23.1237876910003;
        Mon, 23 Mar 2009 23:41:50 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-49-205.w82-124.abo.wanadoo.fr [82.124.151.205])
        by mx.google.com with ESMTPS id 4sm4222055fge.8.2009.03.23.23.41.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 23:41:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
In-Reply-To: <D9560AEA971144C99A0540C08AAFC3D1@HPLAPTOP>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114404>

Aaron Gray a =C3=A9crit :
> Probably. I am getting an error on doing 'git svn rebase' :-
>=20
> many filenames * : needs update
> update---index --refresh: command returned error: 1

So before the rebase try:

   $ git reset --hard HEAD

then

   $ git svn rebase

> Could you please give me the command to import the above SVN reposito=
ry
> so I can redo the thing from scratch.

What you have done (at least described here in this forum) seems correc=
t.

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
