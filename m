From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fallback to system-wide config file if default config does not exist
Date: Wed, 26 Mar 2008 20:20:52 +0100
Organization: At home
Message-ID: <fse7mi$pop$1@ger.gmane.org>
References: <20080326181119.25618.qmail@065038ef0fc11c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 20:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JebBy-0005rZ-BS
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 20:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbYCZTVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2008 15:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYCZTVB
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 15:21:01 -0400
Received: from main.gmane.org ([80.91.229.2]:59805 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbYCZTVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 15:21:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JebBA-0001Ex-Ea
	for git@vger.kernel.org; Wed, 26 Mar 2008 19:20:56 +0000
Received: from abwg153.neoplus.adsl.tpnet.pl ([83.8.230.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 19:20:56 +0000
Received: from jnareb by abwg153.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 19:20:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwg153.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78300>

Gerrit Pape wrote:

> From a distribution point of view, configuration files for applicatio=
ns
> should reside in /etc/. =A0On the other hand it's convenient for mult=
iple
> instances of gitweb (e.g. virtual web servers on a single machine) to=
 have
> a per-instance configuration file, just as gitweb currently supports
> through the file gitweb_config.perl next to the cgi.
>=20
> To support both at runtime, this commit introduces GITWEB_CONFIG_SYST=
EM as
> a system-wide configuration file which will be used as a fallback if =
the
> config file sprecified throug GITWEB_CONFIG does not exist.
>=20
> See also
> =A0http://bugs.debian.org/450592

Acked-by: Jakub Narebski <jnareb@gmail.com>

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
