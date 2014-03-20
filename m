From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make XDF_NEED_MINIMAL default in blame.
Date: Thu, 20 Mar 2014 13:45:21 -0700
Message-ID: <xmqq8us4y4ym.fsf@gitster.dls.corp.google.com>
References: <6555655.XSJ9EnW4BY@mako>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Andreen <harv@ruin.nu>
X-From: git-owner@vger.kernel.org Thu Mar 20 21:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQjqQ-0006Rs-N5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 21:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760016AbaCTUpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 16:45:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759883AbaCTUp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 16:45:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 137A2761B9;
	Thu, 20 Mar 2014 16:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5E9wREjXxcJpvYUzzw5XI/iSg0=; b=pqDxLo
	zeoGgXqX7b3hmCKiA3+sJ60u5LCr8eybhqK4XJ4fZr0OtJ55an1B/W9p3p7d1M4G
	p4LoABDunq9EbuV3DB5dRPEcTQUdeub6oop5lXcphD27WvVuFhihI1FVJ6SEdZ2c
	JJetB3CKsKRbXn0LE0Gilws6WCxVDYAHJF+Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rTrrdbB+nmSFRf0l7sLIATfH2AbC0QlI
	zH2YiY/PZgVdYuEBy41GyDJX/xe+oVy26Wl+Z/lLdrvCQRTNmesO7/BASNY+Yz7H
	M4MJHUhTwPCyxDWvldv1x2Gjh67PQPj67CqXJ1C2ij9BwZs42GwKzARQlR94gf2U
	hHOU6aYK0Cs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F381A761B8;
	Thu, 20 Mar 2014 16:45:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50D76761B7;
	Thu, 20 Mar 2014 16:45:24 -0400 (EDT)
In-Reply-To: <6555655.XSJ9EnW4BY@mako> (Michael Andreen's message of "Thu, 20
	Mar 2014 21:18:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F9B3DD2-B070-11E3-876B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244582>

Michael Andreen <harv@ruin.nu> writes:

> There hasn't been any arguments against this patch. Just updated the message 
> with a note about --no-minimal.

There hasn't been any argument for this patch, either.

It is not like we are still in year 2007; timing result in a small
project like Git itself is not a good enough argument to change a
well established default at this late in the game, especially when
there are ways like command line options for users to specify their
preferred settings.
