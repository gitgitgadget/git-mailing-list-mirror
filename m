From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/git-checkout.txt: document 70c9ac2
 behavior
Date: Sun, 16 Dec 2012 23:26:10 -0800
Message-ID: <7v4njlnnql.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-3-git-send-email-chris@rorvick.com>
 <7vd2y9nnyb.fsf@alter.siamese.dyndns.org>
 <CAH5451kutMLhjGJbeQ0gw_DC8sE_9r2Hjg1SvTa75B5n7eXO1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV5r-0007n4-CV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab2LQH0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:26:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab2LQH0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:26:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D2589858;
	Mon, 17 Dec 2012 02:26:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SilR3HBX8A6/0ukl6woj+x5br4=; b=Ec+DTY
	lAh6uWaxGcA2vzZ7Gyv3mD+bEcQFgNKgQa5GTWiEyB9OHnNOuu2QOs3mhFlXatES
	DFHMOxd3IiGv8dRePdDCdQdqX3UWn8c4wLTJ9CvycXbllUN04uW6TifIPzdNaUFW
	n2a2ZQqglhOxdDa4EhsZyLQNMbNGiYVWY6R5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DOQcm++UnZE0DSnTK80EJpVt24WKYRBf
	axemhTJmLIFQ2daQVd1LASErMMDG3gWI3TXy1qEBPbyBFSgVJBha5D3Dl4Jq+NnD
	Vm5AXEHaXvTFr4oAm2SxApSWm5hKpqZE3CMA/0VCQuVQgSlAncR+MunUZO+gxPwu
	E+5LZ2cpub4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0179857;
	Mon, 17 Dec 2012 02:26:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BBB39853; Mon, 17 Dec 2012
 02:26:12 -0500 (EST)
In-Reply-To: <CAH5451kutMLhjGJbeQ0gw_DC8sE_9r2Hjg1SvTa75B5n7eXO1g@mail.gmail.com> (Andrew
 Ardill's message of "Mon, 17 Dec 2012 18:23:57 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08DC1604-481B-11E2-BAC6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211651>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 17 December 2012 18:21, Junio C Hamano <gitster@pobox.com> wrote:
>> does it format well (I didn't check)?
>
> It applied cleanly for me on latest master, and the output looked
> consistent with existing documentation.

Thanks.
