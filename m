From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] t7502 fixes
Date: Thu, 26 Jul 2012 14:15:12 -0700
Message-ID: <7vobn25in3.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
 <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
 <20120726171256.GC13942@sigill.intra.peff.net>
 <7v8ve672ar.fsf@alter.siamese.dyndns.org>
 <20120726193359.GA28711@sigill.intra.peff.net>
 <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 23:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuVP3-0002G6-VX
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 23:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab2GZVPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 17:15:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab2GZVPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 17:15:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1788D8EA7;
	Thu, 26 Jul 2012 17:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xF2jkqX5EaUnYOPlaxKv0B86hVg=; b=DUmsTM
	2VKkhrsmjOxqmaiL4m89dYof7DxuWzpytYodD/IbsgRBJBXvHuwokP4erJkBeI2F
	aqpeYwhKfAlI4LIlAP+xzfVou2+oazG75MyYHky85nKMohAHYSS0dBB5bIqp5tOE
	nhqPFSu0OfEfvGbqIbnfPFRaLElI63ot2Swqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I8p6EzRPhgAJUzMGKYWIR67z3sZVUoiL
	tDl1l/7ul+d0X2rM+/6dmWCdYTDnZu/ezIpL7LWFQcYOWhf1CS5Ak1iHhIplI5UJ
	szRJQvfFz3okz2em4uNj8wTc983wPfrBvP5UqjNg2RoIyyKPL5LXBplj4xsK3xur
	oQv/OeiBOx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 050D48EA6;
	Thu, 26 Jul 2012 17:15:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 768608EA3; Thu, 26 Jul 2012
 17:15:13 -0400 (EDT)
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jul 2012 16:26:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD592670-D766-11E1-B4E5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202310>

All patches look very sensible.  Thanks.
