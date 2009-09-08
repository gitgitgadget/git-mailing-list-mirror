From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for ignoring pushInsteadOf when remote has
 explicit pushurl
Date: Tue, 08 Sep 2009 09:34:50 -0700
Message-ID: <7vtyzd8ket.fsf@alter.siamese.dyndns.org>
References: <cover.1252313313.git.josh@joshtriplett.org>
 <5e58748923d9b4a182499a6ba8fa4636bce4810e.1252313313.git.josh@joshtriplett.org> <7vws49gbql.fsf@alter.siamese.dyndns.org> <20090908071513.GA3236@feather> <20090908074147.GB3236@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 18:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml3er-0004hU-O2
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 18:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbZIHQe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 12:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZIHQe6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 12:34:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZIHQe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 12:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBDD2A6BA;
	Tue,  8 Sep 2009 12:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TPY+0wvxdcKvfiDsDK49HKod51c=; b=fYqNKInpnKd2EHLsmvk7p7f
	XSdB+RtuJ4XRR3giAdb+29oQkvveQGE0yp5Bsk809QAOw//bt93us+9dWlM/bUqL
	qGfo5KiJQa48fRfUCMMotzC9mtitqfCL7gB/B1Hz2n9uVQGsQSDQM07WA0mrsSSB
	K0Q0bSxP6RTxBRhkzWA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Tk6eWUnaCAEQeI39glfSw5c1aKA9qbLsDoLkstCvouaLMPNLv
	hJqqKgzFLwcO3fAX5wfjofGitker8B/VRY+sBWJSzeJ+dUaWth6rNCoD/EvqXX7a
	yfG7USEoqKoBclKGCvqkEYzFMKZVNsAA1+LshtoioS/WeNXdQ3Mhmk7ZGg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 412D42A6B9;
	Tue,  8 Sep 2009 12:34:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B3042A6B1; Tue,  8 Sep
 2009 12:34:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A52813A-9C95-11DE-B14E-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128017>

Josh Triplett <josh@joshtriplett.org> writes:

> Done.  Please add this to the queue, optionally squashing it into patch
> 2/2 if you prefer.

Thanks.
