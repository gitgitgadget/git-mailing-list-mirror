From: Pascal Obry <pascal@obry.net>
Subject: Re: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 18:12:54 +0100
Organization: Home - http://www.obry.net
Message-ID: <4905F696.2080406@obry.net>
References: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>	<4905D276.9020308@viscovery.net>	<a2633edd0810270809w7fec93b2rc314cc025f41d41f@mail.gmail.com>	<4905DC90.6050503@viscovery.net>	<a2633edd0810270833q482260b4pf0ae11dcf2d4936f@mail.gmail.com> <2008-10-27-17-39-43+trackit+sam@rfc1149.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 18:14:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuVfY-0007mr-OB
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 18:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbYJ0RNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 13:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYJ0RNG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 13:13:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:63032 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbYJ0RNE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 13:13:04 -0400
Received: by ey-out-2122.google.com with SMTP id 6so853638eyi.37
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 10:13:02 -0700 (PDT)
Received: by 10.86.63.19 with SMTP id l19mr3492577fga.15.1225127582313;
        Mon, 27 Oct 2008 10:13:02 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-40-132.w82-124.abo.wanadoo.fr [82.124.144.132])
        by mx.google.com with ESMTPS id d4sm288576fga.5.2008.10.27.10.12.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 10:13:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.17) Gecko/20080914 Thunderbird/2.0.0.17 Mnenhy/0.7.5.0
In-Reply-To: <2008-10-27-17-39-43+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99246>

Samuel Tardieu a =E9crit :
> Why do you do a "rebase" in this case rather than a merge? Doesn't it
> make little sense to record a permission change on a *deleted* file?

Because this is in the context of git-svn, and I really want to rebase
my work before pushing it back to the Subversion repository.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
