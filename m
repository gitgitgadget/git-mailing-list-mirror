From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Allow HTTP user agent string to be modified.
Date: Thu, 12 Aug 2010 10:23:05 -0700
Message-ID: <7v62zfu4na.fsf@alter.siamese.dyndns.org>
References: <AANLkTikzCVAb8YOZQhZ-sd6uhngiAQnhkB-k_JFZMem=@mail.gmail.com>
 <1281559238-30151-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jacob Helwig <jacob.helwig@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbV3-0001MY-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab0HLRXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 13:23:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0HLRXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:23:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51697CDA35;
	Thu, 12 Aug 2010 13:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NhE3KRNWhvNfdIYc6H2vvku0fTw=; b=wV+SwrO+CDML8tQPouiywJB
	kHbkFC+up6AfydhaAAyJP4j/x50qlPU8gDGSpUkBc5n0Bv7qqwFpSFhJvy7LtAGi
	62MUwXIs6hDc2kTEf7T+hldNSHHlplV/c3y7pZ/RTWZ+newH2wZUW3zgcveyUMWy
	4jJZd0UA4AzJOE2PpUPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Xv5HlQILRI94InTr+1l2Zk3W6TAHjuZiRrPwj/sJHnbFiccT4
	ZA6B07z/b5erh+hl0Gr/LqqtpXALX305SBU1+4ZjGlVUdEuIoWuNgHwMXXumwyCN
	al3h5h8kpLGCNvB9RjyMQ/ZDz6uclYCRL7Z0tcsgCBgJRv3e4hzIBYAUK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D81C1CDA2F;
	Thu, 12 Aug 2010 13:23:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1FF6CDA2D; Thu, 12 Aug
 2010 13:23:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4A40639A-A636-11DF-82CE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153392>

Looks good; thanks.
