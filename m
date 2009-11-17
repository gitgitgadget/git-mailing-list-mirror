From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 15:13:28 -0800
Message-ID: <7vzl6kd9t3.fsf@alter.siamese.dyndns.org>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
 <4AFBF18E.7070906@drmicha.warpmail.net>
 <20091114060600.6117@nanako3.lavabit.com>
 <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
 <20091117210625.6117@nanako3.lavabit.com>
 <20091117172815.GH31767@fieldses.org>
 <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
 <94a0d4530911171400ub3b093ai668fd2404b12272f@mail.gmail.com>
 <7v4ooseqvb.fsf@alter.siamese.dyndns.org>
 <94a0d4530911171506o2b08954bw4acba8ea9193e65d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAXFI-0004x5-Q1
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 00:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbZKQXNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 18:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbZKQXNs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 18:13:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZKQXNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 18:13:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9937B80866;
	Tue, 17 Nov 2009 18:13:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WAff//MvD2oaw/umpbNTGExZXe0=; b=IK0ov9
	jIyorYl6a+NLPHN+9MTXTPY9D5FSY0L/O8oS09kvIJ41aAbFzz60TwoAzzEBnSzE
	o8BVdxzUwhhJ7em7o9LJ+0wk0jtUpVtU0TfDMFE2lT/TiJb+mhkpNhaijGrek1sm
	WeTwb3eAdW7Y2H0ap+wAyQfcriJgmze25GzAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bpBRZn04WDLGWMqNEmzSYzQ/iTYh/Mek
	ORnbHXsXHFcbPBqPBOx1ytfSFPgwaZyvkUPG8fw5H7tLs78ElqUuKgi5tJpsoeg2
	D9zJ2hRsQs7auiSv6HNj1VKeMJkbHV+dYEfeE1EMO8hKEh5fRMVZIqrBZF3wQkgA
	qykR/THEOdE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD53880865;
	Tue, 17 Nov 2009 18:13:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B98B980860; Tue, 17 Nov
 2009 18:13:29 -0500 (EST)
In-Reply-To: <94a0d4530911171506o2b08954bw4acba8ea9193e65d@mail.gmail.com>
 (Felipe Contreras's message of "Wed\, 18 Nov 2009 01\:06\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D92D6D86-D3CE-11DE-8E6A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133110>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If the goal of the change is to make things more user-friendly, then
> I'd say "git diff HEAD @stage" is better than "git diff
> --tree-vs-staged HEAD".

Exactly.  That is where we disagree.  The funny "@stage" does not convey
the fact that it is affecting how "git diff" operates, like any other
option like "-R" does in "git diff -R" command line does.  Now the user
needs to know git commands take -option like other normal tools do, but in
addition they need to remember that an oddball "diff" subcommand takes
"@funny" in addition to the usual "-option".

How would that be an improvement?
