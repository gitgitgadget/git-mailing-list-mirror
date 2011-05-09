From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tags named '-'
Date: Mon, 09 May 2011 11:01:57 -0700
Message-ID: <7v39knpxbe.fsf@alter.siamese.dyndns.org>
References: <1304954496.11377.11.camel@kohr-ah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Mon May 09 20:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJUma-0002pJ-69
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 20:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab1EISCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 14:02:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab1EISCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 14:02:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AAD5F4DAF;
	Mon,  9 May 2011 14:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s3tFiLrKq67M6kWSXAbqurA4wk8=; b=JUB6mO
	z2XIoz6CMoVAsMN8UD0mqVyM5wIhv7WWGYbuZTiylb6GfCtbW8jxWDVnIuPwGTRJ
	v2+rsWxv3689KEC8hNoTKFnAgcRVDOYZ1N5ivCW5w2uPNyfFvOr23aOMogNOtWuJ
	XjSV7FapVuJ5VU535WYbabmnFrYRyuBbL9ABk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOo7wkVunFfn8nI8T1kNcy2R0hq0hKKT
	hvwm0pVcbLDKg03kgT+35+ezvhe8j1b4HzV0TWbHgADTV37gSK6/Af6aiuQ4tAa6
	skQLEvpQrn5wPcEzTpIf1wDse/APqPy9TIMr1hXuhYWJN1X1RDA0IdoKtufCNqxl
	NeYZMkDWlQg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 855D84DAB;
	Mon,  9 May 2011 14:04:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D74D4DA7; Mon,  9 May 2011
 14:04:03 -0400 (EDT)
In-Reply-To: <1304954496.11377.11.camel@kohr-ah> (Alex Vandiver's message of
 "Mon, 09 May 2011 11:21:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB0F055E-7A66-11E0-9F36-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173248>

Alex Vandiver <alex@chmrr.net> writes:

> The likely best fix is to disallow '-' as a tag name, as well.

Sounds sane.  Patches welcome.
