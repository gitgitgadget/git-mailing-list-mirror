From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Sun, 19 Jun 2011 22:59:23 -0700
Message-ID: <7vd3i9dow4.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
 <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Foley <pefoley2@verizon.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 07:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYXWG-0007N8-Dj
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 07:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab1FTF71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 01:59:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1FTF70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 01:59:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 662582AA4;
	Mon, 20 Jun 2011 02:01:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LAGNTS92lPBdo9YbX+jQVgyknYM=; b=FLz5FY
	lYLOr+128roeTLUcxIIwOQFqbMhp9l57NBT2WhC3VAARXjXsFOwzuVAeYk+Yfkh3
	+vMcfVHk59Dpqt689qAuY8176dAvgeGyZXY1EXSCp1ahscswYXJNXXd/Y9Br1h0W
	t1SZ4Ho7g3HX91MpRJtDE0kiIeELED0zc6zNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxXaUzA3hTP5tqwCmpRdxDWKdVUuHvao
	5XfjKPH39C59QSur1XHeNyR0eq7va+8OoZWLqZjiOp5YWBIGzk4nD/Qg/rL3YHCN
	XnXLhEX7/HRELb4BGTPsB+Qev2j5Yk5bJ1q3Ds/KhDywm9+jELH4ZIiUhvQFaVWn
	u4ZqlPKUzvw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53A0C2AA3;
	Mon, 20 Jun 2011 02:01:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC7512AA2; Mon, 20 Jun 2011
 02:01:36 -0400 (EDT)
In-Reply-To: <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 19 Jun 2011 18:06:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1F10E78-9B02-11E0-B766-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176049>

Shawn Pearce <spearce@spearce.org> writes:

> ... But why is this amount of churn necessary or being
> recommended? What problem does this address? Is that worth the pain
> this puts on every other in-flight change that is still being
> developed, or is already in the review pipeline?

No reason and not recommended; nothing; not worth.

Especially during the pre-release freeze.
