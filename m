From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --stat
Date: Tue, 14 Feb 2012 14:06:26 -0800
Message-ID: <7vipj95au5.fsf@alter.siamese.dyndns.org>
References: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
 <20120214195036.GD12072@sigill.intra.peff.net>
 <7vfwed6uws.fsf@alter.siamese.dyndns.org>
 <20120214202934.GA23291@sigill.intra.peff.net>
 <7vty2t5bmw.fsf@alter.siamese.dyndns.org>
 <20120214215318.GA24802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:06:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQW9-0002ru-LL
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761167Ab2BNWG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:06:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760823Ab2BNWG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:06:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5823E6C7D;
	Tue, 14 Feb 2012 17:06:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UKtZbJl9fhXgb8DbDoczsEGeIek=; b=QPWN3j
	5VrVIK0uCPEdmkA/Nz1oVgCXlJOXWxxKSrPcqjVC4hheJrF+AxfR+wOL1upBkG6Q
	yL7AC56cd0gIeeL7KdYAL/LlyQshBRARX5JJzoenKBYvhTmJPxx05KZbDjDUJaHp
	GtZVYJNBfXflv0jnzQMGtrhuADRQq/8zpDvFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ddNgyv190AcijuhmWYHbGafSPA03b8E1
	NCIuvetTIehTB8orW055xwhCuLwZHH9c0rxbhOrY9gsJlwKEPiyHo285GAsgq8Zb
	HrD8RzQEbHxxfrVyyaHGpSB1l7inYz+KBkdM6jrPZc633F3IbG3vrOb6fFwOMvjb
	A1AyrwwhdvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F2A26C7C;
	Tue, 14 Feb 2012 17:06:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB0B86C7B; Tue, 14 Feb 2012
 17:06:27 -0500 (EST)
In-Reply-To: <20120214215318.GA24802@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Feb 2012 16:53:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24821D2C-5758-11E1-BF76-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190772>

Jeff King <peff@peff.net> writes:

> I'm not sure I understand why the "it - 1" and "max_change - 1" bits are
> still there,...

Simple; I wasn't thinking straight.
