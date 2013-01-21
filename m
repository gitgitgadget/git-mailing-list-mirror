From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 16:06:03 -0800
Message-ID: <7va9s3jt78.fsf@alter.siamese.dyndns.org>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com> <20130120233422.GB3474@elie.Belkin>
 <7vehhfjteu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx4uI-0005Ze-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 01:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3AUAGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 19:06:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab3AUAGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 19:06:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0D39BBF3;
	Sun, 20 Jan 2013 19:06:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxYUDpR7XbQ++12V/VNSSrKXccU=; b=mmB3xp
	qMK47H3WQMgIcOKReX7fsb1GWQJFG1OIVoMeE8qeNYBHiA68hN0ilKx0wsr81cY+
	+co5xDoXWEEM1lf/JoVBvW1sHnSYRolkLwMbTIWn1lCJQ6dIad0YzuXI0yi9KkRp
	ff8Zxh66VNIADznAN5etdmVqvTjl0RqQ7KgGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ysn2HgDi4Gpm9A9ExYUwU6EEzxLzey5m
	rV+Wpg/UWCUjLzwueHGbv94S2q/2yDj7XXxvBmqvDLTwFCArPMCMucw1n3RPwue8
	tS4P+7cM1czn116PDmKJO2pSczs2Fm/mE+Ql6kv/4SEO+uU3NCjPmcEVLb9syNy7
	9EJNvCc4HR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C6F1BBEB;
	Sun, 20 Jan 2013 19:06:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38C64BBC4; Sun, 20 Jan 2013
 19:06:06 -0500 (EST)
In-Reply-To: <7vehhfjteu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jan 2013 16:01:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A8D1940-635E-11E2-ADED-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214061>

Junio C Hamano <gitster@pobox.com> writes:

> ..., so I do not think it is a big loss to rely on the same
> assumptions and choose b. from our point of view.

Of course the last sentence is a typo: "choose c." is what I meant.
