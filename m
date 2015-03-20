From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 13:21:41 -0700
Message-ID: <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Schneider <thosch97@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:22:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ3Qa-0007o4-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 21:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbbCTUVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 16:21:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440AbbCTUVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 16:21:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E608C411ED;
	Fri, 20 Mar 2015 16:21:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BVv/d3IIls9wNDoRh6wRiQs4jKw=; b=poNau1
	+VM9kzvL4f0qAJJJX+kjLV4uxwPKHutpNaw/G+/g7K4dcNOdvAUebKwLSp3lRjAz
	Q8F2U5wSzfbZjC6+YATOUTcW2EhtT40BxmyDgWI59PxEQfji8E7oc3DE3GKgBNjH
	6Famwsb4od5HP3S4g6SVk4ufGb+4PGlhnUZC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfHol3BnIALEYZ8AsCxSaKxMZy24El5/
	AO8nIknd2fxtH4a6JG3UxIBjcsqKuiLZ+RZqkKpSM/gRCFJ45ZtY36Ey8e1LTlRC
	OA5rqAoTDbZXjHrd0HFQlTi+TEy6yefX7RQRP8Er/GPhBIwnPhXWrVJwFmZm8kon
	cSCpmMgRbcI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF5B1411EC;
	Fri, 20 Mar 2015 16:21:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09677411D4;
	Fri, 20 Mar 2015 16:21:42 -0400 (EDT)
In-Reply-To: <CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 Mar 2015 10:19:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC38AB16-CF3E-11E4-9A55-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265963>

Stefan Beller <sbeller@google.com> writes:

> ... though how would I read man pages in pdf
> format? I tried searching the web and all I can find is how
> to convert the a man page to pdf. So is there a conveniant
> way to tell `man` to prefer opening pdfs when available?

I presume that "man -Tpdf git.1" is not what you are looking for, as
that would literally be how you get the manpages in PDF format?

Personally, I honestly am not quite sure why anybody wants to
generate manpages in the PDF format like this patch does, unless
they are planning to print them on paper, in which case the existing
manpages (git.1 and friends) or html pages (git.html and friends)
should be an already available source format.
