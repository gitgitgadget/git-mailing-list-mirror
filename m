From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My advice for GSoC applicants
Date: Mon, 03 Mar 2014 14:29:10 -0800
Message-ID: <xmqqa9d6or0p.fsf@gitster.dls.corp.google.com>
References: <53145D48.3040603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Dmitry Dolzhenko <dmitrys.dolzhenko@yandex.ru>,
	Sun He <sunheehnus@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Kyriakos Georgiou <kyriakos.a.georgiou@gmail.com>,
	Siddharth Goel <siddharth98391@gmail.com>,
	Guanglin Xu <mzguanglin@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Alberto Corona <albcoron@gmail.com>,
	Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:29:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbMM-0008In-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbaCCW3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:29:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbaCCW3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:29:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1D7D718A0;
	Mon,  3 Mar 2014 17:29:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hJwNq0/S3ZkoABPlcNw1fjE/kjc=; b=dTkm1o
	CVToJMcspfU2NKPu5r7HboqmcKyfSiPaLuCGXNUKw+N0/CGSz7Fm0EJIOzzMe2fR
	TisyrMo8GOrttuspWK9wZj3FhMU6gTsp0hmd6yzLBf9muvgClm7a5l8dUl66pr4n
	NJNipsg2s3Ogqkqro+2g4g7hT0ee9WCB01UGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xq5sBlvVzjmyEwKPkLjd3IX23gTSmeMm
	qWkKKnw+xfyhHAzNfF9Myiy68lLZUodUPtLw68DiuvkVBJCXlixCimcEPeoe/iyq
	lAnv6isRulmWlXT//WxnIbh5OK3MGb12MMGqY4S4HMSn9nKSCsuAJV1m4Sdo3aAw
	SvpmJz/cWVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A95BF7189F;
	Mon,  3 Mar 2014 17:29:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6EF97189C;
	Mon,  3 Mar 2014 17:29:11 -0500 (EST)
In-Reply-To: <53145D48.3040603@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 03 Mar 2014 11:45:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E8B3BE0-A323-11E3-B621-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243277>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Based on my experience so far as a first-time Google Summer of Code
> mentor, I just wrote a blog article containing some hopefully useful
> advice for students applying to the program.  Please note that this is
> my personal opinion only and doesn't necessarily reflect the views of
> the Git/libgit2 projects as a whole.
>
>     My secret tip for GSoC success
>
> http://softwareswirl.blogspot.com/2014/03/my-secret-tip-for-gsoc-success.html

Thanks for writing this.

Also thanks for the MicroProject approach to introduce potential
students and the community.

Multiple students seem to be hitting the same microprojects (aka "we
are running out of micros"), which might be a bit unfortunate.  I
think the original plan might have been that for a student candidate
to pass, his-or-her patch must hit my tree and queued somewhere, but
with these duplicates I do not think it is fair to disqualify those
who interacted with reviewers well but solved an already solved
micro.

Even with the duplicates I think we are learning how well each
student respond to reviews (better ones even seem to pick up lessons
from reviews on others' threads that tackle micros different from
their own) and what his-or-her general cognitive ability is.
