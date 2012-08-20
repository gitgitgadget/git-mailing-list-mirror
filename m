From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/66] parseopt i18n marking (again)
Date: Mon, 20 Aug 2012 15:55:42 -0700
Message-ID: <7vk3wtgolt.fsf@alter.siamese.dyndns.org>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3asx-0001du-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab2HTWzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:55:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab2HTWzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:55:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF97F93EA;
	Mon, 20 Aug 2012 18:55:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0XmB8mLKwcKoLp3ifmfU6nFRvxk=; b=IVo1SV
	XVmkMGKzQGci0VLFAUS+HHFyuPZ1yNNVhmGJJo413p5yeiaDoA5yPxfEqbD+gysF
	Dtr70dvk89ppl5A0hCpLLQO11Q8e6RRB9ZPj/wQZ9NpF32Bzm6Jffeh2fxXV1QxY
	RWVNA8eLtw9M7GN+0toe5X0VQ9I7Q72L6nPH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZSYX/58+ZRkZuF5KTcF20xPer2iwb7di
	bBHON/HN0LVcBXNNHnepVRGT44qLxzFz6d5wK8LFNJRjWdj5XNklYfld0uCH97p9
	ypoluyWTJ7DEZVvFpxhEzPSZlv8A8NpVIYUgkdR/vQh6Y7BH16MT6TXn/6o7LizT
	yh+xMm7t6vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC0493E9;
	Mon, 20 Aug 2012 18:55:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 337E593E7; Mon, 20 Aug 2012
 18:55:44 -0400 (EDT)
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 20 Aug
 2012 19:31:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C448ECC-EB1A-11E1-974B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203906>

All queued; there were three commands that gained new options that
are already in flight.  If everybody agrees that it is a good idea
to mark help text in parse_options with N_(), perhaps a better
approach is to remove these three patches, queue each of them on top
of its respective topic, and have the others graduate to 'master'
early.

In any case, not a big deal to handle this kind of conflicts.

Thanks.
