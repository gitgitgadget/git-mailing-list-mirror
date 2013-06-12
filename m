From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] instaweb: make the perl path configurable
Date: Wed, 12 Jun 2013 14:00:41 +0000 (UTC)
Message-ID: <loom.20130612T155755-338@post.gmane.org>
References: <20130611201400.GA28010@compy.Home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 16:05:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umlfk-0006F6-8j
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 16:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab3FLOFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 10:05:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:35466 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FLOFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 10:05:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Umlfa-0006AI-PK
	for git@vger.kernel.org; Wed, 12 Jun 2013 16:05:02 +0200
Received: from epo198.neoplus.adsl.tpnet.pl ([83.20.56.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 16:05:02 +0200
Received: from jnareb by epo198.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 16:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.20.56.198 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227617>

Charles McGarvey <chazmcgarvey <at> brokenzipper.com> writes:

> It is convenient for the user to be able to customize the path to per=
l if they
> do not want to use the system perl.  This may be the case, for exampl=
e, if the
> user wants to use the plackup httpd but its extra dependencies are no=
t
> installed in the system perl; they can set the perl path to a perl th=
at they
> install and have control over in their own home directory.
>=20
> Signed-off-by: Charles McGarvey <chazmcgarvey <at> brokenzipper.com>

Is it really necessary?  There is always PERL5LIB if one wants to use P=
erl
modules installed in one's own home directory.  If one is using local::=
lib
one has it "for free".

If they do not want to use system perl there is always perlbrew.

> ---
>  Documentation/config.txt | 4 ++++
>  git-instaweb.sh          | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6e53fc5..e103594 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
>  <at>  <at>  -1549,6 +1549,10  <at>  <at>  instaweb.modulepath::
>  	instead of /usr/lib/apache2/modules.  Only used if httpd
>  	is Apache.
>=20
> +instaweb.perlpath::
> +	The path to the perl executable used by linkgit:git-instaweb[1] to
> +	run gitweb and/or verify that the HTTP daemon is running.
> +
[...]

--=20
Jakub Nar=C4=99bski
(via GMane)
