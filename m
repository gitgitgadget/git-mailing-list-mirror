From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
Date: Mon, 16 Jun 2014 11:26:27 -0700
Message-ID: <xmqqlhswr9rg.fsf@gitster.dls.corp.google.com>
References: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>
	<539d5765.e9fb420a.5e43.3d3f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:26:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwbc6-0003Id-9v
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbaFPS0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:26:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57996 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504AbaFPS0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:26:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6F95202D3;
	Mon, 16 Jun 2014 14:26:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vIJ4Qm24a/YLuru+LKEM7Z+9JVc=; b=LxrFVr
	RsaxPy8WLH9D2pE5YLWRXn8fzu9Y14KALbNCCTbSypYr9yi4OTgi9Z94HXM5OGbp
	LBndOkr9NyljwrucbDWhntRz1nroADLKOMUUlTKUl0Fn4Sn5IHTx/hM0AirV0Wex
	NgXyv5et97P8x0M63RBVKGfSKFynueJEefM04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eqdchAy4BeemM8kQY3fEKhRddBu7cy7s
	BEa9N0E8W0pl5Aa/rigJBt0pUXVMJDCGaoxDqkpN+V7UV1MU25eZ0tXOyRrpLqhc
	hYT6+SeRMMiVY9qEJj17PaOBxrpoH02aGjZPtgaCVYZ5IXJ5bxB/2AOjq8ddWmXY
	0RxgwJduOww=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE76B202D1;
	Mon, 16 Jun 2014 14:26:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E8E1202CC;
	Mon, 16 Jun 2014 14:26:26 -0400 (EDT)
In-Reply-To: <539d5765.e9fb420a.5e43.3d3f@mx.google.com> (Yi EungJun's message
	of "Sun, 15 Jun 2014 17:20:49 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BA4658D4-F583-11E3-849A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251794>

Yi EungJun <semtlenori@gmail.com> writes:

> Could you change the author to "Yi EungJun <eungjun.yi@navercorp.com>"
> if you apply this patch?

You can send a patch with the desired "From: " line that matches the
identity on the "Signed-off-by: " line at the beginning of the log
message, like this:

	From: nori <semtlenori@gmail.com>
	Subject: [PATCH] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
	To: unlisted-recipients:; (no To-header on input)
	Date: Sun, 15 Jun 2014 04:09:29 +0900
	Message-ID: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>

	From: Yi EungJun <eungjun.yi@navercorp.com>

	Here you write your log message, after a blank line to
	separate the in-body From: header above with the log
	message.  And then after a blank line below, you sign-off
	your patch.

	Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
	---
	 ... diffstat here ...

	diff --git a/... diff here ...
