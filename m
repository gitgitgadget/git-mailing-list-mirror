From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH 1/2] Update the flags for git show-branch
Date: Mon, 25 Jan 2016 15:17:22 -0800
Message-ID: <xmqqmvrtdzb1.fsf@gitster.mtv.corp.google.com>
References: <20160123012316.GA27965@wagland.net>
	<20160123012554.GA28197@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Wagland <paul@kungfoocoder.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 00:17:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNqO1-0006tC-LC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 00:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbcAYXR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 18:17:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932175AbcAYXRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 18:17:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86F28402DD;
	Mon, 25 Jan 2016 18:17:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uw0IPbFESirdJoDLr0OSqlvs5/s=; b=qbht1T
	FPuJ613evuw6PKaZD03c4OPN73NJHEm9lsasxvEiEyua93+sil85Rz2ckqKT3/8O
	SQ2roSVIpixdgFn8f3dga4jmPy+L3nJlkOA8AWFQaok6IRO2gkXiVaTogzIoFecB
	JgfUSYk37LY3nbfRsKd1GQ2CuZON+6bbkoXik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDgxyOJSGqomzu4jrJw5fitPFK56xIny
	lwne5wsc9Wvvh2xpPR4j5ZfuNoJ7tSzXgUegHU+uPGwcbWm8MR+w7SIeV+0svO9c
	0dfIiSFBXDaSyv0JAp48+BKC1fPoxmXyiKyfKAwDGT3ZncSYPlJwBSsn1sfizVmK
	909+HwD8tR0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E209402DC;
	Mon, 25 Jan 2016 18:17:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 03E6A402DB;
	Mon, 25 Jan 2016 18:17:23 -0500 (EST)
In-Reply-To: <20160123012554.GA28197@wagland.net> (Paul Wagland's message of
	"Sat, 23 Jan 2016 02:25:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA9C8306-C3B9-11E5-8885-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284767>

Thanks.  I'll retitle this to

    completion: complete show-branch "--date-order"

while queuing.
