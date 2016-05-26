From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] Persistent submodule pathspec specification
Date: Thu, 26 May 2016 14:12:04 -0700
Message-ID: <xmqq8tywv80r.fsf@gitster.mtv.corp.google.com>
References: <20160526204730.20309-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:12:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b62Zi-00071X-O7
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 23:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbcEZVMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 17:12:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755198AbcEZVMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 17:12:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6AED1E8D8;
	Thu, 26 May 2016 17:12:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZFJ11POxgG8HZ+iO+BULUnEeT1Q=; b=GNYkvi
	h9c477XARsY7tjLWG8IELITvg+UPJmowjrIOg4I8xaMsDRgGUF/d4l/9aPzMINLH
	YkwIgIgbGPI9Meex9uWVfrnCkHP163frw33SNlLlU7nvNu9DxRn7LwNB1ZsYedEt
	D2p0mysds/NwPupZqWjrlNyk0ND+GODO6PGxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jcO3DRSi4ngS0JTnJ4uyD+48ar6wsWaG
	JTLA9wP2tdi3DEvn+aPihRYn9yuqDSID2ow4s4tjYGdGQ88pzm2bFqU1Q+lHqMsY
	VWAC2oE4u4qP+iGoJ1c5P+5WoZTg9uI3VfkbZtl9Mo/zmwpgxQOPLDXeOMEWqAkJ
	s/WYR9aRgwg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC3461E8D7;
	Thu, 26 May 2016 17:12:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E0F21E8D6;
	Thu, 26 May 2016 17:12:06 -0400 (EDT)
In-Reply-To: <20160526204730.20309-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 26 May 2016 13:47:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8026B0EE-2386-11E6-9352-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295694>

Thanks; will replace.
