From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Add testcases showing how pathspecs are ignored with
 rev-list --objects
Date: Tue, 14 Sep 2010 09:02:33 -0700
Message-ID: <7vmxrk8g9y.fsf@alter.siamese.dyndns.org>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
 <1283961023-4491-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 18:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvXy8-0002QO-KP
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 18:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab0INQCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 12:02:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab0INQCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 12:02:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3681D5D4E;
	Tue, 14 Sep 2010 12:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C8Eu1+25M9ySpAx0SyrQh20NMBg=; b=AhFP+8
	00sHGNTE+aGe1Jk0fj/fEiQJsdxOGJ1F6+U3gPaxuUcaechC2fwthqJGTqAXMgXS
	sPRC0xX3SpXKHYcQgTzR6OJaiM4jOaPqJyasweaStIpHdt+ekwmiP5tZ/NlEPXci
	qgtOn8Gc/v6tINgICcYk/2oASuioofeO1vSKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDYFD3A7uJdczmOBNDgif8FNL1h4ihvr
	E2sj2glxSYXOynbmcVj6ye6GaRETGgJFBdHbQszww2PtFqQItwSoK11cpshnbOIu
	ePfZHUSuO2e3lzE+Q3xYgczIVgBFBG6zQdsCGQgok1YdEKjy70ZpIw0sQcAaoflG
	IrRfpQWqsbo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD26D5D48;
	Tue, 14 Sep 2010 12:02:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBACBD5D45; Tue, 14 Sep
 2010 12:02:34 -0400 (EDT)
In-Reply-To: <1283961023-4491-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  9 Sep
 2010 01\:50\:20 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F2D561A-C019-11DF-B088-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156197>

As I hinted in the earlier round, no need to "demonstrate" the breakage
and then flip them with s/failure/success/ in this series, as --objects
were not designed to be used with pathspecs to begin with.  Just add the
pathspec limiting feature and protect it with a new test.
