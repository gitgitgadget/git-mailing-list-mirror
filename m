From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Sun, 15 Nov 2009 12:22:09 -0800
Message-ID: <7vhbsvk07i.fsf@alter.siamese.dyndns.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <200911151324.05109.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 15 21:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9lc7-0005Wa-P4
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 21:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbZKOUWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbZKOUWM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 15:22:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbZKOUWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 15:22:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CAE57FF07;
	Sun, 15 Nov 2009 15:22:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bRvnRROFyJuiRCHM1wxYbReqrLE=; b=fusVND
	dLQ9ft548fk+WjyPj+BJpMSJCsbqy/cDUo3mtwjtv61E0XJ6M1Zjcg01xVTmMzyZ
	CsCDAvfhk9eqMz+LO4HgWNzAHLyTMH2JorQZqK4CauUJmWP5rLD4yZ7URk91V0dq
	jeBahb0xGo7gbaOSLNCKmMRsVqiQ260q9uHLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BRuy/HrC/9QECNSyH7JsU5zkNfIWOF2i
	noJ0jT0z48BvEx3H82Gy6SlY5SqrPJ3GxeUrTBgZCBhwq2GTjS2XNraailvFfGz0
	dai+qwAVjApRaiCUpxj5MMY/+wejmca3+Tb6rSvRvuscL6KSGJY/zTSJxX6AJs5z
	/oX3c1RzUAY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DDDB7FF05;
	Sun, 15 Nov 2009 15:22:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B22FF7FEFF; Sun, 15 Nov
 2009 15:22:11 -0500 (EST)
In-Reply-To: <200911151324.05109.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun\, 15 Nov 2009 13\:24\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8FEA8A6A-D224-11DE-BBDE-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132958>

Thomas Rast <trast@student.ethz.ch> writes:

> Yesterday on IRC I helped 'thrope' with the github pull requests
> guide.  This is a wiki page, but placed at a sufficiently prominent
> URL to make it look like an authoritative guide to a new user.
>
>   http://github.com/guides/pull-requests
>
> I have since replaced the part in question ...

Thanks.

It is hard to control the quality of random third-party documents, and
such a help as yours is greatly appreciated.

A document with gross misinformation is much worse than not having it.
