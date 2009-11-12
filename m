From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Thu, 12 Nov 2009 09:11:10 +0100
Message-ID: <a2633edd0911120011u34d69100p1565ab5bf96a7709@mail.gmail.com>
References: <4AF9E7FE.3060701@obry.net> <4AFA91BB.7050402@obry.net>
	 <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com>
	 <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net>
	 <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net>
	 <20091111224454.GA16178@dcvr.yhbt.net> <4AFBADA9.3060401@obry.net>
	 <20091112071121.GA569@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 09:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Um1-0002Qz-2D
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 09:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbZKLILJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 03:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbZKLILJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 03:11:09 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42477 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbZKLILI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 03:11:08 -0500
Received: by bwz27 with SMTP id 27so1907609bwz.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 00:11:12 -0800 (PST)
Received: by 10.204.36.202 with SMTP id u10mr2708411bkd.196.1258013470445; 
	Thu, 12 Nov 2009 00:11:10 -0800 (PST)
In-Reply-To: <20091112071121.GA569@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132745>

Eric,

> Oh... =A0Any chance that lost commit you couldn't find was clobbered
> by filter-branch? =A0That would explain a lot...

I still have the AWS repo as it was from initial import. And I can see
the commit
on this one:

$ git log --all --parents | grep d2cf08bb67e4b7da33a250127aab784f1f2f58=
d3
commit bd95b2b254286e6f04015b7f58266d66abc134a7
d2cf08bb67e4b7da33a250127aab784f1f2f58d3
commit d2cf08bb67e4b7da33a250127aab784f1f2f58d3
406eaf7e51229f60048ea80cdb6904e33ef59a81

So that's definitely a problem with the filter-branch. Thanks a lot
for your precious help!

Will review the procedure for filtering branches :(

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
