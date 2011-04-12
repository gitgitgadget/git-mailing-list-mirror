From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/init-gitdir] t0001: guard a new test with SYMLINKS
 prerequisite
Date: Tue, 12 Apr 2011 00:16:25 -0700
Message-ID: <7vtye4q6ra.fsf@alter.siamese.dyndns.org>
References: <4DA3F199.7020202@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Xq6-00008p-S6
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab1DLHQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 03:16:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab1DLHQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 03:16:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9075271F;
	Tue, 12 Apr 2011 03:18:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LiBnQKKsG5gVy4hVkdbPcN4iINs=; b=aTGHjQ
	FggyI0XrKlN5Si0/CYV9f1kC72/czjaZIxLe3aG6CL+99cbvtz0lG15MzMpV9Aqv
	WWpABSPjaAlYjj7QjeGtpES8m1TtESJOAu4vN3PSIoFSD9zF5FXdk8hb9hkQBL2R
	3XmCHIetiORQ1j8nj4qG9p44NNLw1bm/K6jMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lKVg7QOHppowc6MMHa5/+kHTT3xIzrIQ
	/tLDLxCAmI+x9Qo92wkIgAutgj0FCReEihyD2C3L3odWYmNA4IOZenV0wiMsYH1A
	UugeNBP3blNRoP8toRD1xNY2ujq338WMxs9Oc/z5Ijr3TwTB00tcK34QhhcvmnXz
	pXj24dKXLJc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6D66271E;
	Tue, 12 Apr 2011 03:18:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4C3A8271D; Tue, 12 Apr 2011
 03:18:24 -0400 (EDT)
In-Reply-To: <4DA3F199.7020202@viscovery.net> (Johannes Sixt's message of
 "Tue, 12 Apr 2011 08:30:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10EDB1F2-64D5-11E0-B614-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171377>

Thanks for two test updates.  Will queue before rc2.
