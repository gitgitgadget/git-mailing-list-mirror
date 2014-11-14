From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 15:29:28 -0800
Message-ID: <xmqqh9y11huv.fsf@gitster.dls.corp.google.com>
References: <1415995993-70879-1-git-send-email-blume.mike@gmail.com>
	<20141114232106.GA6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Blume <blume.mike@gmail.com>, git@vger.kernel.org,
	dborowitz@google.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpQJ5-0000ud-Ph
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 00:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbaKNX3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 18:29:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161966AbaKNX3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 18:29:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62B721E9A6;
	Fri, 14 Nov 2014 18:29:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cv1hjrjTBHGU96Wqg1i5LKCMXwU=; b=Nja+sj
	/przcNjql/2hVnZHmZpJH/OB0lMW6i71RvKph2e6aG/3Wc/rPNH+1VmwJYpM/QB+
	pPeUU+/Ooj/HTT73PmnM5MmN+cxb/peEiwXz76hpqlBeaET/blKtvUZE4A6z8SBp
	kQBGbxHxIcwXZSuhJ1jF52Dp0bwfal7pr8L28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ir5Y2DAXAF3plT/a3Ls1/Sn/w9/wscSp
	GiD6ONHkS+WGEBxxM14j7yTKn3aCHsLeSlFto0ABP66J8u6bahkRUvFamCcE4P6J
	4FLez1onGVMVOVqUixfzzmYycm6MOfJpd+zoemWZ8ZEVbBqK/4Cfm9DRdMwllBZy
	nB08Jwq42sI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A2AD1E9A5;
	Fri, 14 Nov 2014 18:29:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE06D1E9A4;
	Fri, 14 Nov 2014 18:29:29 -0500 (EST)
In-Reply-To: <20141114232106.GA6527@google.com> (Jonathan Nieder's message of
	"Fri, 14 Nov 2014 15:21:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14B886F4-6C56-11E4-BB35-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> *puzzled* Testing on Yosemite with the following script[1]
> ...
> still seems to hang eventually (after 61 iterations when my officemate
> tried it), reproducing the bug.

Thanks.  I've merged it to 'next' and pushed out the result already,
but we may probably have to drop it.
