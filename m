From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sun, 21 Mar 2010 11:51:56 -0400
Message-ID: <20100321155156.GH27676@inocybe.localdomain>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu>
 <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
 <1269119663-sup-5823@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="iSeZnk6FyAS3EJ1y"
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Mar 21 16:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtNRp-00075g-5I
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 16:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab0CUPwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 11:52:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0CUPwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 11:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B762CA4A18;
	Sun, 21 Mar 2010 11:52:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=tpW4XMvEYFfwry2PHpDbvV3Y4yU=; b=Ia4RBKz
	VDwf1swuKCEjCHrxBN0OBUehxX2KCNznNkoEhuEDs1KfX50poLL6ViiPCHbpAMNa
	AMyYB/VM3sEFlnSmEXeiXf+WrQ8DTchqsefgtT/0aaLCMLsuNgjhFvcmvpTPEMwD
	FzsovjdD18/EOVcr22eZQY0cT3j6byY9agYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=NQAJGuNc2Wm7/YOWIkR90LFOpZEkMp1kV
	xyCE9ftQz7GyWJ73YnilGqWXzriknBc/ZMuds2JaL2QQXROpSnYyaF27BmtPTw6K
	sGubW+uJntU/741HdiZ3ZCymOMNh3CFdWLNmvAeBHT3cffcygHrwfBtskFQ1doh/
	mKB2Ous6xU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 943A6A4A17;
	Sun, 21 Mar 2010 11:52:00 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AC83A4A16; Sun, 21 Mar
 2010 11:51:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1269119663-sup-5823@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: AFD6DC08-3501-11DF-8993-D033EE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142832>


--iSeZnk6FyAS3EJ1y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ben Walton wrote:
> Excerpts from Junio C Hamano's message of Sat Mar 20 16:12:34 -0400
> 2010:
>
>> looks sensible.  May I ask for what distribution you are "handling
>> it"?  The last thing I want to do is to get in the way of distro
>> packagers.
>
> I can't say it's _the_ global definition for RPM based distros, but
> I suspect the redhat derived ones would use this location.  I'm
> working against RHEL5.
>
> The info that Ian provides seems to corroborate this hypothesis.

FWIW, upstream bash-completion is no longer handled by Ian.  The
current upstream is at http://bash-completion.alioth.debian.org/

The paths haven't changed currently, though I thought I read that
eventually they'd like to move the default location for completion
scripts to /usr/share/bash-completion/ (many are already installed
there, but are symlinked to /etc/bash_completion.d by bash-completion
packages (in the Fedora/EPEL packages via %triggers when the
applications they complete are installed).

Also worth noting for RHEL/CentOS 5 folks is that the current Fedora
packages should rebuild cleanly on those systems.  Typically, I do
this via mock, which sets some of the needed rpm macros, but they are
also available in the buildsys-macros package=B9.  I'm hoping to move
git in EPEL to a newer version at some point but I haven't made time
to do so yet.

I also haven't made time to see what, if any, of the changes we've
made in the Fedora packages might be worthwhile to integrate into the
git.git rpm spec file. :/

The Fedora packages install the completion scripts by default.  The
completion is only sourced when someone has installed bash-completion,
so the thought is that if you installed that you would want git to
provide completion by default.  For those that only want git
completion without the more general bash-completion package, it's
simple to source /etc/bash_completion.d/git.  In that light, is there
a compelling reason not to install the completion by default?

=B9 http://buildsys.fedoraproject.org/buildgroups/rhel5/i386/
  The may eventually be added to the epel-release package to make it
  simpler to rebuild EPEL packages (and Fedora packages on EPEL).

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
People are crazy and times are strange
I'm locked in tight, I'm out of range
I used to care, but things have changed


--iSeZnk6FyAS3EJ1y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLpkCXJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjw7cH/1X6VSgUhU+aLcugZ/RAazha9ttodQCOUR3F
nm0XYx8R5Ev5UmcIhteGc60YvqxkgHpKdmZIAaSGfCXkSVR+t8NzwGrb/0YcY8dR
B0Xm6IhUk2NaDAHU3M9KlgPMRq818T4ime+iA6xKJl3jrZZpdR/1zMu9tYufFP02
7TQJJywUcTkSuuMLR5ssv4hUt+EL+yd0izukjb/x475ugDDb27Fa8SXBX72B19DV
ODSuHhhFYIfFL+P18zQigyoVUeiddHW9fUresSZRa7db06hI7EoYn3bcLIkOKL39
ZnRjPBBqor4aTYkEKN8aYhu+ah94l4Jw4WqtAEhYaSVsWNRS4tg=
=iQZU
-----END PGP SIGNATURE-----

--iSeZnk6FyAS3EJ1y--
