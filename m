From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Meaning of double + and - in Gitk's diff pane
Date: Mon, 21 Mar 2011 12:37:38 -0700
Message-ID: <7vr5a0p8n1.fsf@alter.siamese.dyndns.org>
References: <4D879B25.9090300@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1kvJ-0002oH-7b
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab1CUThs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:37:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab1CUThr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 15:37:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1443441AE;
	Mon, 21 Mar 2011 15:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rlIkb9zLF4ND
	Naxh1tjSX1xKAP0=; b=hbGhfZG2ALng8RyCr+DbniMKBxaBqvoApvTLsEVH9qjo
	E/YSo+Olx6gjEuJGgBWQOsuIS4nLzV1wRNVytbsbCef/rveya/Bw9joykqKe9qc1
	PjLs7dpSTbmuD5QI+9dMafV0bh9u56D3TyDDKNJf3yV/rEo9NsV7Ux8rdSixgQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E4mEvR
	RaoFAb+KEqfgisvjmh6wL6IKo2WI1A36QcX5K5ac690mhfOr5ecxy+jpN5eTsNCF
	bpFpQTsdALdUkFFRvHbPD6hN2u+aU8Y+50qpNAkzFEcAqN0LeiiNMnmoM+R1/GpN
	l6MyLHJFQ8C8SUROqFgQiu8ZYrcbovE3ga1J4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6F6841AD;
	Mon, 21 Mar 2011 15:39:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 003FB4196; Mon, 21 Mar 2011
 15:39:19 -0400 (EDT)
In-Reply-To: <4D879B25.9090300@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Mon, 21 Mar 2011 19:38:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC0E5B5E-53F2-11E0-A3DD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169647>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> I regularly use gitk to get an overview. Great tool.
> But sometimes it shows me in the diff pane lines preceeded
> with two + or - signs or they are colored in blue or black
> or printed in bold. I think this is true for merge commits
> with conflicts.

Look at the bottom summary of this message for a brief summary:

  http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=3D=
15527

If you want to know more about how the multi-way diff is condensed, you
would find this message from Linus in the same thread illuminating:

  http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=3D=
15600

(Ignore the bottom part where Linus complains about gitk output---the o=
ld
implementation in gitk has gone long time ago).

And also this one, again from Linus:

  http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=3D=
15491
