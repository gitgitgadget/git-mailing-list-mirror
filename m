From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add `init.templatedir` configuration variable.
Date: Wed, 17 Feb 2010 10:59:32 -0800
Message-ID: <7v1vgjsn6z.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171242150.2477@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:59:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhp7o-00006n-0N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 19:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab0BQS7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 13:59:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab0BQS7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 13:59:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D97389A870;
	Wed, 17 Feb 2010 13:59:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=C28ym67ZTzoPsBCbRHcs32oWuYw=; b=bKXgjG6CDt1oUEZbmD5igzQ
	4cFnwuqdA/1UnKX9INi2T5bbXbafwXLCLvAIMuMzqz37KLEXkzvpMpZvJYob4iwj
	cNC61QzD1fMEH16igOwifRnSZtNDCIXtizFv8VlkA/Boan5KwxDV0O1mTBKZ4+nZ
	HWDh/VB2nUi8jvd0pWXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fyDH653XF4+DU+yxRGaB+PQORt9K9PY5LWDjvupQA8KsnmKuE
	ZWvCptW71/PcRtLNmXG7u0LI4rHGlL4Hp9gh2pCTt1KLRD+hD/RG/FKl0NWxDOTA
	eWJcf2A26h32/ys0ZUPW56ydvT6jfjdGM2wUnohjzQAhAVvOuYS3aphkB0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6010A9A86D;
	Wed, 17 Feb 2010 13:59:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB2DB9A86A; Wed, 17 Feb
 2010 13:59:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97979A2A-1BF6-11DF-83A4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140245>

Thanks; I will make a minor touch-ups to both of these patches and queue.
You may want to add a few tests to t/t0001-init.sh before they get merged
to 'next' branch and start cooking.
