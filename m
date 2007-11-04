From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 04 Nov 2007 10:43:02 +0100
Organization: At home
Message-ID: <fgk476$lha$1@ger.gmane.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 10:43:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioc1B-0008Nd-2t
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbXKDJnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 04:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbXKDJnb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:43:31 -0500
Received: from main.gmane.org ([80.91.229.2]:51721 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbXKDJn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:43:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ioc0k-0001D0-D4
	for git@vger.kernel.org; Sun, 04 Nov 2007 09:43:18 +0000
Received: from abvk230.neoplus.adsl.tpnet.pl ([83.8.208.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 09:43:18 +0000
Received: from jnareb by abvk230.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 09:43:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvk230.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63371>

[Cc: Junio C Hamano <gitster@pobox.com>, git @vger.kernel.org]

Junio C Hamano wrote:

> * jn/gitweb (Sat Nov 3 00:41:20 2007 +0100) 9 commits

Now that I have sned those patches ;-) I have a few doubts about them

> =A0+ gitweb: Use config file for repository description and URLs
> =A0+ gitweb: Read repo config using 'git config -z -l'

I'd like some comments on that series, preferably by someone better=20
with Perl than me, but I think this is a good change performance wise.

> =A0+ gitweb: Add tests for overriding gitweb config with repo config

More tests is always good.

> =A0+ gitweb: Use href(-replay=3D>1, action=3D>...) to generate altern=
ate
> =A0 =A0views
> =A0+ gitweb: Use href(-replay=3D>1, page=3D>...) to generate paginati=
on
> =A0 =A0links
> =A0+ gitweb: Easier adding/changing parameters to current URL

Now I'm not so sure about this, because it changes semantics of "next p=
age"
and alternate view links: after this series they count from current
version, not from the displayed version.

But perhaps those doubts are unnecessary...

> =A0+ gitweb: Remove CGI::Carp::set_programname() call from t9500 gitw=
eb
> =A0 =A0test

This removes unnecessary code, which can cause mysterious errors.

> =A0+ gitweb: Add 'status_str' to parse_difftree_raw_line output
> =A0+ gitweb: Always set 'from_file' and 'to_file' in
> =A0 =A0parse_difftree_raw_line

This simplifies gitweb code, and I think there aren't any issues with t=
hose
patches.
=20
> Will push these out to 'master' over the weekend.

Thanks.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
