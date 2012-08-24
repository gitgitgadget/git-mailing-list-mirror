From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: GnomeKeyring support + generic helper
 implementation
Date: Fri, 24 Aug 2012 14:46:31 -0700
Message-ID: <7vzk5kx8so.fsf@alter.siamese.dyndns.org>
References: <1345741068-11004-1-git-send-email-pah@qo.cx>
 <7vfw7cyx4n.fsf@alter.siamese.dyndns.org>
 <20120824213342.GB16285@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	"Philipp A. Hartmann" <pah@qo.cx>, git@vger.kernel.org,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:46:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T51iD-0005Zr-I7
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 23:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab2HXVqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 17:46:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2HXVqe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 17:46:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C4899A1;
	Fri, 24 Aug 2012 17:46:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kp6gNc4so0rGka7d1DslSFmlfrA=; b=AvSUh2
	2Tgzoo0FLIlAWoxNAxxCHnvk0H2VQj0ZHQU7TSo8xwOd1vgU1kmVuZB5Q+OXdrlL
	gAVC7974t7vzNhF7FMdVR59O+faJOd7GURxQEMdZF18uZhsa7ntAI8Ne+k5Mo6LC
	zXJDngfJtAs5ElVNUPH9taqL508OwZ7IHtzJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q6gP8z2WE7h6e1QqDYrHqTVx5pJemYCX
	HN3LSL+amrYZcoVED5rQbUfEqSXSaay7hxqLJSCfnpWxRg+xp7Bp8uD8WiYwjvNW
	uTVQ5pn+2vZFQA6x2inLHK7gtVgceCOmzbmdeyKWwIqa+R9bJjrFoZV0fH63gzPE
	hQ4trBogefU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44CC99A0;
	Fri, 24 Aug 2012 17:46:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0EB999F; Fri, 24 Aug 2012
 17:46:32 -0400 (EDT)
In-Reply-To: <20120824213342.GB16285@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 24 Aug 2012 17:33:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B47E6AE-EE35-11E1-84FB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204235>

Jeff King <peff@peff.net> writes:

> However, the shared bits are simple enough that maybe that is not a
> concern. An interesting test would be to add a 5/4 porting Erik's win32
> credential helper, since that is the platform least like our other ones.

Very true.

> So I am OK with this series, but I am also OK with leaving it at patch
> 1, and just keeping the implementations separate.

Amen.
