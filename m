From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archive and trailing "/" in prefix
Date: Thu, 08 Oct 2009 23:50:52 -0700
Message-ID: <7vpr8x5acz.fsf@alter.siamese.dyndns.org>
References: <loom.20091008T172303-658@post.gmane.org>
 <4ACE177E.209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9P1-0007Wp-I6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbZJIGvn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 02:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbZJIGvn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:51:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbZJIGvm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 02:51:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D99B51B32;
	Fri,  9 Oct 2009 02:51:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4+0ZJbAPXtwY
	90lwShce0YS4oJQ=; b=IrTByYgOlnANn9m1SzhKR94QZnK6+bA+bJhsxpXhw5yw
	izySYZZCaqw9kLeXlf50/oxcC7acCQfxTJeO+dmI2NN5wCWkflJPDRuuridMr6wT
	GdTsiQPpQX4FttQPw0gfVFu98Nw34LBsuJh6lgumG/UnTTFg2g55aULLiJKKYyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OmmQac
	l6clUgr3uXC56/iJG2wNh0ITQhFIFTbiKxaFiSFJrL0IsNKqTjMSIxYGZzVNR3vZ
	Q24Xj/z88aTUMr/zJ7TcWY3zOyyhYG+FQaV/tKC7iH9pHzG+tjVQXGR30nUTSxdv
	VMSSEg5PKUjnesZFtRSo5xesz9q7+s0qsBlg4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C8FA51B30;
	Fri,  9 Oct 2009 02:50:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A18D451B2F; Fri,  9 Oct
 2009 02:50:53 -0400 (EDT)
In-Reply-To: <4ACE177E.209@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu\, 08 Oct 2009 18\:46\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 198CF020-B4A0-11DE-AC09-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129745>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Sergio Callegari schrieb:
> ...
>> As a matter of fact, the archiver behaves quite strangely if that sl=
ash is
>> missing. Files in the root of the working dir are added to the archi=
ve with
>> their own name modified by the prefix and the same happens for worki=
ng dir
>> sub-directories. However, no file present in the sub-directories, no=
r
>> sub-sub-directories are added.
>
> The latter is a bug.
> ...
> The following patch fixes...

Thanks.  Applied with a trivial test.
