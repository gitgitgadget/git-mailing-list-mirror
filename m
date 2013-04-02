From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 5/5] Help doc: Include --guide option description
Date: Tue, 02 Apr 2013 16:11:18 -0700
Message-ID: <7vk3ok8r55.fsf@alter.siamese.dyndns.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
 <1364942392-576-6-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, "W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 01:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNAMp-0005oj-KD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 01:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab3DBXLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 19:11:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757322Ab3DBXLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 19:11:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D10D12AF2;
	Tue,  2 Apr 2013 23:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fl1zQfkaqi2Z3wiflzhsipjuhIA=; b=BDhT5j
	WiDtQ4aw1t18oLJwgJrLihwA1wDeOacyhYPryorbj12r5aPdlwArwac3GhOqrXd5
	8LnjjuhLoIT1SNXrkNj2UYFLXFSRH1rA7Nq8hi5+b38zqfVzLaOnwSJhQjYslm2z
	yiDN3lmzw1vEVfU2ULCSxHaHiV0xc8en1K8oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnoNpi2PAGmQXJfORwuiLHUBmFAxYriW
	99rWKwRTK5j+STACfDF4SfRbLWHLV+M/6aYt0U+sWtmJOXoSTYcbwbtGM82enSQN
	emU/RiWsLg3KdP9aSSdo5faPTX3Xfd2Vp3JjsA5W+IZPSBcMoLzg3z8o/i+1OqQT
	wEPQpExEKBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2505712AF1;
	Tue,  2 Apr 2013 23:11:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 945E112AEF; Tue,  2 Apr
 2013 23:11:19 +0000 (UTC)
In-Reply-To: <1364942392-576-6-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Tue, 2 Apr 2013 23:39:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0C0C38E-9BEA-11E2-BB8F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219902>

Philip Oakley <philipoakley@iee.org> writes:

> +To display the linkgit:git[1] man page, use 'git help git'.

Good to see that somebody remembers that we discussed this ;-)
