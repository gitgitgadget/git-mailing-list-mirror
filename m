From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Sun, 26 Aug 2012 11:56:16 -0700
Message-ID: <7vvcg5trcf.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: greened@obbligato.org, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5i0W-00057v-T9
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab2HZS4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 14:56:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970Ab2HZS4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 14:56:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12C4491EA;
	Sun, 26 Aug 2012 14:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rwpn4TVV/AmgJB3ach38T0T7wF0=; b=NhkEy0
	OZoJiaAeNxuMLIpKq5u2CSVa24POGWeQ1fEL/GDQ9UFjEcZQ/5gmN27F4vGV6Rop
	hR/hPhm/+L29Vb2pj4SXvxeB8RhVWObYQfHYRVWc0rgP0cCFamyMdCSNMg/zlfMZ
	Bn+F/PHzQoYNjOLQLw+B8gcwbf6nYGrGwOuWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjRUMQqVJPk6+BC7KFYrES2fPrdPgKHj
	JWonCpALn1/SasQDJePnoDIKjAInp2LWph01zw9x9WQrIoi/ScpYp3j3B5u/p/hy
	wtZaS6iTADRLHrcbZEkBUbvZ1iTTQZO8pNgqDMlaI8AQlhbP3AKNA30wi+14trrF
	5BasyfgFHtU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0050391E9;
	Sun, 26 Aug 2012 14:56:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76D4A91E8; Sun, 26 Aug 2012
 14:56:17 -0400 (EDT)
In-Reply-To: <7vharpv77n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 26 Aug 2012 11:28:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B782BE0C-EFAF-11E1-A0B2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204311>

Junio C Hamano <gitster@pobox.com> writes:

> Looking at the build dependency of libgit2 itself, I do not think
> tighter integration of the libgit2 itself into the git-core is not
> likely to happen very soon, and also is not necessarily a good thing
> to do.

Obviously I meant "I think it is not likely to happen and is not
necessaryly a good thing".  Dumb double-negatives.
