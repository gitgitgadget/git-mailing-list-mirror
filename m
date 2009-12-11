From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of
	changes at once
Date: Fri, 11 Dec 2009 19:57:06 +0100
Message-ID: <20091211185706.GA52891@book.hvoigt.net>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net> <20091026193903.GA27319@unpythonic.net> <20091205213613.GG5610@spearce.org> <20091207125435.GA43609@book.hvoigt.net> <20091208003836.GB22330@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:57:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJAfz-0002e6-1I
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 19:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759235AbZLKS5E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 13:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759053AbZLKS5C
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 13:57:02 -0500
Received: from darksea.de ([83.133.111.250]:37633 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758866AbZLKS5B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 13:57:01 -0500
Received: (qmail 16230 invoked from network); 11 Dec 2009 19:57:06 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Dec 2009 19:57:06 +0100
Content-Disposition: inline
In-Reply-To: <20091208003836.GB22330@unpythonic.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135100>

On Mon, Dec 07, 2009 at 06:38:36PM -0600, Jeff Epler wrote:
> On Mon, Dec 07, 2009 at 01:54:35PM +0100, Heiko Voigt wrote:
> > Jeff could you clarify or provide an example?
>=20
> If I recall correctly, the problem with the v2 patch was when the cha=
nge
> was like
>     @@ -13,8 +13,8 @@ set appvers {@@GITGUI_VERSION@@}
>      set copyright [encoding convertfrom utf-8 {
>      Copyright =A9 2006, 2007 Shawn Pearce, et. al.
>=20
>     -This program is free software; you can redistribute it and/or mo=
dify
>     -it under the terms of the GNU General Public License as publishe=
d by
>     +blah blah
>     +blah blah
>      the Free Software Foundation; either version 2 of the License, o=
r
>      (at your option) any later version.
> and the 'blah blah' lines were both staged in the same operation.

Thanks Jeff that was the missing piece. I was able to reproduce the
behavior and I can confirm it is gone with the new series. I was not ye=
t
able to read through all of the code.

cheers Heiko
