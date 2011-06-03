From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 0/4] Support ref namespaces
Date: Fri, 03 Jun 2011 16:24:06 -0700
Message-ID: <7v8vtia489.fsf@alter.siamese.dyndns.org>
References: <1307136593-16306-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSdjC-0006Nm-JF
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab1FCXYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:24:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1FCXYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:24:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C5285BA3;
	Fri,  3 Jun 2011 19:26:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=apJiQHAj8VHVNbcB8h3h5FIg0A8=; b=wbtQcC
	67KI9l6/FDsEld5vKH8Se52QnsRpZ09WQOvXvRwZZtYYTLkRFsKFO47bhtvu2SSw
	buDy2EJs2I2wgoQxg/0UiUkqddWXvS4LmVpUwYnzqcsFb/dLWOyP+cDcbkzw67uO
	4qYab5dekKts37WUSfwR0Kes36ESPQVBEtRF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rC2RV+uTNKrvjKYBAIRop6UpIIQtVfKd
	j4Rm5wJV0/RtneQ0FwEebEHVDI9URIy6+73+NdHF8izqHB8hUtUR+eLksn1IdubG
	M5UB4Tob9wtdtlCvxwYwsTA8HeTa+kEK1iorgoDnPp7m/TFOqTWgCo6H/aZxwBvg
	7CEUF4Hm3Ic=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A154C5BA2;
	Fri,  3 Jun 2011 19:26:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9FF2F5BA1; Fri,  3 Jun 2011
 19:26:17 -0400 (EDT)
In-Reply-To: <1307136593-16306-1-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Fri, 3 Jun 2011 14:29:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6FD0BE4-8E38-11E0-8FA0-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175039>

Overall the series look much more understandable than the previous one ;-)
