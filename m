From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] patch-id: make it stable against hunk reordering
Date: Wed, 23 Apr 2014 10:39:23 -0700
Message-ID: <xmqq4n1k0wtw.fsf@gitster.dls.corp.google.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
	<1398255277-26303-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd18u-0006pL-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbaDWRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:39:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbaDWRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:39:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7EA7EE56;
	Wed, 23 Apr 2014 13:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9smekKKU82pqSWoIZEXt/ztEofI=; b=nXf/BA
	vYU4aJaWTR8kRmQ2D+oOHmJT5jHh1vxpsp+4KFSyfF5suqC4JCJ47VlvbLxfeBel
	ehF0GVze+TjjQaxSRnOsYYHRGOoVBswbncgdc+mcRN1Q7w6KoZuDdGCsTyM2AoLJ
	/wLUZY+6qL3xghRpsgFuxBUlXVLvOqWp1eszA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZDXGNF4eA0A8M5VOtQfxmy5BeQLXufVv
	b9cgwCVB/J4fhaZiMNTPJyNlt/zmCqr3uU7gzEFikciEDrDi0mh69kW+qsKsx9v7
	sSiXEsGDGj3RiZBMt4FkJdNmLM+9ZSfiMyU/VOL6wvZkO8hWLMbqvManNyJaAcpD
	4ESqesADvf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D45337EE55;
	Wed, 23 Apr 2014 13:39:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F2717EE54;
	Wed, 23 Apr 2014 13:39:25 -0400 (EDT)
In-Reply-To: <1398255277-26303-4-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 23 Apr 2014 15:15:00 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 364D1C10-CB0E-11E3-843C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246856>

Are these three patches the same as what has been queued on
mt/patch-id-stable topic and cooking in 'next' for a few weeks?
