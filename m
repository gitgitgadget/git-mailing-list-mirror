From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 23:21:14 -0700
Message-ID: <7vvckgbew5.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Pixley <rich.pixley@palm.com>,
	Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 08:21:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP6Sf-0005bH-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 08:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab2EAGVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 02:21:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2EAGVR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 02:21:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1C15FDC;
	Tue,  1 May 2012 02:21:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q7aUisC4nwcz1PFtETAfLGmFBRA=; b=LnI/5h
	IVkacdeO8Jcmic2HEpg8MyPcoe987BN760RM1yS7Xq2AjFZ97o6l0zc9B9M5mE+I
	XVLofwO9Bv2XGox3giT380S1rNVQaRyQcN6HALNN5d9q4DvDyO9z3fhqTSotsHs+
	NHPLdypsRjCSGaMSpnVkTLG6Gi4/7Izt8x0Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CxnoBB+GcJBrb/uE4ioszzpp8RrJdUFn
	D2mbdOOt5X32UTqNVKX7d3/QqtBosGqK1ZZ/zVfOxuUObp2KATELfi0a5THPc77F
	8jdnSpJeilsdf0gmGXqZEZ81Tr09DtjYELQSrIfCfIgZ8P25OciuvZOZTwbTnhU4
	LVSPAeEpYyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3ACE5FDB;
	Tue,  1 May 2012 02:21:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 389565FDA; Tue,  1 May 2012
 02:21:16 -0400 (EDT)
In-Reply-To: <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com> (Michael
 Witten's message of "Tue, 01 May 2012 05:32:09 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB87AF8A-9355-11E1-99E3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196662>

Michael Witten <mfwitten@gmail.com> writes:

> Here's a start for a more precise discussion.

When does the "Cache server" updated from the "$uri_for_central_repo" in
this picture?  If it is after push by either from Machine A or B, somebody
needs to reconcile that and whatever A/B pushed.

And between Hg style "split head" or Git style refs/remotes/* namespaces
there is no difference to perform that reconcilation.  Somebody needs to
run "merge" on the "Cache server" and at some point the result needs to be
pushed to the $uri_for_central_repo back.

So...
