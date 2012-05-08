From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: do not accept non-blobs as new notes
Date: Tue, 08 May 2012 09:26:40 -0700
Message-ID: <7v8vh2y6yn.fsf@alter.siamese.dyndns.org>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <20120508160334.GA26838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 18:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnFQ-00035e-86
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab2EHQ0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:26:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384Ab2EHQ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:26:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 714E46492;
	Tue,  8 May 2012 12:26:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k5mVAouoVz1ZBex+WgUqPTc5UwA=; b=qLnZs9
	d69/zN7bQCwCklhZFlJS179pLJqsH6DQxbWvE4/z1BeMX9DV3mmV0jha4a1NCshe
	ZUsw7YXFsdsWqINfXq96OFusoaMbdUWNZM7pq6LKNTtOX4RBQsIyOR4tK4P3d1Xi
	uSnmzzBXPjF40bpbQb73ARec07sVKs3/FDmuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bb2m4EAFNzFt4xihFhSz6kWBKmrMy/RR
	mq6yT++LDNHKl+QbtI+uyD5/MaljK5uAX78B4c0kFeTWinOT8N9SBSNs6ZzI5WaD
	cfaE5AR772DLDQx0RSrsfOuDPxKZMJNvCyYtNPoRNB1FkK869QXlr4pVgkAsWzhZ
	mFniqM5gX50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 688AC6491;
	Tue,  8 May 2012 12:26:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAE946490; Tue,  8 May 2012
 12:26:41 -0400 (EDT)
In-Reply-To: <20120508160334.GA26838@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 May 2012 12:03:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9834427C-992A-11E1-8FEE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197385>

Jeff King <peff@peff.net> writes:

> ...
> At the same time, is there any reason not to allow experimentation in
> this area? We don't know what other people might be putting in their
> private notes trees, and the current interface does allow this.
>
> Is this fixing some important problem that justifies making such
> experimentation harder?

You said everything I wanted to say and asked the right questions I wanted
to ask.  Thanks.
