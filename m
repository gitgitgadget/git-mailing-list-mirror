From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of queries via --stdin
Date: Mon, 22 Apr 2013 11:03:44 -0700
Message-ID: <7vbo96phmn.fsf@alter.siamese.dyndns.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
	<1365681913-7059-1-git-send-email-git@adamspiers.org>
	<1365681913-7059-4-git-send-email-git@adamspiers.org>
	<20130411191132.GC3177@sigill.intra.peff.net>
	<20130411203141.GB21091@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 20:03:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUL5m-0007V8-32
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 20:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab3DVSDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 14:03:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369Ab3DVSDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 14:03:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DEB318E95;
	Mon, 22 Apr 2013 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txd4os0jdzXSGdbaWHWEnbJ/610=; b=jKCLHW
	zQXNWus3RkaHv1L31huhivrdTKRGRKZFIQsSdoJt3RiehmAUplOheq02cU4Hse6d
	wRrVHc82L5pUbk1SfS2bc/0/P6XGPUdPWdwt2J34bYxcmrVh3DotaICBupBMnLd4
	eclzkyB1vywjUbENHeERACGBqbSmFSaeChcWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XOgmGY/Ywxy2emNTDsuM5oKKS6oGK0oc
	IFTRmCj6iUqo13QGzlg+ZUtCGeEuPh78CNmG9RVDyUYMZkepXeq4wFoRxaRzL5I/
	zENMaTLpCPQOUMfdJVd8s6e3atEMPTDLyw359tNjWLncOIYHaR4mqiBgH4bN1WUP
	VBB4SQ9HDao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4557718E94;
	Mon, 22 Apr 2013 18:03:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6AFC18E93;
	Mon, 22 Apr 2013 18:03:46 +0000 (UTC)
In-Reply-To: <20130411203141.GB21091@pacific.linksys.moosehall> (Adam Spiers's
	message of "Thu, 11 Apr 2013 21:31:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA36DE58-AB76-11E2-8A6B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222043>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Apr 11, 2013 at 03:11:32PM -0400, Jeff King wrote:
>> I always get a little nervous with sleeps in the test suite, as they are
>> indicative that we are trying to avoid some race condition, which means
>> that the test can fail when the system is under load, or when a tool
>> like valgrind is used which drastically alters the timing (e.g., if
>> check-ignore takes longer than 1 second to produce its answer, we may
>> fail here).
>
> Agreed, especially here where my btrfs filesystems see fit to kindly
> freeze my system for a few seconds many times each day :-/
> 
>> Is there a simpler way to test this?
>> 
>> Like:
>> ...
> I'll re-roll using your approach.

I think I missed this one and it already is in 'next'.

I'll hold it back so please make your re-roll into an incremental
update.

Thanks.
