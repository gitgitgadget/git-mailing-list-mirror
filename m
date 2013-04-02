From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: allowing multiple parallel sequencers
Date: Tue, 02 Apr 2013 11:06:28 -0700
Message-ID: <7v38v8eriz.fsf@alter.siamese.dyndns.org>
References: <20130402174640.GA14473@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 20:07:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5bp-00006P-Fh
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 20:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761545Ab3DBSGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 14:06:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761494Ab3DBSGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 14:06:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 873911193D;
	Tue,  2 Apr 2013 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOAS5krqRmfoF6dRv2T0TxNx/ws=; b=Pde62W
	dCMuqJaruNTj4So3DPhgLHp+Dljw/EckqD/FBrTZBhrzUZ9T0mwFkbrp9NP3xXsZ
	56nncnSiytcqI2qNT2o16OZNzR0SVm9dFnfecDer37cQ74WteZehE9zOQ9Ny66j8
	aaCv41YNztnMz2MuFV7cBt6fXUCIj0NJn1XnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pnj+Fhc1uhf9esm7kpG09mICd0ciPCkr
	S3sTpzIXvd8Tu8UCo5CKzHM2LpwIFzozYvbkpfwPCyeMkOJ7wmEG8o8TxurKuscO
	PmhLeDig71c1K/o8QhBX9YrUJsBE4v5lQ0Auyw4pXAx/NE9DuNsNA+GztRM99jro
	cnm6+6aziug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79FDE1193C;
	Tue,  2 Apr 2013 18:06:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1DBF1193B; Tue,  2 Apr
 2013 18:06:29 +0000 (UTC)
In-Reply-To: <20130402174640.GA14473@neilslaptop.think-freely.org> (Neil
 Horman's message of "Tue, 2 Apr 2013 13:46:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B406186-9BC0-11E2-817F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219824>

Neil Horman <nhorman@tuxdriver.com> writes:

> 	I've recently started looking into the possibility of having git support
> multiple in-progress sequencers, and wanted to solicit opinions for how best to
> do it.... The thoughts I had were:
>
> 1) A per branch sequence directory...
> 2) Augment the git-stash command...

3) A per branch working tree.

That is how I would do this myself, anyway ;-)
