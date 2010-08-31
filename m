From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Example git hooks (Re: Odd results writing a Git pre-receive
 hook to syntax check PHP files.)
Date: Mon, 30 Aug 2010 21:57:12 -0400
Message-ID: <20100831015712.GT4925@inocybe.localdomain>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
 <4C7B8E1E.6050708@drmicha.warpmail.net>
 <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
 <20100830141602.GF2315@burratino>
 <AANLkTi=GUrnH87faWH8G0tD7_KAynVf_ig0KpQRwnsaE@mail.gmail.com>
 <20100830143411.GH2315@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="sEXf5qLefa2bWrwX"
Cc: Chris Patti <cpatti@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 03:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqG6L-0003BQ-9r
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 03:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab0HaB5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 21:57:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab0HaB5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 21:57:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C4A1D1117;
	Mon, 30 Aug 2010 21:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=cpZxOtvlwsvcU7ksL2n5Wf7fWI0=; b=Ai7hXTN
	jfcty9sIlaIzPtpbEWxJUIBwFRjApB0kc6R6p3P1DybgLmtKwmnUMMBusAFGG0S9
	B3T0QuZ3VSe1qgu6Paa976eEQqF/PHfKTuhAcx/vNQey6chXlvIjENZ0CmXXWf3e
	zgZAuFWJktev1N9ZWJmq24c0V5wJ0PlS+Ff8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=Wk5osLEBnfW5NpJK6x7HmcM+G+W5vn2EA
	fRS/5Mh8afKf3K8x4vRbbkCehtMVUv2WUl+d7P+CG/qLf5Rx8TRze9rfsucS8MyR
	G5MELZ8s7s7gdBtmj72ZcV0rbYVrwH6zqiBSm0aNACJ7buyebVz/unCODLPkw/dn
	g37M4H91lI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 462B9D1116;
	Mon, 30 Aug 2010 21:57:18 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0021D1113; Mon, 30 Aug
 2010 21:57:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100830143411.GH2315@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 15C8794C-B4A3-11DF-93BD-030CEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154877>


--sEXf5qLefa2bWrwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jonathan Nieder wrote:
> Chris Patti wrote:
>
>> (P.S. Is there a canonical 'example Git hooks' location I could
>> publish this to when it's working? I think there's a dearth of this
>> kind of example for people out there right now)
>
> Try the git wiki (git.wiki.kernel.org).  There is a page for aliases
> but no page for example hooks yet (though there are some examples
> under InterfacesFrontendsAndTools).  You could be the trailblazer.
>
> There are also a few examples in git templates/ and contrib/hooks,
> of course.

This reminds me a little of a discussion that came up a while back
regarding syntax checking of puppet manifests.  The resulting hook is
here:

http://projects.puppetlabs.com/projects/puppet/wiki/Puppet_Version_Control#=
Git+Update+Hook

The git list discussion:

http://thread.gmane.org/gmane.comp.version-control.git/118626

Dunno if that'll help you at all or not Chris.  Hopefully it doesn't
hurt at least. :)

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Every side I get up on is the wrong side of bed.
If it weren't so expensive, I'd wish I were dead.
    -- signed Unhappy


--sEXf5qLefa2bWrwX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJMfGFzJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj74EIAKnvVeXVCfQDXuntbIIxezxa/JwrXmQ3brIE
z9rvSke9L5ytIXSgANEQCErkg2WuaMygFzjfqhMTpBATt/cR5j9yvKNEC6YH2OZ4
2/7eI7hF1GTY4DeBEDIQSOZPXSlbaSeozMUcUxCcVMwvDbbMhNUeM2uZ1dKjyEPK
v8h5AzroN0TIAjq6flw0K+m+7pCQytruSDBw4u4vEeI7Vv75HcLqWgWAJanPQgGV
S8MkgKZRse7f7CmVQRZEAIGnZuFvv4ZhdQdEKRj1xTnMyIbQXDRjUBPdtzhKCs4W
fSrbhYwcFAutjM+0CLNJvF+9pbv8Jfm82ZzitP1+dsbKsIjjeVQ=
=Liay
-----END PGP SIGNATURE-----

--sEXf5qLefa2bWrwX--
