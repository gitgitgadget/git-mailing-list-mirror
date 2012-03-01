From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4011: modernise style
Date: Thu, 01 Mar 2012 11:59:09 -0800
Message-ID: <7v7gz4m6sy.fsf@alter.siamese.dyndns.org>
References: <7vipipqk4p.fsf@alter.siamese.dyndns.org>
 <4F4FD21C.9060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:59:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3C9l-0007va-BF
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab2CAT7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:59:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab2CAT7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:59:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 135BD622F;
	Thu,  1 Mar 2012 14:59:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QFOhnqqBnpOybOigi4rUofbKDVA=; b=MTfNjh
	MFZ0lmDWEwGXlaHYpm9ICD0qoyzJArNvhKV/qb04vnJEUVnM5ij2Sz+SwZVX0ZLi
	jH7jGvTYkt02EC1lYTkVmrYjiY4vJHcOZsICn5tfLRq7nWoghQTRBVQeOSnXe33a
	cyUr8LLpns4zO8rHcsdb+zY4w+33zDX6YNMjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LJQ+u+Z+TXvo5JX/n4KeV1cMcNp1f7Ha
	yuuwGUWK7k2eeUAnSoB5sfk9F0CP/XzU084BtAa+CbCQZKpue3SfhEhqVAsr3I2y
	uChK7sg8M+k2zmsCw2slHYnvJZEUX1ftkEQhjpgbRQz0803wZzfuJ1uGw9D3T3XU
	Qj9/LDltjHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A25F622C;
	Thu,  1 Mar 2012 14:59:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D21B6229; Thu,  1 Mar 2012
 14:59:10 -0500 (EST)
In-Reply-To: <4F4FD21C.9060403@gmail.com> (Stefano Lattarini's message of
 "Thu, 01 Mar 2012 20:46:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02E20596-63D9-11E1-952A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191966>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 03/01/2012 12:45 AM, Junio C Hamano wrote:
>> Match the style to more modern test scripts, namely:
>> 
>>  - The first line of each test has prereq, title and opening sq for the
>>    script body.  This makes the test shorter while reducing the need for
>>    backquotes.
>>
> Did you intend "backslashes" instead of "backquotes" here?

Thanks.  I did have this funny feeling in my butt while writing it, but
didn't quite realize what was wrong ;-)

Will fix.
