From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sun, 09 Jun 2013 16:29:09 -0700
Message-ID: <7vli6in9ru.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	<7vd2ryueuu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
	<CALkWK0m4V4KYyKW8KJMRsCgOxqcLi0XDYZvS4w++6BKVVvioyw@mail.gmail.com>
	<alpine.DEB.1.00.1306090456160.28957@s15462909.onlinehome-server.info>
	<CALkWK0nCe-fDVdYjD=0XrW-MXBrP1aMrcwdmxfZ_bnM+_esuhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 01:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulp2y-0006YB-GC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3FIX3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:29:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab3FIX3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:29:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 490AF26096;
	Sun,  9 Jun 2013 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bct2NpY05BleZ+kZQPKMVIwKgJM=; b=K+nPqF74T3aJCEZlQvAW
	QejYgbN6KeaZf3If7p2fufNDo+0rNNNY023GkPE8EQolDxPe5kXVqOTEGXiQtue/
	EQO83bfJtHVvEKnr1GJwVz866JUrqdEHCtZbSCO0QhdQJUFG0HX4EY/vqOwocB+G
	qfx8Qr36ZpRRKRtu49D3cTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ic3dAuuRjeN0zdh6rMq67CMxYJaKuSsXYqlXG8mu9Z/H01
	Pm5urNfui/SkV5W3XiKL7U/pEpuxE64NPPhCPPHMkq1GMIONqhjYcEC+ZlpzynDP
	XdY6e0u2i36Z0M/r18my2H66vBNB4CIjxsq2B7FbtUBhh84as+bzTfGBGEyVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DFC326094;
	Sun,  9 Jun 2013 23:29:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CC7F26092;
	Sun,  9 Jun 2013 23:29:10 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 633CD816-D15C-11E2-8DFB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227214>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Do you think that the opinions of
> inactive community members and non-contributors are _more_ valuable
> than those of active contributors, or am I missing something?

I am not Dscho, but it probably is worth saying this anyway.

6d297f81373e (Status update on merge-recursive in C, 2006-07-08)
stole merge-recursive.c from git-merge-recursive.py with an explicit
purpose of making sure that those without a working Python can
perform such a core operation like "merge" with Git without extra
forking.

The person who worked on it, as long as he knows that the project
not just accepted the patch and kept using the code but also that
the project understood the rationale behind that change, does not
necessarily have a reason to appear every week to interject comments
in discussions on any part of the system, even to proposed changes
to merge-recursive.c, as long as the original thing the change meant
to address is not broken (e.g. removing merge-recursive.c and add it
as a merge strategy written in Python or Ruby might trigger "huh",
but ditching merge-recursive.c and replacing it with merge-replay.c
as long as it works would be a "meh" for him).

When otherwise silent old-timers feel a need to come during a
discussion that might affect the course of the project in a major
way, we should pay more attention, not less, to what they say (I am
not saying "we should blindly follow").  They can explain why some
things are as they are, why some changes that may look like a good
idea did not work out and how they failed, etc.

Certainly the opinions from them are no less valuable.
