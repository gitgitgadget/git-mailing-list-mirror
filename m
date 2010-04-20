From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] test bundle --stdin, fix
 objects_array_remove_duplicates()
Date: Mon, 19 Apr 2010 22:16:55 -0700
Message-ID: <7vd3xuln3s.fsf@alter.siamese.dyndns.org>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100419071449.GA23166@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 07:17:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O45pf-0006J0-M9
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 07:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0DTFRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 01:17:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab0DTFRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 01:17:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE61ACEE9;
	Tue, 20 Apr 2010 01:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=OrfGzY
	22npdBAjQj/NOkMmdz+RtyRxTDRSHXETdWSXTf1IIqQRCMJKe9KsnD8VaMnLDqS5
	ssq2CsF3Hfq5/2ZBwmSU/93zy8NDs7MDkkL8k7X423fs8LE4TTViPKtlg5Mg4A2I
	Zg+WM/Pv7G0FKes9o0wlRtGHW3aRPOuEeRM8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RQI1QjY/Y+IY0hYHi6FyvKalNfL7ztng
	/W1OzVw29kZyO+9NWO7LCmk4kL+9pkonr/AS36dZWAAD7+31tgNqaqtMWun1fL3h
	P59XCD+6NWyzM6Me8G0QcTnl5MoL0ns0pPCDzgZ1dg3pL/iUBuq8HFcdbmwOJV+k
	TsuT77TrOek=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C62DFACEE8;
	Tue, 20 Apr 2010 01:16:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37B13ACEE7; Tue, 20 Apr
 2010 01:16:57 -0400 (EDT)
In-Reply-To: <20100419071449.GA23166@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 19 Apr 2010 02\:14\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2627504-4C3B-11DF-A516-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145350>

Thanks, will queue.
