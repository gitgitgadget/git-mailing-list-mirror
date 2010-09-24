From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 19:38:26 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C9CE212.3090507@obry.net>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com> <AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Sep 24 19:38:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzCE8-0001zw-OS
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 19:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab0IXRiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 13:38:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55510 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab0IXRiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 13:38:19 -0400
Received: by wwd20 with SMTP id 20so148647wwd.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Y7rblWA7osHI3CDGkvChiCIuOAeuw1q6q5wbIyUts9s=;
        b=i0YMhLmcc8t57IGP0eO5unjqoM0/Rn73AV5+pV1h/z4cgrjLc0uksUdX/axgOuB7Tr
         R/4miOJqMbTrw4MyhBkVbbqefZxd8TT7EQ4Gvz3mlAdal9IuqFXk2Z6LY+xfKQAWpBpe
         0tqAA7zikkv3Gze9J1Ypls9irvhHfo/7G5+4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=bjj6qW17HmG1b7t1ldkgW2k/PkQvowTMnLzO2GQ+0O1PuFsv4ybXDj1dliJ0DZRWTE
         Nr6mEHWyai91OQ3k1sj7XaUqKwyAXEUGiX5OkhvWcFMWQPaNWa7w5sAj4FYNuUcSfTOX
         nIBOzgal3ipE/5nE0fTcJTwDJ6y6eP4GegyVc=
Received: by 10.216.185.4 with SMTP id t4mr2990633wem.87.1285349897427;
        Fri, 24 Sep 2010 10:38:17 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-51-225.w83-199.abo.wanadoo.fr [83.199.33.225])
        by mx.google.com with ESMTPS id v44sm1502891weq.28.2010.09.24.10.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 10:38:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157026>

Le 24/09/2010 15:08, Tor Arntsen a =E9crit :
> 5.8 as minimum is probably for the best. It's not that just you can
> compile a newer version (5.8), more importantly, Perl 5.8 is availabl=
e
> as a package from those semi-official 3party repositories for most
> systems (at least the *nix systems I have access to), except for thos=
e
> like Irix 6.2 where it's hopeless anyway (perl 5.0). But I only have
> access to irix/aix/solaris/tru64 in addition to Linux.

5.10 is available on Cygwin.

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
