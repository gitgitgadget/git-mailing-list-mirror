From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Gitweb caching v7
Date: Thu, 28 Oct 2010 15:29:06 -0700
Message-ID: <7vwrp27xzh.fsf@alter.siamese.dyndns.org>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBayF-0001sc-D1
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969Ab0J1W3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:29:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0J1W3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:29:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5181C7B;
	Thu, 28 Oct 2010 18:29:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFqMpyNWoKO+8gbSl9pWVXcj7Vg=; b=uvN9tk
	/b/OiqmiekBiS3UOA2d/VL4JQcPz8UGSXpM0GHwsbRFPa4HT0vXCMsNO94O/lm4u
	69OjFlEXRbdMzatnx80wZLM+GxgfHn0zhbY5B+IiarRu6VGp9y6Io9k5fecpXxuV
	V2Y9rcgZTKkVrD7oXiY3+1mj8WdIMko+zKdQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iISUaruvMD36JDAIKya2IWCwgAvhXtu+
	+FbEqGLAdjqwvFEUpfVK6tbT85gPjwl6FchDuOEm1oo6rigzk/WBoeEyUzybGHJx
	0HS5KJ2Z38J//Fzka/B6oO6ojoq0sMOjL5ojdOqi8l0ilqJy2V+Qdho2IEkKkdoA
	HK5zqfpiDTI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E882F1C7A;
	Thu, 28 Oct 2010 18:29:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50C371C79; Thu, 28 Oct
 2010 18:29:08 -0400 (EDT)
In-Reply-To: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
 (John Hawley's message of "Wed\, 27 Oct 2010 17\:42\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C91FBCC2-E2E2-11DF-AFF0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160243>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> v7:
> 	- Rework output system, now central STDOUT redirect

Yeah, when I saw your print-to-variable-assignment that was one of the
things that came to my mind.  Sounds like a reasonable thing to do.
