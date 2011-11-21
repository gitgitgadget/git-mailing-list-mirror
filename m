From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show error for 'git merge' with unset
 merge.defaultToUpstream
Date: Mon, 21 Nov 2011 09:30:16 -0800
Message-ID: <7vbos5gz87.fsf@alter.siamese.dyndns.org>
References: <1321882240-3783-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 18:30:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSXhJ-0007o1-CI
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 18:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab1KURaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 12:30:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab1KURaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 12:30:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 624715E7A;
	Mon, 21 Nov 2011 12:30:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWWTpYlPS9x0wjAcoVFx4P5Nlug=; b=t2XtUN
	/ywdaoNeyHYInRpzzjmQmiKjrpT1BQI6dL5fI9qHSJdHmGrV2OgumcMCx+w8zqT5
	S1FRlVH8W1GKc69t539KfoqL8gY85hVJdU3V6rOOH78EO61wRbU17vx6p6Po8aXR
	1+JgIGlCPJMQ+X+836C3i3S4Wo+dFIAmDF4tI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NmlPjF1Awo0H0gKX4EhcGm9lRT+tH3Ef
	neaL4TGSBnPNXGk5xNnCJ3QcgYYdnyuWA3xgRJfy5UYxmArTWC4Rd2VbKexLgJNK
	72SL1PuVgnBvjq2qmBA2cmwrdKPbWTyuelS8qpLaaw6W+atRHv6rZjXKRAtEzWI0
	ou/kFf943gc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 593EA5E77;
	Mon, 21 Nov 2011 12:30:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9B4D5E75; Mon, 21 Nov 2011
 12:30:17 -0500 (EST)
In-Reply-To: <1321882240-3783-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Mon, 21 Nov 2011 14:30:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AF150A4-1466-11E1-BE7C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185753>

Smells correct from a cursory look; thanks.
