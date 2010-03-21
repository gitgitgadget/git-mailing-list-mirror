From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use -q instead of redirect to /dev/null for git
 update-index
Date: Sun, 21 Mar 2010 12:50:07 -0700
Message-ID: <7vr5ndpi8g.fsf@alter.siamese.dyndns.org>
References: <1269168827-18694-1-git-send-email-romain@peerfuse.org>
 <7vy6hlvmoy.fsf@alter.siamese.dyndns.org>
 <70E4FE83-0DC9-4AF1-BA20-BE6467FC8D07@meyerhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Meyer <ben@meyerhome.net>
X-From: git-owner@vger.kernel.org Sun Mar 21 20:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtRAF-0005rw-7E
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 20:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab0CUTuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 15:50:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0CUTuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 15:50:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86C06A45C2;
	Sun, 21 Mar 2010 15:50:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vkjSVNWgJe3NqaHhHbUH0GuMivo=; b=VOKUuy
	ZYDOAmuN4GNBw7Vmx89XtPBpcNvxeqRVxD7PH9i7UbhIHrXgo1YNuip585KyC2ej
	mV0DtRawkJJiw6Zylf0w9OVpaonTOVLn7zHBgkI0qTr6WN2cY7KdpJf3bi7kka/q
	q+6QRe/fgyZCVzZ+eTH63yVVt9B5QTOkxwqGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LrHemQW4HVm4P9SRWsoJ4olREyGC3kKP
	ifjw0ACLWyTQutJ7O56S7Q4Spt2DL8Myv3mVZDSlrPI8IQw01sp9jKeq3Gxcp9rq
	31p9Bn61RB1yE9bLqlpKiyBbC34Q2IdiepsBtEmy2/aXSVev7aMJ9Dok5OwN018H
	PO1XSOzqFpk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C450A45BF;
	Sun, 21 Mar 2010 15:50:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3A35A45BD; Sun, 21 Mar
 2010 15:50:08 -0400 (EDT)
In-Reply-To: <70E4FE83-0DC9-4AF1-BA20-BE6467FC8D07@meyerhome.net> (Benjamin
 Meyer's message of "Sun\, 21 Mar 2010 13\:02\:29 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5D3F1CA-3522-11DF-9BEB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142853>

Benjamin Meyer <ben@meyerhome.net> writes:

> For what it is worth I got the task from the Git Janitor wiki page.
> https://git.wiki.kernel.org/index.php/Janitor
>
> Sorry I didn't include that in my changelog.

Thanks for a pointer; I tried fixing the Janitor page.  The description
did sound as if we invite anybody to send in sed -e 's|>/dev/null|-q|'
output as a patch without thinking, which is very wrong.
