From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Refactor git-completion to allow ZSH usage of PS1
 functions
Date: Tue, 26 Apr 2011 10:21:36 -0700
Message-ID: <7v62q1exnj.fsf@alter.siamese.dyndns.org>
References: <1303824288-15591-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElxU-00033R-Dy
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697Ab1DZRVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:21:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab1DZRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:21:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6F1631EB;
	Tue, 26 Apr 2011 13:23:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xyJEwqo14etsz5ttw0STHlHgH50=; b=po1zxf
	BDQ38Srgr5k1Kr6G33tO15UKj7yjxUtbwGyZ4O3lQgP6eTA/opP7/nDQ/xJgx8ug
	T4g77at+SkjEZv7Egt3WWDOZ5bO7kAza9cLVO2SYoesq/hLJPtl71o7Ocyn5HBTx
	UO6Cb+JitX2kkLTazyUX/vYnWtKrXz3cvlVrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jXdkQgPKSeWAO5WNLwlMlOFmUUXGYQzk
	csAK0hmSlP1vhswXuPcYF6I9CmUvXAFpqCDG1sGl7AFRYnt2M6GFKjeX+f9aZWwv
	C6iRRpMppETLuaw+t7VYP3eD1rKHwcpG8KwMObFdDIPbAg/Qm48Od7r6qjobbv1I
	nnLPDvqupyo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6576931EA;
	Tue, 26 Apr 2011 13:23:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2533231E6; Tue, 26 Apr 2011
 13:23:39 -0400 (EDT)
In-Reply-To: <1303824288-15591-1-git-send-email-mstormo@gmail.com> (Marius
 Storm-Olsen's message of "Tue, 26 Apr 2011 08:24:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F094818C-7029-11E0-B8EA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172112>

I'd be very negative on splitting this file into more than one files.
