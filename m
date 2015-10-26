From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Mon, 26 Oct 2015 12:58:50 -0700
Message-ID: <xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:58:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqnuz-0006g0-1Q
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbJZT6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 15:58:53 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751281AbbJZT6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 15:58:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C742A265E3;
	Mon, 26 Oct 2015 15:58:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NRVS3ycvdmXfZh6c30ADJZK8ZXI=; b=sCeDPY
	Yf3bF0rwye3DPmlBb18idDNTwwuscr+nVO5AoqQDHr2Qu01iKOD0hnxXLZaa8y+2
	M4sCc2SsJzKqt8ozhEvI5HTTKtSbRF++SXOMwoEaNq+Z59Qq2eY73Oc5vFhIT5gQ
	9KpwnSvrem5oktrMIu8GobCso/4tSvQqLn/8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UbxIqiseYR/nprqkOqwemv5/3IcBvpT+
	KkW4buos+5R4rrHBrih3bWWq2WIjZh8YyQcadlG2oJAKZLjnFPioyZKOfbN4fqby
	EKXIslqBEaMtKhchk2aUy6kQuiFaFS1Y8Xgs3wrQvKGKLL5q91iRI/7u+onjbE3x
	n2xU4EyvFyM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF1C5265E2;
	Mon, 26 Oct 2015 15:58:51 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A1F2265E1;
	Mon, 26 Oct 2015 15:58:51 -0400 (EDT)
In-Reply-To: <1445846999-8627-1-git-send-email-lfleischer@lfos.de> (Lukas
	Fleischer's message of "Mon, 26 Oct 2015 09:09:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA7DBF6C-7C1B-11E5-9DCA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280214>

Is there a reason why transfer.hiderefs is not sufficient?
