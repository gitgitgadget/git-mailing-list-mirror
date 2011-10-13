From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] is_refname_available(): remove the "quiet"
 argument
Date: Thu, 13 Oct 2011 11:49:12 -0700
Message-ID: <7vaa944thz.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-8-git-send-email-mhagger@alum.mit.edu>
 <1318509685.7231.6.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQLH-0004tM-W6
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1JMStP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:49:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab1JMStO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:49:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B48735F2;
	Thu, 13 Oct 2011 14:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5G+h2r3EWIbgHcm8LekPBWhvoW0=; b=mCPVxE
	62eUPzk5Tt753OaIly8u7DeKzXir4DXchgarDJUN8xUtWOxjBXFGlTXqGBSdcc3v
	9aHjuYdg1GGwvZ9cU1ceat4rp2EkvsstFdYpAEKVDEeHu1ei7M6eLfSHHn1ERyBq
	z/Dsfh0q8RWoFrSHRqIvlDEmX6Sfbej71medo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JHduoar43Ocy/a23QEiSU2AOE9ryYG3n
	ZeEjENX+Gpx9oBfe6w1onNj4QKXa6GUgjsVp1OwJPkLIZKbq2uJw1qjlNVGG3ibD
	4ymiVS6oYNJA8G97DuR7nhOIstO4RtvC6kOtEbT1xI5PR9XLtwfopGQOYNC9Od1n
	lj4Snt4Tz+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F7635F1;
	Thu, 13 Oct 2011 14:49:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2A1935F0; Thu, 13 Oct 2011
 14:49:13 -0400 (EDT)
In-Reply-To: <1318509685.7231.6.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Thu, 13 Oct 2011 08:41:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BABAC8E-F5CC-11E0-A859-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183513>

Drew Northup <drew.northup@maine.edu> writes:

> On Thu, 2011-10-13 at 09:58 +0200, mhagger@alum.mit.edu wrote:
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>> 
>> quiet was always set to 0, so get rid of it.  Add a function docstring
>> for good measure.
>
> I would like to know if perhaps it was an unfinished project somewhere
> to propagate the "quiet" option down to this level before removing the
> function argument. Comments?

Have you tried blaming?
