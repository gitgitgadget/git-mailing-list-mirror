From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8
 locales
Date: Wed, 12 Sep 2012 11:02:13 -0700
Message-ID: <7vpq5rce6y.fsf@alter.siamese.dyndns.org>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
 <1346755175-31468-1-git-send-email-pclouds@gmail.com>
 <CACsJy8APtTU-7ZfTdcjg0nKoBSboNpP+7Va=akXcvn95Sd166A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:02:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrGa-0008LY-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760933Ab2ILSCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:02:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab2ILSCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:02:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2929031;
	Wed, 12 Sep 2012 14:02:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rD07lyYjkmNNx7dkXrFIEvgG9Pc=; b=Vktzv8
	LH0k4riOkeYxYNK28RFDe2cThJafTiieQ9AurMWTcs7KR+vBGTS0QKZUuAXgSMwl
	bHuTXqfl7cUaJZhVYnMp2yB5QkmV7aog7kn6j/KJcm1iwPE//7eekzpOFf8DKSa5
	0R3fTBwtBBy+RCYok9Lhk8cczPht42VQhnMP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbUCamvcyoBLlSI096zZQCBJ+QZGMmrt
	H/TGst99uDFtI/7xYkxZYr3epDGdx8VMg/7fZuZOq/lIhyHLImTkF4N+XelGSNca
	TMWkm/BOWpOm8VwMfKpYXhrPGI3K9VnNTddpnzpFgc/c2OnyuPhRTMQPsMYc7//e
	nfSAaSZXVmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49EA09030;
	Wed, 12 Sep 2012 14:02:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1379902F; Wed, 12 Sep 2012
 14:02:14 -0400 (EDT)
In-Reply-To: <CACsJy8APtTU-7ZfTdcjg0nKoBSboNpP+7Va=akXcvn95Sd166A@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 12 Sep 2012 21:02:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBBC6C88-FD03-11E1-B9DF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205317>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Ping.. what happens to this patch? Do you want to support other
> encodings as well via iconv()? I can't test that though.

I thought I refuted a potential blocker, which was an implied
objection from Torsten, in $gmane/204912 already.  As long as we
make it clear that your patch helps only "ASCII/UTF-8 only" audience
but we still "try to be nicer to 'others'" by doing two things I
said in the message, I think we should proceed without iconv() to
keep things simple.
