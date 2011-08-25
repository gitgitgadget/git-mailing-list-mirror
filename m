From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git clean --exclude broken?
Date: Thu, 25 Aug 2011 13:28:08 -0700
Message-ID: <7vei09jkx3.fsf@alter.siamese.dyndns.org>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
 <7vliuio65w.fsf@alter.siamese.dyndns.org>
 <7vfwkqmfsh.fsf@alter.siamese.dyndns.org>
 <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org> <4E5696AE.4010201@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Todd Rinaldo <toddr@cpanel.net>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwgXA-0003zx-9s
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab1HYU2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:28:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab1HYU2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:28:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9994E42C4;
	Thu, 25 Aug 2011 16:28:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XdnxPYs20yr2hHrPzDSDejia9gY=; b=Ee/olh
	u81Zr3JQA4LM2R+zFyCpaRfqzTcx5XlUGbxz202KtE4Fmfm0HcsiY4NnQNUphxbT
	StcBigcRG08xT3edpjS+iNbbXf8sWr3cYhyx4Zh0qGvCCF/MVxpW75XSnEbVcJiY
	Bz6Yu102gx0BSoFzQIwMLxrlkiE9p1564hPuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yvxq1E8HhVLe1Hb8KYRPlJ6UzjIib/Bo
	tNTdw2bwxW/DD3xxlWFnR/w2/Jh/ByNAITc2RqcFaUTx7loTxRd9JP7/BY8ot2I5
	QKvO7w6syETHOTZFVRRAQoSKVCj4lww+QIQn4erFHYz7e4IlR946BtEgNw/o/tx1
	89cuLo1iPG8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA8942C1;
	Thu, 25 Aug 2011 16:28:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F29A42C0; Thu, 25 Aug 2011
 16:28:09 -0400 (EDT)
In-Reply-To: <4E5696AE.4010201@elegosoft.com> (Michael Schubert's message of
 "Thu, 25 Aug 2011 20:38:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFA92CE2-CF58-11E0-B1B2-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180112>

Michael Schubert <mschub@elegosoft.com> writes:

> Nitpick: Shouldn't this be "In addition to what is found in .." or
> "In addition to those found in .."?

Thanks.
