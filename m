From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Allow "check-ref-format --branch" from subdirectory
Date: Fri, 06 Aug 2010 12:42:06 -0700
Message-ID: <7v8w4j8r5d.fsf@alter.siamese.dyndns.org>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org> <20100806023529.GB22369@burratino>
 <20100806033411.GQ22369@burratino> <20100806033922.GS22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 21:42:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhSoI-0006nc-E0
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 21:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935059Ab0HFTmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 15:42:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761145Ab0HFTmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 15:42:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41E8FCBC16;
	Fri,  6 Aug 2010 15:42:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VWNfcKwm9YcHH8LTmUAQRVf77VA=; b=urTxsKWAlxLF1yvlILXHuxI
	rAHBoOrrAyZCh+2dCg8qjfVhh7Yh53L0sCpkQE0mn+CJ8BCGR/wCFQZYfQMkFXMJ
	7bt9eI4Iy0/31qxWfCMFlvOyGPmJshRQSLmqDIPDbPwEZ0wYBm0nFU+sFgVI5Cf0
	En9DnX3KVYu6ZnqhDsC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mtzZV2SEkEY8O4juMgtDxsoFVAx6PKHtNI/amk+/sVhMVqiNV
	RaMkjwNzg4Na3nP2iWper4ZAUGfb8kuiSff43tkIqrL+PfbtcjUqn0xQ6D1jLOXI
	1rEhYHyciFTKjfHmE9rPQatBIpjnBgVE7Fb6AndmF2PRjPPeEu61OB3g9w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC469CBC14;
	Fri,  6 Aug 2010 15:42:12 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21094CBC10; Fri,  6 Aug
 2010 15:42:07 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5A81806-A192-11DF-B12B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152805>

Jonathan Nieder <jrnieder@gmail.com> writes:

> check-ref-format --branch requires access to the repository
> to resolve refs like @{-1}.

Thanks; the patch makes sense to me.
