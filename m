From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Tue, 27 Oct 2015 14:01:48 -0700
Message-ID: <xmqqegggnhz7.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	<xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
	<20151027012336.GK31271@freya.jamessan.com>
	<xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
	<xmqq8u6odxxx.fsf@gitster.mtv.corp.google.com>
	<xmqqbnbkp0e8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:12:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBXP-00028a-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965561AbbJ0VB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 17:01:58 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965360AbbJ0VBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:01:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA7D72631A;
	Tue, 27 Oct 2015 17:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nxCZH1cn7rB/DlH2onBYZwKrE44=; b=UUKdTu
	KErJqO9ERN9uD+xhuBYVcYNQLQrCryvfplEWsoYRnc7U+BJABqgmFYj9AoJB7PcS
	EiTCYkpbDZvdunbwf+sxgVzL1eYw+kAT66OsqKHOyq7NFat1YkYB+LmUDZbH17zf
	ZE3x5MWdL9xbUs5ScHka/fv8w/ddqrxAtGjpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YNfvBfIMfpBj2i4gb9h6FE38k4RRhPT+
	0OeTAPXv3TJxnk4K0XWEuxPD3hMGrPxPhOIVwwgF2QNiMBmYLSOXaQkSApGeM4Zl
	Zy4nEAhAbbFTWPMjlvda5mP7hBG1u9xZywASWoITX+z87U4ovSidFp13l3ySDCqA
	Wia1C/xVykc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D29EC26319;
	Tue, 27 Oct 2015 17:01:49 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E89226316;
	Tue, 27 Oct 2015 17:01:49 -0400 (EDT)
In-Reply-To: <xmqqbnbkp0e8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 27 Oct 2015 12:38:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0D15F3C-7CED-11E5-8F95-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280298>

Junio C Hamano <gitster@pobox.com> writes:

> Analyzing copyrightability is often more costly than the risk.

Misspelled, obviously: "more costly than the other ways to mitigate
the risk" is what I meant.
