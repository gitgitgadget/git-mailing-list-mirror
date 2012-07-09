From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without
 any extra flags
Date: Mon, 09 Jul 2012 12:23:27 -0700
Message-ID: <7vtxxgkac0.fsf@alter.siamese.dyndns.org>
References: <1341529386-11589-1-git-send-email-max@quendi.de>
 <7vk3ydkmzq.fsf@alter.siamese.dyndns.org>
 <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de>
 <7vy5mskewg.fsf@alter.siamese.dyndns.org>
 <35825CE5-4411-4C75-830A-6D704ACA1410@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 21:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoJYW-0000Ry-47
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 21:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab2GITXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 15:23:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab2GITXa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 15:23:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A7529B96;
	Mon,  9 Jul 2012 15:23:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VWSZc6mgMItMFToo1xNVjJO3wEA=; b=nOhzsP
	dDX3Z8UzUzORvy9od+V38XkgJaKT75hYswX+YpWisgdlojVgnyBMMKDiZjimdCr7
	cEii5jZTGoE5/mzjFhiMA9gOC+vzB2w5xRuDSl7oGdM/mi/aQmQ/ITcD14pl0oFU
	/tIv3YgtJHM1XR7ousw5FKH5QtKq41aOe+xZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wvzSk4sfu0VuidJLN1uX5a31+e/wvEOu
	alW+DFL+Y7AQmGAM6jPD/e+JAbycmWnmgNmNb5rm0Yt7VV1DYXIRkDw7saeYJ5Pb
	aF+Q7hvu1FirFwHZ3ObGkh/zWqLwV9+B5iGg6D63Ly/tCM2q32tHlG7vDamqH5gp
	CSW8XKE30OI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FF219B95;
	Mon,  9 Jul 2012 15:23:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C05A69B94; Mon,  9 Jul 2012
 15:23:28 -0400 (EDT)
In-Reply-To: <35825CE5-4411-4C75-830A-6D704ACA1410@quendi.de> (Max Horn's
 message of "Mon, 9 Jul 2012 20:31:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 900420AC-C9FB-11E1-92A7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201219>

Max Horn <max@quendi.de> writes:

>> would it be feasible for the purpose of
>> the check to tweak the definition of "works" used in the loop so that
>> it considers the warning as "not working"?
>
> That would be possible, and probably a good idea. But it is also
> completely orthogonal to my patch. Indeed, if done without my
> patch,...

No, I was suggesting it as a possible way to make the addition of ""
order independent (which you said is impossible in your initial
reply).
