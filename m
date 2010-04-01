From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Is there interest in reading ~/.gitconfig.d/* and
	/etc/gitconfig.d/*?
Date: Fri, 2 Apr 2010 00:03:59 +0200
Message-ID: <20100401220359.GA37149@book.hvoigt.net>
References: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 00:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxSUr-0008Qt-SD
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 00:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab0DAWEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 18:04:04 -0400
Received: from darksea.de ([83.133.111.250]:50534 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753444Ab0DAWEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 18:04:01 -0400
Received: (qmail 14847 invoked from network); 2 Apr 2010 00:03:59 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 2 Apr 2010 00:03:59 +0200
Content-Disposition: inline
In-Reply-To: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143754>

On Thu, Apr 01, 2010 at 09:20:46PM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> I've patched Git to read ~/.gitconfig.d/* and /etc/gitconfig.d/* in
> addition to reading ~/.gitconfig and /etc/gitconfig where it would
> normally do so. the gitconfig.d/* files are read in numeric sort orde=
r
> as is the custom with such files and read after the main .gitconfig
> file so they override it.

I like the idea and it would be great if we could extend it to hooks as
well. I know that you can implement hooks that themself read such a
structure but its not that neat as git handling this itself.

That would be a great way to distribute configurations to users as you
could say: "Put this file into your gitconfig.d/hooks.d folder and you
get this and that kind of configuration."

cheers Heiko
