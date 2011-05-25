From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Wed, 25 May 2011 10:20:13 -0700
Message-ID: <7vsjs24rzm.fsf@alter.siamese.dyndns.org>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <1306284392-12034-3-git-send-email-jamey@minilop.net>
 <20110525160708.GE8795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Josh Triplett <josh@joshtriplett.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 19:20:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHl9-0002hn-UJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab1EYRUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 13:20:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab1EYRUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:20:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80B0458AA;
	Wed, 25 May 2011 13:22:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QriIX1G7laQuAAq57l7Sr2Q9BX0=; b=yZUMBB
	osHpuu6klFh5obv3wnZt4ci9SOy6S9oIMcnD+jK/uifK6gxJosbIJmlXrXvCZkLW
	RzJbdL70jU8fC3qb5lAdHtNBEZ3Ci5XT4ScbaDLhRO+tWFrTcaiFjlOZlOGUIyRF
	W8dJy9mrJD4/OZqCTFPY8ZzTgx47sVNswejQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iNXxl5okwOdr8DVaXypYsHh6Orh0W+Z4
	c8Ol6UeQj1WcVg4tEffrneR8ijnrk95EjrVoTdJKcKTpvyvjQd0mvmwQblrV/Pug
	SqjDuNi+e98zj64Y3UPISWiXQ1mzMYAb1yll4cuxAfKwY+OLTSt6AKunNPfIiRTX
	ZXdv0WwLO4w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BBBF589B;
	Wed, 25 May 2011 13:22:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 624465898; Wed, 25 May 2011
 13:22:23 -0400 (EDT)
In-Reply-To: <20110525160708.GE8795@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 25 May 2011 12:07:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94055014-86F3-11E0-A782-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174434>

Jeff King <peff@peff.net> writes:

> I'm curious if you have a use for this much flexibility. In particular,
> why do the HEAD and refs prefixes need the ability to be separate?...
> ...
> So the virtual repository is basically just a "chroot" of the ref
> namespace.

Yes, that makes much more sense than singling HEAD out.
