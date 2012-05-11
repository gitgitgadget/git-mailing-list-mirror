From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Fri, 11 May 2012 15:46:02 -0700
Message-ID: <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 00:46:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSybL-0001x0-H3
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734Ab2EKWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 18:46:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab2EKWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 18:46:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF85813A;
	Fri, 11 May 2012 18:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hqk/e9wfF5XBPBBoba2mZ9XEPLs=; b=xo+9TJR0Ps+wjM8PQ8lt
	7KiNhGCbWbH7DoNVU0U2xiXeN26qy1dmfr1BtXSFmN9pd/HgyZEkRgTS2LzH7yht
	cZezmAUZDpMzDyqIslnFLVHhYVZu5LBNXaEGloOfcXKoWDy71E44uirapU85pFsI
	jAzaoTH3uepFVXziEsJIIbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lP+vReD2nUeqrcs+Fmxy8qRpe1oAiA0wILfLyORojw7/5L
	JbBvgPjQq9IE+/ViKZqjqYCYcnoH80NCYjsUj0E07L9skuPJi+EoWA/h5KM3gPdN
	FDEVflM59pNsGVr7DHoPXNu7TyM120cdQ47B2UNur9hcAxTjCoZ2tb2twalwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6E028139;
	Fri, 11 May 2012 18:46:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F6658137; Fri, 11 May 2012
 18:46:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16E9D3EC-9BBB-11E1-9907-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197703>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Turns out my reaction is pretty much the same as before.  I still like
> the idea and still am distracted by the spacing.  After the small
> patch below, the log seems peaceful again and I am totally fine with
> it.
>
> 	Merge branch for-upstream of git://git.example.com/subsystem
>
> 	By Fred the Clown
>
> 	* for-upstream: (51 commits)
> 	  foo: bar baz

Two possible factors that may not be visible in the above example are

 (1) hand-written description of the merge itself by the integrator; and
 (2) octopus merges.

With both of these elements, with a blank line after the submaintainer and
the contributor attribution, a sample log output would look like this:

        Merge branches fix-foo and fix-bar of git://git.example.com/subsystem

        Two last minute fixes from Fred, so that we won't have to
        scramble and tell people to upgrade again immediately after
        the upcoming release.

        By Fred the Clown

        * fix-foo: (2 commits)
          foo: fix forboz
          foo: reindent

        By Fred the Clown

        * fix-bar: (1 commit)
          bar: fix nitfol

The attribution to the submaintainer and contributors, the name of the
branch merged, and the list of the individual changes form a single unit
of information "What was done for us by whom".  At least to me, the above
is easier to see without the additional blank line; the even-spacing
before and after the attribution line makes it harder to see where the
boundary between "description by the integrator on the merge" and
"information on the work that was done on the first branch that was
merged" is (and the boundary between the first and the second work, if in
an octopus).

We could add another blank line before the "credit" line.  We would have
two blank lines that separates the integrator comment and the per-branch
block, and also have two blank lines between the per-branch blocks, making
it easy again to see where the boundaries are.

But I do not know if it is an improvement from the current output before
your patch, or if it is just wasting vertical space.
