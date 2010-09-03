From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git send-email doesn't take To: addresses from the patch
Date: Fri, 03 Sep 2010 10:18:24 -0700
Message-ID: <7vk4n2zqxr.fsf@alter.siamese.dyndns.org>
References: <4C7B5853.7010001@st.com> <4C7E05B5.1050805@gmail.com>
 <4C7E1537.9030405@st.com>
 <AANLkTi=xQAoEFiB2zGz73ZwSwq16LOthkqd7w1GhnEup@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: viresh kumar <viresh.kumar@st.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 19:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrZuV-0001KI-7u
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 19:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab0ICRSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 13:18:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab0ICRSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 13:18:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5BF5D3195;
	Fri,  3 Sep 2010 13:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tVI5OcLu892Eds4fSgl/8VLF51U=; b=qYw3ZJ
	A9W7rOTe2t7p6FjSAfLfa5DhOCt/tJUg/ptKC8CQEvdCuxiqv58HM6Pe3k4tDFqW
	3KIcpEX8fNuE5eel8hLxgIVmn/t9WBQIX8TsJsMw2CCYREe9u/bRjNzZT2i3Qy4L
	h4s0O51gpC8UJNdTVD8HDupFzuoX6cHlyMBiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V8wkH8uJB+Ji4aHN/B9d9+fsqmzPA/wM
	W9eIcl7+yHOWB2VD041+LVrZSXi51FQQfpRvUX0vIARNJqhtiAnf+zHX8EUo2SZq
	mrap3iUdNQyhtUyP+Yhl5x2BIEWFdkenty8vmOIMHvVRQTQer+Xw1/D1fWt4RzLv
	z+omiN0XcXY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7910DD318E;
	Fri,  3 Sep 2010 13:18:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B364DD318D; Fri,  3 Sep
 2010 13:18:25 -0400 (EDT)
In-Reply-To: <AANLkTi=xQAoEFiB2zGz73ZwSwq16LOthkqd7w1GhnEup@mail.gmail.com>
 (Stephen Boyd's message of "Thu\, 2 Sep 2010 11\:36\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 453B93EC-B77F-11DF-B3B4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155253>

Stephen Boyd <bebarino@gmail.com> writes:

> On Wed, Sep 1, 2010 at 1:56 AM, viresh kumar <viresh.kumar@st.com> wrote:
>> On 9/1/2010 1:20 PM, Stephen Boyd wrote:
>>> Subject: [PATCH] send-email: Use To: headers in patch files
> ...
> Cool. Junio, does this look good to you? I can squash in some tests
> later tonight if I get some git time.

Sounds sane; thanks.
