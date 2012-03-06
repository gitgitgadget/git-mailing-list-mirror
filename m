From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.3
Date: Tue, 06 Mar 2012 08:03:55 -0800
Message-ID: <7v7gyxvhqs.fsf@alter.siamese.dyndns.org>
References: <7vliney6k7.fsf@alter.siamese.dyndns.org>
 <A518E7E7-25D5-429C-A1C1-35F94EC8F043@bjhargrave.com>
 <87y5rd4wci.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: BJ Hargrave <bj@bjhargrave.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 17:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4wrr-0005bb-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 17:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab2CFQD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 11:03:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab2CFQD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 11:03:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BF5C53E1;
	Tue,  6 Mar 2012 11:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l5OrdElGMu0uuS4xP2OQzHkvUh4=; b=VqATdM
	T6U2duXgZJWp4Y30No9K88/uXjwTH3cFwGRM0vPekNjROBWmnRy/vefJplhpJteW
	XU4ZY3yHN+5BkBc1pi2gCvP4pLW85owUxDQMvRA+M7z4QvnHzZ/ZFniQpwuxRq6k
	YesyIsNOGe1CgC5RRVtxU6FfCozL++2nVSvBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CkJJ/OYdU4zfK8AN6ZhP3ga2xAev2rVI
	VNerdf6R5qXIMuFUlgc5M6FNGeqtOlLBZmNhNE6jQVv5t7tZTId0OZPK2/FED+ak
	0C9u1gB1gMPZ97jJRsxDutluqTm58u3865h97ktsb9+ScDuAL8e9ix5YQ4sWVsRL
	BrgvOSai1ME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 637F353E0;
	Tue,  6 Mar 2012 11:03:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F14C653DF; Tue,  6 Mar 2012
 11:03:56 -0500 (EST)
In-Reply-To: <87y5rd4wci.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 6 Mar 2012 15:50:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAA1BBA8-67A5-11E1-8FF9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192360>

Thomas Rast <trast@inf.ethz.ch> writes:

> +	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&

Alright. we see trailing ;} in t4300.

> +	grep "^-[0-9a-f]\\{40\\} " boundary

Ok, that is what we already use in t5510 so it should be safe.

Thanks.
