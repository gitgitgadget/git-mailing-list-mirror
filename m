From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: remove lego in i18n string in gitdiff_verify_name
Date: Tue, 08 May 2012 10:07:33 -0700
Message-ID: <7vd36ewqi2.fsf@alter.siamese.dyndns.org>
References: <7vwr4n6fcj.fsf@alter.siamese.dyndns.org>
 <1336484307-31553-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 19:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnsy-00011O-IZ
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab2EHRHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:07:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756328Ab2EHRHf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 13:07:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 060806F60;
	Tue,  8 May 2012 13:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M+ibz0T+wJjM
	i3koyOpXqCq2Ruw=; b=gaRL+TzVZpxjbZbAVMi/yKUKV4Cq5uj+2uxMpvEmIDsb
	5CLGLecDCx3+wCcbLfGlS6U1lEHsL4EiNiDKLPZHs73fw9QYdpElM6nIUOlz+wdu
	ndHu5FXMZ8yndTOmNlxaqpudkL/TKTsbBDcgjmv42OGXYC647n4oJXVLTqPyUC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PhgJvO
	MzeK0SUsYRwa+VmvY6by7XmguV7NULhc8LzOVy+bdx/rNZpvRkUu+rcrU/InZ8vp
	J//0viE6M/3YaYOBu5lqVvxUAgMtQMl+EvXtlTGmRKyjC4/30/TwBvBryaSS1jHE
	ZI+HDlVtnhl9RavW5VEuqLPb8WvPVygOq4/BY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F050E6F5F;
	Tue,  8 May 2012 13:07:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8304E6F5E; Tue,  8 May 2012
 13:07:34 -0400 (EDT)
In-Reply-To: <1336484307-31553-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 8 May
 2012 20:38:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E17CB2C-9930-11E1-B03E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197395>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Currently it marks the string "...inconsistent %s filename..." where
> %s is either "old" or "new" from caller. From a translator point of
> view, nothing hints what "%s" may be. Make it two strings
> "...inconsistent new filename..." and "...inconsistent old
> filename..."

True.  Also depending on 'old' vs 'new', the translation of "filename" =
or
other parts of the message may have to inflect/conjugate, so the origin=
al
message structure was very unfriendly to i18n.

> +		if (!another || memcmp(another, name, len + 1)) {
> +			if (!strcmp(oldnew, "old"))
> +				die(_("git apply: bad git-diff - inconsistent old filename on li=
ne %d"), linenr);
> +			else if (!strcmp(oldnew, "new"))
> +				die(_("git apply: bad git-diff - inconsistent new filename on li=
ne %d"), linenr);
> +			else
> +				die("BUG: please add a new full string for '%s' similar to above=
 code.\n"
> +				    "It makes translators' life much simpler. Thanks!", oldnew);
> +		}

I think this is way over-engineered.  enum { DIFF_OLD =3D 0, DIFF_NEW =3D=
 1 }
or even passing 'n' vs 'o' was what I was expecting to see.
