From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Document the --histogram diff option
Date: Tue, 06 Mar 2012 11:57:11 -0800
Message-ID: <7vd38psdt4.fsf@alter.siamese.dyndns.org>
References: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch> <a8d07a8e3860196053da7595f040707d3a3723ef.1331039505.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50Vf-0005ss-6I
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030900Ab2CFT5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 14:57:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030372Ab2CFT5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:57:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF8C6673B;
	Tue,  6 Mar 2012 14:57:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNpHKNIQTizjftUvk9WXLb+eTv0=; b=eBNGkx
	6c/TZ0Kr3N3ADwFVQnRf82pMHqCw/GoMlazM3mKw3n67lQsOLugz4biv505f9DbB
	A5/6SqaLwJj4jEKrPOc0iuxygWCdwvRoy7VkNZFZ6/I5xmUXs2qN6Q5ss+qvMIZB
	SPqE5CpnPKWC35jMBZSXjASgH5OwEw+gSR7yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TbhbrDL93RfE8TB7IvDh9O+rKyt1mmXO
	nLd4V/Zt0wddASL2/Q0uDzVi7iMT1YEW+sQdvBY1Zo1qtLuPtajEv7cD8FG0hk0I
	rWmcyHzAbOuGxtFIwo+qk2jRCYLSOV589DVMpcdhCGBayvs+gsDUya/067DGWsPO
	28vQmRJWh3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C677C673A;
	Tue,  6 Mar 2012 14:57:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 462736739; Tue,  6 Mar 2012
 14:57:13 -0500 (EST)
In-Reply-To: <a8d07a8e3860196053da7595f040707d3a3723ef.1331039505.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 6 Mar 2012 14:15:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9113884E-67C6-11E1-A111-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192383>

Thomas Rast <trast@student.ethz.ch> writes:

> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This is only the minimal update.  I think in the long run, we should
> add a note saying why we support all of them.  But off hand I didn't
> have any substantial evidence in favour of patience that could be used
> as an argument.

Isn't the main argument made by proponents of patience diff is more
readable output, and not performance?  That line of argument relies
on a fairly subjective test "which one is easier to read?", so it is
hard to come up with a substantial evidence, unless somebody invests
in A/B test.

Thanks, will queue for 1.7.7.x maintenance track and upwards.
