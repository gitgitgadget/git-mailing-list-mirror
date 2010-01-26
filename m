From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix various integer overflows
Date: Tue, 26 Jan 2010 11:58:51 -0800
Message-ID: <7vk4v4zlhg.fsf@alter.siamese.dyndns.org>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 26 20:59:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZrZ1-0004lW-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 20:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab0AZT66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 14:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730Ab0AZT66
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 14:58:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0AZT65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 14:58:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6680191814;
	Tue, 26 Jan 2010 14:58:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z78F+VmVC1/NSdsZz/LZ5nEleM4=; b=PYioI1
	d2kLhnKqSn4OhNts/j8Cu0WJL04eXBHTAt8z+eq+wLs1bZIOtnjoN0W0aGRRPmGL
	3CoAlYbNsV5pwLEj1CQUsNOXl1syLxX6ybn5o7vf3pXNMj34GxMalG1mN7CAHGoY
	mpdd3mpCzhAd9kpBvsstFC/8ofWrjWwEB22j8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ee1AymOpURXT8rbvrCKnYWMpDOdNVz0C
	7MXZQp0Ro3Cg9dn7nuQ2ivCqQU6sjay31oUeVqJZH1bFSj0U6YoPFLWiuYpzbcdr
	tQfhdebcaCf4VT/3SAxrn5E8I6iD2aNKEyZZx6EOInjIJXznspoqK5HQcUkpLGYl
	Gv8+R6E+zA0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D52591813;
	Tue, 26 Jan 2010 14:58:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9374D9180F; Tue, 26 Jan
 2010 14:58:52 -0500 (EST)
In-Reply-To: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Tue\, 26 Jan 2010 20\:24\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BBF7C74-0AB5-11DF-A864-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138070>

Looks trivially correct; thanks.
