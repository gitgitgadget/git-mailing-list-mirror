From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Tue, 09 Apr 2013 18:09:15 -0700
Message-ID: <7vsj2znqdg.fsf@alter.siamese.dyndns.org>
References: <CAAvHm8NV4OD+QqVp-7oOzsSdAwten6gTpfUFfi85jv_VQ3soFA@mail.gmail.com>
 <1365555308-611-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 03:09:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPjXP-0002yZ-O6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 03:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765445Ab3DJBJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 21:09:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760406Ab3DJBJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 21:09:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D8E10B8D;
	Wed, 10 Apr 2013 01:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ASdmHYh+k5KvDWNIJl4a9sNQ/Ng=; b=PUYu/+
	rtvn/8SZ3XmRHVXTNhXWL3NQbR8611e1lmz9qpVGBTBGkqmPBhiOf11BdEdZp1FJ
	1NUoldPiFKeps+P2tGmOBY+pA5H+Urt/HXL/NXMhO52Us+gbvF8I6/zQRue+l3Cu
	cJWKiaGubjoNk1JSDQn3No19RP1JK5GUIb0qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fppq+rgmxU4hthTWIqRDpJCYvLJrQZzm
	ne9DXSdgNGFumu7B5IZSoH+aS7YMRMYLFkq2cdAxqmr1qcRk5891ymdm3aDhWQOU
	GeuOzPot0aLM/KE6ZgbEsX7Vw9feaG8LyeVKNe/QutijbcNELDCiajwEDK0E10LX
	2t8ASy/1nBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14A9510B8A;
	Wed, 10 Apr 2013 01:09:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42CCB10B87; Wed, 10 Apr
 2013 01:09:17 +0000 (UTC)
In-Reply-To: <1365555308-611-1-git-send-email-jkoleszar@google.com> (John
 Koleszar's message of "Tue, 9 Apr 2013 17:55:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4443A70C-A17B-11E2-9033-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220654>

Thanks; will replace the previous one that has been in 'pu'.
