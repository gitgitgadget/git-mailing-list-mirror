From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 11:57:24 -0800
Message-ID: <7vmx8dl1ln.fsf@alter.siamese.dyndns.org>
References: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZMa-0000pq-G3
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab2BTT51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:57:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab2BTT50 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:57:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 576A67B95;
	Mon, 20 Feb 2012 14:57:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NClvZNze+YCMTjgrG6WWHX1cuYQ=; b=S+vyg5
	sThjU5kyuBfI6kfN428h82StrLRBgjA4L2TtZInMxW0eLRcIdtx9YemvvTheRYF0
	L54NiBY2LkeTdHoIx9wO/mGfe7XhnVgML0zOgihu7LUusCpfPOB1+0kMpowFKz07
	VAKE1iZYPPYQsAhabqPJfEpvm8mLf+4Waw77I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nnY8GIFqD3dy51SAor64ez82/iuj52fy
	EHqNaqFpetazPAG1Q6yAexCAY0wFhOuFA0p3m7jzOIWDbN+A+Dc1zmYV/frrF+uy
	i+EV+0u183huElQcdgcEoINqxMc1i+Gk430YcD/l34N8tgrY2D1+CaSk2rR4uTe7
	BkAMlFK4Kqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F9317B94;
	Mon, 20 Feb 2012 14:57:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1C107B93; Mon, 20 Feb 2012
 14:57:25 -0500 (EST)
In-Reply-To: <87ty2l38ay.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 20 Feb 2012 15:09:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C643504-5BFD-11E1-9870-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191094>

Thomas Rast <trast@inf.ethz.ch> writes:

> test_expect_failure 'checkout gives cache-tree' '
> 	git checkout HEAD^ &&
> 	test_shallow_cache_tree
> '

Depending on what state you start the checkout from, that is not a valid
test.  Some form of "git reset" before the checkout to ensure the initial
state is needed.
