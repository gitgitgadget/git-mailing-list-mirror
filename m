From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Conventions on struct copying?
Date: Thu, 19 Jun 2014 10:10:37 -0700
Message-ID: <xmqqvbrwhlki.fsf@gitster.dls.corp.google.com>
References: <20140618233129.GK368384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:10:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxfrO-0004LM-8R
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 19:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbaFSRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 13:10:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61053 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbaFSRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 13:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F5661E6DB;
	Thu, 19 Jun 2014 13:10:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sTcbptHP4eseVSLiZa3wm9FR7S8=; b=v9UIrB
	J2ZQgp3qiIcGqd+xnJAsHzF8QSj+z00Z8HLBVUtNBNId2avLupVqUnIADLBH98QF
	oYRfBhZzE81kd/I1CAavLswddFIj+JDST1ITkMY348UFHIS7C1weBzMc6a0tb/YT
	HtlSx13pvljyYR+XHnl70N2pRfsyIkKr9/azA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXVT7Se40b7Hwgf1AkTYX+3Rdh8QDZA+
	dSzladQgPwP4zOmSTKR/AMI9jn5f9l0jPl1STUj1zwpjbOo+ufiS5J9wtFhWxvsh
	lI0cLGVDxOdaedLebHs9fOF0Jwb+5d3TtDwUe2pZNFTlKcQrm3moqLxgJXu+T6LJ
	TwmcySOMftY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD1681E6DA;
	Thu, 19 Jun 2014 13:10:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F1E031E6D3;
	Thu, 19 Jun 2014 13:10:36 -0400 (EDT)
In-Reply-To: <20140618233129.GK368384@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 18 Jun 2014 23:31:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1BE959E-F7D4-11E3-BF3E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252167>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't know of any place we explicitly copy structs like
> this,...

which should be a reason enough.  The first concrete guideline is
"just imitate the existing code".

> but I don't know of any prohibition against it, either.

So now you know ;-).
