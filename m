From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Sat, 06 Feb 2010 09:47:00 -0800
Message-ID: <7v4olu45pn.fsf@alter.siamese.dyndns.org>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
 <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
 <76718491002052018s324747ecj31963b493868dbbd@mail.gmail.com>
 <7vbpg3dldq.fsf@alter.siamese.dyndns.org>
 <76718491002052119j5d6bae35s146bed8da03e3983@mail.gmail.com>
 <20100206133227.GE321@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Sat Feb 06 18:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndokw-0001my-J2
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 18:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339Ab0BFRrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 12:47:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab0BFRrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 12:47:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A717797AFF;
	Sat,  6 Feb 2010 12:47:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i+LAVOpa+70zydh8plLHe4ZNWV4=; b=oVOafR
	b1dCpuu+WgE4fqHI1PRXnKPNfjipZVR1QKF3NkazZwLNvpfFkuDODiSO75pLi4T1
	BmsDY8ge/7+BL9jOXbjuZPBNHXbpuBBgxE8naUS9jwzRxpMNK6xSWY/OIcC331G+
	SrIGcZEt7ox6DHWKyb4KJAl0xRuKCEzTZqEDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nah5aASfpDFmkccDm0MuxwXr4HkKqBRm
	JRxImPTw1sQfupuvxd2HdtrVEh5rlGcP9dBak482zwFCV5ez/A2OpRVJsNyv3VnX
	sBGE0qgcqZPk2oa42y4drVoxlKttSXx2p21fy6hXVGnnaWQof8NoyuAiPuUuVGaB
	yMtmO9tv7/k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECE797AFC;
	Sat,  6 Feb 2010 12:47:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE5C97AFA; Sat,  6 Feb
 2010 12:47:02 -0500 (EST)
In-Reply-To: <20100206133227.GE321@thunk.org> (tytso@mit.edu's message of
 "Sat\, 6 Feb 2010 08\:32\:27 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4B6391C-1347-11DF-BEC1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139179>

tytso@mit.edu writes:

> I really don't think it's a contamination of the log when it's used to
> record a cherry pick of patch from the dev stream to an older
> maintainance branch,...

Ok, then I'll happily scrap my earlier comment and accept -x to rebase,
too.

Thanks for a feedback and injection of some sanity.
