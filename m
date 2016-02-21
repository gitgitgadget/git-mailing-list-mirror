From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/3] merge-recursive: option to disable renames
Date: Sat, 20 Feb 2016 23:40:14 -0800
Message-ID: <xmqq7fhya4v5.fsf@gitster.mtv.corp.google.com>
References: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: =?utf-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:38:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXxL-00017u-63
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcBURh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:37:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751972AbcBURhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:37:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 817313BD4A;
	Sun, 21 Feb 2016 02:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TP1bAvy/eXHMM/WxtxyuwJGi2TU=; b=JC3dMX
	uK6g7HRI3LEMEuP8BKYOrc4rhKHDr0iVIov1dixsP1UyCB+M/e/eUmAaquJ7jlGb
	qWloNujppxNZLunz5hcR9hwXGtHRYhGQIl/kiahgK6Ww415mUw2kqLQ8KFPlt5X2
	gWilRNGGeIfAhHocP/smj8M4C99c7VQZoGj1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vZAjiZ/W9JG/CsPJ+/4CCP9i8iXU3FIt
	LEYaFRHhUWw7pLKEA5BD7tHBVfE4I2nrIQmeBTsWPd5HCT/F4YUUN9wZidQ/JfAh
	HXd87ndQF40OauawYbLiP3RpUi4syN4gn64pIMNJE44kS1JXRiqsjXx0assMUcWy
	Z3wvkqnsAog=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 785153BD48;
	Sun, 21 Feb 2016 02:40:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED7A43BD41;
	Sun, 21 Feb 2016 02:40:15 -0500 (EST)
In-Reply-To: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Sat, 20 Feb 2016
 23:34:29
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 593DA54A-D86E-11E5-BE6C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286808>

Yikes, your previous round is already in 'next', so could you make
this series an incremental on top of what is already queued up to
1b47ad16 (merge-recursive: more consistent interface, 2016-02-17)?

Thanks.
