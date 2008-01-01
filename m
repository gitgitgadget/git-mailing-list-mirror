From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Tue, 01 Jan 2008 10:12:28 -0800 (PST)
Message-ID: <m3myrpo1p0.fsf@roke.D-201>
References: <477822C3.9060002@gbarbier.org>
	<alpine.LNX.1.00.0712302145500.13593@iabervon.org>
	<47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src>
	<477A26FD.7020408@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 19:13:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9lbn-00009C-6d
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 19:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbYAASMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2008 13:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYAASMc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 13:12:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:29513 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbYAASMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2008 13:12:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2959482fga.17
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 10:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=wmlwC0ADrlAyN3IlwNT1dszJWT5h3ohB+xPN0Di4Sic=;
        b=bMBrEm/jqZJMALlUCEjLvXMsR7ZgnZ0r5rbx8APnj3LHbTAJjGQ5MWEqNGMlyPOni9h8PVWTT9iE4V3lAoVv1j61ndKIApgY+JDxu1OOk7mf1HmFHLF9JXwmyPXicLl8fOhcrqYIJP2Og04EjvnktZfF6xrQmUR4A83o0t7XLxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=nSytVZQ7MM18Vg70kR6zjbPKL4e5zUN2ZOFPw365LTZTeTWMBTcuaU8+fRHZXbyinUsgn4myaImVqZ0E44+AB8Ua58H+NZEPxJiVKFWI1fSx3ZZHiGWmSIpiUzgUT8D+4TDhM03Gx7J7Nfeyd3lkvNwtpJXgDGy7olO8mInvW34=
Received: by 10.82.145.7 with SMTP id s7mr24061770bud.6.1199211150088;
        Tue, 01 Jan 2008 10:12:30 -0800 (PST)
Received: from roke.D-201 ( [83.8.204.248])
        by mx.google.com with ESMTPS id c24sm21073402ika.10.2008.01.01.10.12.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2008 10:12:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m01ICJJu004486;
	Tue, 1 Jan 2008 19:12:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m01IBuNx004481;
	Tue, 1 Jan 2008 19:11:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <477A26FD.7020408@gbarbier.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69440>

Gr=E9goire Barbier <gb@gbarbier.org> writes:

> I think that real HTTP support is better than all workarounds we
> will be able to find to get through firewalls (when CONNECT is not
> available, some awful VPNs that send Etherne over HTTP may work
> ;-)).  That's why I'm ok to work several hours on git code to
> enhance real HTTP(S) support.

There was also an idea to create a CGI program, or enhance gitweb
to use for pushing. I don't know if it would be better way to pursue
to work around corporate firewalls, or not...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
