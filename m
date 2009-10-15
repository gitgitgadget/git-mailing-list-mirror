From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 00:39:15 -0700
Message-ID: <7v63ah85ss.fsf@alter.siamese.dyndns.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyL5N-00029D-EQ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 09:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934752AbZJOHkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 03:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934112AbZJOHkG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 03:40:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089AbZJOHkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 03:40:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56C3E59993;
	Thu, 15 Oct 2009 03:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=D0PbjaBSY+2JBXZVjsM49vSBz4o=; b=RuaU5Ph7zgpJwz/MtS9tFnI
	eZR2G95n5TJrfHyl7Q13TioYuTJhghxmhBuPmVOyWt06PFPiaYMGwg9h8FFcozyc
	EHOcHT0bw5XH20dTPjp22vbREbwaNINQOC9NYh3tfYVQeweHSVTRnMlnowHNvtSM
	DuUPhcsv94uTh0DXqvg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DgRFfGCF5wGlHKNZrurCAMP6Rd7rVFSctz+75KnfjwUaH96V1
	rAcnpSullhILuHxPiuK6wTO0KG1vlzTXdsImfXFTrtqQWxAq2E3bijmb+ZERaAI+
	EabUILYExYlqqaP5y48zTMJ/OAK++WUDJT0RPJGtQff7x9kzszpaeIHdXk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38A8059991;
	Thu, 15 Oct 2009 03:39:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97AC559990; Thu, 15 Oct
 2009 03:39:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D909358C-B95D-11DE-9AC3-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130379>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This v3 series is a respin, and includes fixes to address reviewer
> comments from v2.

Thanks.
