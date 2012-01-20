From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Thu, 19 Jan 2012 21:49:00 -0800
Message-ID: <7vsjjahqk3.fsf@alter.siamese.dyndns.org>
References: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org>
 <1327029129-11424-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 06:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro7Lc-0003Ko-4g
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 06:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab2ATFtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 00:49:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab2ATFtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 00:49:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3590C7AC7;
	Fri, 20 Jan 2012 00:49:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=e4CzTW
	xq097C/IVaQrRBwArNROlqdnoFxE8xsQ2TLtkvHhM/srV/wSxyP1kiTlZp7XW9Py
	/jUso4SVI2eLDtutmn7SleaHst66imyWky/rrYqgvfQLMM+PcpAcHH0AU8USL67L
	u1V3PjwilyX2x/Pv5er/lQklnfu4WwjrdFATU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VqDQiHdteRrk7uGeZLZd6VEj0anhXat/
	ri0UXIVoIlWINcU2aGxgrFWW00Oex/wAETDIrpRp0x32tU+gCHi8nuhWLxc21SCx
	a2ae6VJzpPgmaqDdhIy+YAsKgvvjvRvpk+v50NVdyyjWMyras8oxtZg0YcYAQtLO
	N2EZIEnisSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D20F7AC6;
	Fri, 20 Jan 2012 00:49:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B84317AC5; Fri, 20 Jan 2012
 00:49:02 -0500 (EST)
In-Reply-To: <1327029129-11424-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Thu, 19 Jan 2012 19:12:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74F3ED4A-432A-11E1-B724-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188849>

Thanks; will queue.
