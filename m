From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn and *lots* of ssh connections
Date: Thu, 11 Jun 2009 09:52:02 +0200
Organization: Home - http://www.obry.net
Message-ID: <4A30B7A2.709@obry.net>
References: <cccedfc60906100709r18364bc2h82d8e1a7ee0b8fd1@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 09:52:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEf52-0007jy-5P
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 09:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZFKHwC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 03:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbZFKHwA
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 03:52:00 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:51817 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbZFKHwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 03:52:00 -0400
Received: by fxm9 with SMTP id 9so1332006fxm.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 00:52:01 -0700 (PDT)
Received: by 10.103.229.12 with SMTP id g12mr1151461mur.87.1244706721193;
        Thu, 11 Jun 2009 00:52:01 -0700 (PDT)
Received: from ?192.168.0.113? (629648585p001.rain.fr [81.80.241.97])
        by mx.google.com with ESMTPS id b9sm16634884mug.39.2009.06.11.00.52.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 00:52:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
In-Reply-To: <cccedfc60906100709r18364bc2h82d8e1a7ee0b8fd1@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121329>

Jon Nelson a =E9crit :
> Basically, during the fetch stage (or clone) git-svn uses a *ton* of
> ssh connections. Many dozens and in even with smaller projects well
> over a hundred. By "small" I mean a .git of less than 6MB and less
> than 60 files in the checkout. I've got 4MBit bandwidth available but
> frequently see only a single digit fraction of that going to the
> fetch/clone process. Is there anything that can be done to reduce the
> number of ssh connections involved? Why can't a single connection
> simple be re-used? I can't use "ssh connection sharing" for a variety
> of reasons that aren't relevant here.

I don't know if git-svn can be improved but I would go with a reusable
ssh connection (this is not working with Cygwin though).

See for example (but lot of web site talk about this):
http://www.cyberciti.biz/faq/linux-unix-reuse-openssh-connection/

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
