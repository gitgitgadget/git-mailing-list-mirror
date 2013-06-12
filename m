From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Exact format of tree objets
Date: Wed, 12 Jun 2013 14:06:24 +0000 (UTC)
Message-ID: <loom.20130612T160455-551@post.gmane.org>
References: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com> <7v4nd4bigv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 16:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umlka-0001p5-BD
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 16:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab3FLOKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 10:10:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:46408 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756210Ab3FLOKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 10:10:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UmlkR-0001is-Uv
	for git@vger.kernel.org; Wed, 12 Jun 2013 16:10:03 +0200
Received: from epo198.neoplus.adsl.tpnet.pl ([83.20.56.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 16:10:03 +0200
Received: from jnareb by epo198.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 16:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.20.56.198 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227619>

Junio C Hamano <gitster <at> pobox.com> writes:
> Chico Sokol <chico.sokol <at> gmail.com> writes:
>=20
> > Is there any official documentation of tree objets format? Are tree
> > objects encoded specially in some way? How can I parse the inflated
> > contents of a tree object?
> >
> > We're suspecting that there is some kind of special format or
> > encoding, because the command "git cat-file -p <sha>" show me ...
> > While "git cat-file tree <sha>" generate ...
>=20
> "cat-file -p" is meant to be human-readable form.  The latter gives
> the exact byte contents read_sha1_file() sees, which is a binary
> format.  Essentially, it is a sequence of:
>=20
>  - mode of the entry encoded in octal, without any leading '0' pad;
>  - pathname component of the entry, terminated with NUL;
>  - 20-byte SHA-1 object name.

I always wondered why this is the sole object format where SHA-1 is in =
20-
byte binary format and not 40-chars hexadecimal string format...

--=20
Jakub Nar=C4=99bski
