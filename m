From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri, 05 Aug 2011 19:35:21 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E3C29D9.5060305@obry.net>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 05 19:35:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpOJ1-00088T-DV
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab1HERf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 13:35:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64316 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab1HERfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 13:35:25 -0400
Received: by wyf22 with SMTP id 22so1382916wyf.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 10:35:23 -0700 (PDT)
Received: by 10.216.4.208 with SMTP id 58mr768983wej.93.1312565723778;
        Fri, 05 Aug 2011 10:35:23 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-101-151.w90-2.abo.wanadoo.fr [90.2.59.151])
        by mx.google.com with ESMTPS id em16sm2450038wbb.67.2011.08.05.10.35.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 10:35:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178807>

Le 05/08/2011 19:29, Erik Faye-Lund a =E9crit :
> Cygwin is a unix-layer on top of Windows, designed to play by the
> POSIX-rules. So why would you want to support Windows-style paths on
> Cygwin?

Because cygwin toolset does support \.

> If you want a Git that handles Windows paths, use Git for Windows...

Note that Windows is a special case as even the Win32 API does support =
\=20
and /, so every tool on Windows seems to handle nicely this. Why not=20
Git, be it Cygwin/Git. If it does not break anything else.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
