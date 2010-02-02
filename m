From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8 v6] gitweb: Add an option to force version match
Date: Mon, 01 Feb 2010 21:26:55 -0800
Message-ID: <7vvdegfbs0.fsf@alter.siamese.dyndns.org>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
 <1264890645-28310-9-git-send-email-jnareb@gmail.com>
 <4B677971.2080100@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcBIB-0006Qj-Q0
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 06:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab0BBF1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 00:27:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0BBF1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 00:27:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6211196605;
	Tue,  2 Feb 2010 00:27:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q0FWgCbbAzWa/GH1gtxNVKKukR0=; b=ySOvHH
	wp1TNnEomWCHLPQQw0M3GQkVQDC7S4At+mNdCWvudJnZJcAtIsIFVGl8P/NHX/+g
	pQq8lWdcLiFAE7zb81GCPb8I/YbzIfCgDVAuSpbvSHObOfa+MOcUD3/J3mOQrPMC
	TDmapm7GgRXlS16CNnVOuvA/piSerswH5HGnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcjtNI8Rifq9ULcHS/26giZkQ0YHTaEJ
	8VOjxacTjjY/pz97deSwhDYbj/blc1mPzpPZMV18guBS2PQMpx2bMeJo4Ha1tQZ4
	zCVZiIyCMeGuVasJ1qPjbtlyLgWAwyOqUbHDYCmPmk0WQTjYh8iAA0hbDggvP0c/
	saZRvvIG+vA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E97BE96601;
	Tue,  2 Feb 2010 00:27:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7591965FD; Tue,  2 Feb
 2010 00:26:56 -0500 (EST)
In-Reply-To: <4B677971.2080100@eaglescrag.net> (J. H.'s message of "Mon\, 01
 Feb 2010 17\:01\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98157E0A-0FBB-11DF-8F12-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138679>

"J.H." <warthog9@eaglescrag.net> writes:

> Starting to pop off the stack, and this came up first.  A quick reading
> of this, I'd sign-off and agree to patches 1-7 completely.

Then let me queue up to 7th to 'next', so I do not have to mentally keep
track of which ones are already judged to be good, and we can move forward
immediately after 1.7.0 ships, regardless of the discusson on the 8th one.
