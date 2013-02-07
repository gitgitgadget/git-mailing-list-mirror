From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 06 Feb 2013 16:12:10 -0800
Message-ID: <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3F6a-0006c2-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 01:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab3BGAMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 19:12:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757945Ab3BGAMV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 19:12:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6607BB29A;
	Wed,  6 Feb 2013 19:12:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HMkR8i2ixW1z
	b7Y7giFUl9Gn3Ck=; b=lABNqIQxlPwMpJHIKE0KjmhBidxBuhXapkh+6bLdgzVn
	dhPJT8xEbqVxeiNyQl3y49Q4cUwOm9GqfS1U7PXvhuFEahI5fmOY+TwyBkBo3lOS
	w96yZwquE3QgK40ddLXflK5P+EbM8iQZtV6eoHJROaIP+LoLoyhEtHuV3zjMfkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fwBYsO
	JCWlXUUUUS2xJKSWJT+hlccT2DGHb+MfVz4Ok9nz61kuYkbXEmgpLhxHIB7w40ui
	cNImCIQmFrC/7lQ1yjrBxi7A2XkHekD8FtxA9/dIvywlCkwqCEBdqUlOKNhpUwT2
	DCzaabPIP+/kgyI7uaxzAoQRvQbemkhPjYq1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2280FB295;
	Wed,  6 Feb 2013 19:12:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A343B27E; Wed,  6 Feb 2013
 19:12:19 -0500 (EST)
In-Reply-To: <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 6 Feb
 2013 23:26:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 095DF3FE-70BB-11E2-BC4B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215667>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think there's a simpler way to do this, which is that:
>
>  * New clients supporting v2 of the protocol send some piece of data
>    that would break old servers.
>
>  * If that fails the new client goes "oh jeeze, I guess it's an old
>    server", and try again with the old protocol.
>
>  * The client then saves a date (or the version the server gave us)
>    indicating that it tried the new protocol on that remote, tries
>    again sometime later.

=46or that to work, the new server needs to wait for the client to
speak first.  How would that server handle old clients who expect to
be spoken first?  Wait with a read timeout (no timeout is the right
timeout for everybody)?

> We already covered in previous discussions how this would be simpler
> with the HTTP protocol,...

Yes, that is a solved problem.
