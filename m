From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 01/15] user-cppflags.patch
Date: Tue, 16 Mar 2010 00:21:24 -0700
Message-ID: <7vzl28n34b.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054300.978104000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:21:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR5u-0002z6-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937505Ab0CPHVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:21:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937499Ab0CPHVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:21:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB345A2F6E;
	Tue, 16 Mar 2010 03:21:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=gfEDImz0ejfhqq0C5vqvaehM8mk=; b=fstw+mG3hxQrxUoSwHBuv0C
	xN6kR745nJJwMJiiY/LiUHcStH7yk7zm6Xp2JAIP2kgNilt1OanqgU/dUutn0K0Y
	nWm3iUqBy75wHHUGDm+c39hz7JcKr6jykJCc4U20IqjdmOfQrkc/hVZsa8rjTKpt
	hHSgOjQe1m5uJxNnMJvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gp9+7yGEEUBjWk+AkGqXeTB3s4vHs+mAQ02QmUH8LkIpmuKZJ
	gwGAJy0+IspB3sSTGrrQFdCTa+K07SZlYXvHgDb0KvSpio86cLZZMjaeTHdnLM9Y
	LWvt8KVRrtsNNF0Is7mTn/jWxSiJ+HSHFO+MZVYmdlwZ/3+XY3wLMZGnNQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 963AAA2F6A;
	Tue, 16 Mar 2010 03:21:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C522A2F69; Tue, 16 Mar
 2010 03:21:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89AF7A14-30CC-11DF-B8CB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142326>

Looked sane (I didn't apply nor test, only read it through, though);
thanks.
