From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting the commit that corresponds to a specific annotated tag
Date: Fri, 01 Jun 2012 15:21:34 -0700
Message-ID: <7v8vg61xn5.fsf@alter.siamese.dyndns.org>
References: <CA+mfgz2=ZFBetSGv1Bkq6orBbpVTS1k0gLVm0nGoR1sUDkDwqQ@mail.gmail.com>
 <7vd35i1ymz.fsf@alter.siamese.dyndns.org>
 <CA+mfgz0GqTKwOg6b=6rPUUnS6kwXZfCCYE7SOVHFcqrjRpOiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaaE2-0001eh-9p
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 00:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589Ab2FAWVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 18:21:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320Ab2FAWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 18:21:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D627D9898;
	Fri,  1 Jun 2012 18:21:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WKIcrDWPS5/+BAarH6DqrX+77hk=; b=ER/hXv
	1GGuuv4NyLrghPSpSJAj0R7mOUxOseW1fzmvNCy9f6YSLofpXVSkvTcmbGQX0FsA
	DqJfMtASbiHAYSZAU4Yr73crbSwLtt5RN6DzESQfrhRGhg29hPlyWrRc6hwzoh6N
	03EQ7W9La6z1P6o59Kswpu/rjNZ3MmnP0gYEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b2YL4AOuD90kh2d/zuJ9fCB+AhuUHkPV
	/BMndTAmgVkNtyPoawpKNepTvxmgMTnw3pVWxm/FV8ujMHAqFLBv1pMhwLA9J55j
	NWmznHh+8ae6lQ1k2Z5lWKUrH56hfBLNIFk5zh0t6F1nuUbVL8UZbu9G6kC3yq9A
	axykHfF7k5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4409897;
	Fri,  1 Jun 2012 18:21:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EC979894; Fri,  1 Jun 2012
 18:21:36 -0400 (EDT)
In-Reply-To: <CA+mfgz0GqTKwOg6b=6rPUUnS6kwXZfCCYE7SOVHFcqrjRpOiTw@mail.gmail.com> (Adam
 Mercer's message of "Fri, 1 Jun 2012 17:11:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 269FE910-AC38-11E1-B778-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199029>

Adam Mercer <ramercer@gmail.com> writes:

> On Fri, Jun 1, 2012 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I think you want
>>
>>        git rev-parse $tag^{commit}
>>
>> It's kind of scary, though.
>
> Thanks, that does the trick. Why do you say it's scary?

Didn't you say you were writing a Porcelain?
