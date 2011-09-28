From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 09:45:21 -0700
Message-ID: <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Olsen\, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Joseph Parmelee <jparmele@wildbear.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 18:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8xGF-0003CV-47
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 18:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab1I1QpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 12:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab1I1QpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 12:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F24A4DD2;
	Wed, 28 Sep 2011 12:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9HtuQ1x5VVDXmfZUHUkjyAHdmMM=; b=J2RGly
	i/sTTfRyd5nyoZ6CFJWx5L3DGfqPTTuMX+AV0woOc018cV+jp+g4hsVJcLFatmUd
	+XN0yL6oiJ3uTW0jMbGDmXmyiiMSGy0o4FEdywlp+CLbe7cd2QfxS9qR39m1XEqO
	wXpyBngXOMlC/y+PUGR+c+CFP2uawKc0EfX2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gFKUs54k5Q7wlkTCH76vwoYM92oapkWk
	iZ+rHCnFWdK1vRtVvcAqKzOI3N9jtzZhkWPP/E25MppUTs/fR2vwDJ0CwfCsu8vt
	bsX+Gnq+bI/IK1VjJaT7HVsAXBYBTwoC0VV3XZIxAs7pY5uLgo5HSsI8p4wc1Iv2
	kCxeKgHIPnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 862804DD1;
	Wed, 28 Sep 2011 12:45:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 197794DD0; Wed, 28 Sep 2011
 12:45:23 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.1109280555460.25187@bruno> (Joseph Parmelee's
 message of "Wed, 28 Sep 2011 06:36:10 -0600 (CST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42610ABC-E9F1-11E0-A7A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182343>

Joseph Parmelee <jparmele@wildbear.com> writes:

> There is confusion here between the repository and the tarball.  Once you
> have produced the tarball there is NO cryptographic protection against
> forgeries unless you sign it with GPG.

True.

If I give you a URL http://code.google.com/p/git-core/downloads/list with
checksums

  $ sha1sum git-1.7.7.rc3.tar.gz
  c6ba05a833cab49dd66dd1e252306e187effbf2b  git-1.7.7.rc3.tar.gz

You either have to trust that code.google.com/ is not broken, or this
message is coming from real Junio (provided if you can trust him in the
first place).

BUT.

The world is not so blank-and-white. Trust is ultimately among humans. If
this message is not from the real Junio, don't you think you will hear
something like "No, that c6ba05... is forgery, please don't use it!" from
him, when he finds this message on the Git mailing list?  If he does not
exercise diligence to even do that much, does he deserve your trust in the
first place?

GPG does add security (if you have the key) but you can do pretty well
even without it in practice.

> It is only because kernel.org exercised due diligence in the production of
> tags and signatures on all their tarballs that the kernel code itself
> withstood their recent intrusion....

I do not think that is true at all. Developers just dropped *.tar.gz on a
'master' machine, and left the rest to a cron job that reflates the
tarball into *.tar.bz2, sign both using a GPG key, and mirror them to the
public-facing machines 'www'.

Somebody who had access to the 'master' machine could add a new tarball
and have it go thru the same exact process, getting signed by the cron.
