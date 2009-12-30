From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Tue, 29 Dec 2009 23:49:52 -0800
Message-ID: <7vy6kk52an.fsf@alter.siamese.dyndns.org>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
 <20091230121319.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, peff@peff.net, sam@vilain.net,
	git@vger.kernel.org, paulus@samba.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 08:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtJv-0002WO-7s
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 08:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZL3HuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 02:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbZL3HuJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 02:50:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbZL3HuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 02:50:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B7798CB77;
	Wed, 30 Dec 2009 02:50:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xs3xcEStFEqPs5mhg9vqzNhTbZ8=; b=LEeiZJ
	Yx9G04+mY2Gf6cueF1XJT+DHvAUtdpuwXAYCLOUBYHvO6+t4o8MJHtvMARBeSmm6
	Oy1pfV3oXPOYcR3INk+62lMgF7bvZ5g9c/ns69NWbIyAxMLol3W7YQv8T/CaCyKH
	xhGkUuaSwSTtvSSbA+BNq/3UAVc7/kzb5IU/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8W3vm7l8kqO3e8V4Yr1p62dXXApxuKh
	UhneswyDNbxiEyJBRyOxYQazE9z66cDmdcVCZjGOo03NZKV06eQhHhr3gSOcWlWx
	4LmU/7Ao6J8FKIQRne76j+tLqP3ucF6ApItfH6+U4zdAE2hU4z/dMdlkxvR48KT/
	0jrPW3jrrYk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 127988CB76;
	Wed, 30 Dec 2009 02:50:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02CA48CB70; Wed, 30 Dec
 2009 02:49:53 -0500 (EST)
In-Reply-To: <20091230121319.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 12\:13\:19 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EEFEAE30-F517-11DE-A474-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135866>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?

See http://thread.gmane.org/gmane.comp.version-control.git/132983/focus=133414

In short, the particular way to call difftool this patch implements was
found to be inadequate to support existing external diff support by gitk
and a small difftool update will happen first, followed by a patch to gitk
to use the updated difftool, to avoid regression.
