From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Thu, 04 Dec 2014 14:10:57 -0800
Message-ID: <xmqq7fy7rrpq.fsf@gitster.dls.corp.google.com>
References: <547C8610.8080301@cs.uni-saarland.de>
	<20141201233515.GV6527@google.com>
	<xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
	<5480C60E.3070903@cs.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Christoph Mallon <mallon@cs.uni-saarland.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:11:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwec9-0002CS-UI
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 23:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933235AbaLDWLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 17:11:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752997AbaLDWLA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 17:11:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB52F23788;
	Thu,  4 Dec 2014 17:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+WvwYy3ikdDZdYrD4soQF5lcEN4=; b=sM0YVX
	DapdgwbAwc2z6y3BRHC/31C52nTpOcmuv4ag4D1bGDGhcA/4Tby91rbIEr/rQXZs
	Ggt7du0jAGyllTXvJZLc8FNs6FYZkO5OiOigY/mqrE/4+JMMJOCdqp69NLeF3Pmy
	C4dzKzDO8VXjVUTvCQWelyV6GL+sUfFoFgsOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wRLKCF+2T35/ys0diSz9YIEaMntKaRAc
	fzJNPoaxMFXwYiTtfvZ/CLZ1/ONPTFnNlwuJGxZ03/+1ie8gd1F4uXeKhqpaW+Ih
	mRld/k+TmsiIb26fTg8Uph/7hjVCOW615lRn16HOnnR2l/Iqp/8vnSvEExj4GG/e
	AkX2/cLNA2o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E85523787;
	Thu,  4 Dec 2014 17:10:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1764E23786;
	Thu,  4 Dec 2014 17:10:59 -0500 (EST)
In-Reply-To: <5480C60E.3070903@cs.uni-saarland.de> (Christoph Mallon's message
	of "Thu, 04 Dec 2014 21:37:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D27F7E6-7C02-11E4-B9FE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260808>

Christoph Mallon <mallon@cs.uni-saarland.de> writes:

>> Amen to that.  I am getting the same thing.
>
> I ran reproduce it reliably on multiple machines (OS X, FreeBSD, ia32,

Oh, I do not doubt you see a problem.  I am just saying that I don't
have an easy entry to the issue without it reproducing for me.
