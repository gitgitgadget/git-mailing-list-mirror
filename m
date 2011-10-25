From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Tue, 25 Oct 2011 07:07:38 -0700
Message-ID: <7vvcrd411x.fsf@alter.siamese.dyndns.org>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 16:07:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIhfP-0008Qs-W7
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 16:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606Ab1JYOHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 10:07:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933533Ab1JYOHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 10:07:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9B8A4CCD;
	Tue, 25 Oct 2011 10:07:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8f61mJsuC5cNVjK6ytoqdQYCJ64=; b=ToSiTw
	VJ+YGshEByCfnLkACjJdG556fAN6gMySfa4ndy678R5qbNfQqnIM/3lnnLW1hYkF
	iP+yF009eZhwCRXXIJv8KUraKlfYKxmHevw02kZ8e7rGrs+sZmw+UfoDfB1h454y
	FL9w9mR5iGq5acs6yQeGwClfqAAQBZxvqkVlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8SN/GYxENO+avrxnH3L3lMCS7X/EoyU
	YaWHRO7gTK08M0tjxV7ulrz3SMa8Xo7RLXhMIVEusvUiis5IIP4fqLIMcrzg7kkZ
	QZnNibrYOTMLzHLEq6d/bW593kudHAdHkaOx5j0vxZIhPfK+FAfv5aac/AhkW6O5
	PwszWTZ1DwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0CC44CCC;
	Tue, 25 Oct 2011 10:07:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D9E84CC8; Tue, 25 Oct 2011
 10:07:40 -0400 (EDT)
In-Reply-To: <20111024224558.GB10481@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 24 Oct 2011 15:45:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B327E88E-FF12-11E0-9F0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184206>

Jeff King <peff@peff.net> writes:

> I mean, besides the obvious that UTF-16 is ...

Yes, you could, besides the obvious. But that obvious reason makes it
sufficiently different that it may not be so outrageous to draw the line
between it and all the others.
