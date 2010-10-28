From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] gitweb: Add option to force version match
Date: Thu, 28 Oct 2010 15:08:46 -0700
Message-ID: <7vy69i7yxd.fsf@alter.siamese.dyndns.org>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
 <1288226574-19068-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:09:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaf0-0002AX-JM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760171Ab0J1WJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:09:02 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099Ab0J1WIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:08:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 009BB19F8;
	Thu, 28 Oct 2010 18:08:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YeL4jzdsAfcFeAuDsQQANXLTPng=; b=Bjk90F
	FiEF0IxjlimU6tgDjtB2nXjwibyltU+/4oNpv1xeX8rVx2i7O8UMj5FpuHLeWLpO
	lXO+/SJTX6IfEIMeqOL6mUPgM/FlhdnfVz0EbdN081Si/fyQ6BNSGlJH/pffdkya
	V2j0OdJxbIhofKdulm7nAvd6lKRCtAq8WeV6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/ZxEaA8zq0L1T8inmq6SmId+LvT+XBB
	aIAlzxipmA1NSrPN6+vdo4LgBj8I4/tOQreeFLLd5nF3jvfGUvVtkPgcRg73Qzn8
	hB375yk5ZbSWoNqHzp36F2By5FKTbTFDID6BAFUCADRNpjHE9J3JXQBcMtc1QtVf
	/l65Tgr348Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEDD119F4;
	Thu, 28 Oct 2010 18:08:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DEBD19F3; Thu, 28 Oct
 2010 18:08:48 -0400 (EDT)
In-Reply-To: <1288226574-19068-2-git-send-email-warthog9@eaglescrag.net>
 (John Hawley's message of "Wed\, 27 Oct 2010 17\:42\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1E2EBA0-E2DF-11DF-958D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160236>

I do not understand why this variable needs to be turned _on_ by default,
but more importantly, isn't this more or less independent from what we
discussed at GitTogether, which is to get your battle-tested caching layer
that will tremendously help any nontrivial site merged earlier rather than
later by reducing load average from 1000 to 3-or-4?
