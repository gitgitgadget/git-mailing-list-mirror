From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] find commit subject refactoring
Date: Thu, 22 Jul 2010 11:23:34 -0700
Message-ID: <7vaapjgyu1.fsf@alter.siamese.dyndns.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 22 20:25:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc0Sl-0007RQ-W5
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759771Ab0GVSX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 14:23:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759769Ab0GVSXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 14:23:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DEF8C6F42;
	Thu, 22 Jul 2010 14:23:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TlheKtyAU9AL23gdtQ2uQiWV0Mw=; b=u24p80
	aM6Z5PP7dCYWYx5VnJPh1ATBykIt68XETjN543NOgJPx6qBOcrDy1pPPLxWbUbVA
	+h8a1DQ3Bs5Ca6By8xb9DZtU40O6YSMotXodA1CyZCCC6U77diWu0HAfTY8ISaz+
	OevVBjp3+m/6saijiZzfyjB/JNE835NawKkTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaRfBXd2BIvcWWvtpmWDj35rEbW25NrC
	TeU/RfRsTG2Egi6PFBfXmmJXbq3V/d1iQEPnOF+xU59tCBXbPs7NBSlSos9IOrI5
	5MjQnl1DIyPRMlyLZQyreDgtWa3+PeTjrqKd8JUnTZbdD3l4bR1ErtQ4RuLreDN3
	ZS/QaQWr2BM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A59C6F41;
	Thu, 22 Jul 2010 14:23:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E044C6F3D; Thu, 22 Jul
 2010 14:23:36 -0400 (EDT)
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu\, 22 Jul 2010 15\:18\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4317F07A-95BE-11DF-A579-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151468>

Nice ;-)
