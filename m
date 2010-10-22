From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 15:59:36 -0700
Message-ID: <7vocalkf53.fsf@alter.siamese.dyndns.org>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 23 00:59:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9QaX-0004KF-Uv
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 00:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0JVW7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 18:59:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab0JVW7r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 18:59:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 200A5E0955;
	Fri, 22 Oct 2010 18:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ng8Hv/9gsstI
	bxZlDgVPCvPSx9w=; b=PLUSXEtU0uYKudMHeqIZJP6YdxGd3dLV1+SnIP/m9gM1
	kOnVu0xPGXbMdpWM/Fju4y5vxSAUkxwT2TLH3TKDTj28rdewDJYEg8U1EMr8L3Nz
	Ll2qnCB8o9atFEYLzrZrSoX5W/EHuqtJT8LLUxvvAaDHrBH/ozvAOs+vDJlgSM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bMEgde
	hP7RvX7xvVjYv3IKdV7eegqiBLsjAJT7B+21HzgsfwQbuVBAbUxwpLb5dFXOhGv8
	vvW2rBgTiKKKdv0k3EmnwmJznJrTBvWcQdZrKRRcH/gVCJY3QbwIhluMJA0gj/KM
	cS/H2TMmx32rC97JHnVgnMnh17IAipTWxj+nI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1EC7E0954;
	Fri, 22 Oct 2010 18:59:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 195B3E0952; Fri, 22 Oct
 2010 18:59:37 -0400 (EDT)
In-Reply-To: <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 (Shawn Pearce's message of "Fri\, 22 Oct 2010 12\:19\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DFE7D5E-DE30-11DF-9DA6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159761>

Shawn Pearce <spearce@spearce.org> writes:

> I think a committee of at least 3 people and at most 5, any of whom
> can be a benevolent SFC liasion, is fine.  As far as selection goes,
> the committee can elect or remove a member through a majority vote,
> and should base its decisions based on surviving contributions to the
> code base, but shouldn't be tied to that (just in case someone
> contributes a lot of good code and then becomes a jerk).

Just a datapoint from quick "blame -C -C -w" run as of 1.7.3.2, countin=
g
surviving lines, 7 top from each area, excluding Documentation/RelNotes=
=2E


** Everything else **

77212        Junio C Hamano
41388        Shawn O. Pearce
32676        Linus Torvalds
28618        Johannes Schindelin
22120        =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
20190        Paul Mackerras
15518        Marius Storm-Olsen


** t/ **

59572        Junio C Hamano
9646         Johannes Schindelin
7606         Eric Wong
7342         Jonathan Nieder
5733         Jeff King
4978         Shawn O. Pearce
4828         Johan Herland


** Documentation/ **

22092        Junio C Hamano
10830        J. Bruce Fields
5566         Christian Couder
3904         Shawn O. Pearce
3664         Thomas Rast
3388         Johannes Schindelin
2888         David Greaves


** contrib/ **

7180         Junio C Hamano
3960         Shawn O. Pearce
3378         Alexandre Julliard
2948         Marius Storm-Olsen
2668         Aneesh Kumar K.V
2624         Simon Hausmann
1254         Matthias Urlichs
