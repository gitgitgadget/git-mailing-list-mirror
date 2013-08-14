From: Junio C Hamano <gitster@pobox.com>
Subject: Re: conditional config syntax
Date: Wed, 14 Aug 2013 08:41:08 -0700
Message-ID: <7v7gfouvor.fsf@alter.siamese.dyndns.org>
References: <20130812123921.GA16088@sigill.intra.peff.net>
	<CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
	<20130812154520.GA18215@sigill.intra.peff.net>
	<CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
	<20130813114635.GA16506@sigill.intra.peff.net>
	<7vsiydy2i1.fsf@alter.siamese.dyndns.org>
	<vpqsiycn33b.fsf@anie.imag.fr>
	<20130814074035.GB5095@sigill.intra.peff.net>
	<vpq38qcmzw1.fsf@anie.imag.fr>
	<CAPc5daWqzTkMFkecrAjMCmxwZZrgUtB-FVKrjsmfvpgwPgF8AA@mail.gmail.com>
	<20130814140853.GA32605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 17:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9dCN-0008Uy-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 17:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759985Ab3HNPlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 11:41:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758769Ab3HNPlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 11:41:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 784D5370E6;
	Wed, 14 Aug 2013 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHOn6L7OhxO2EFPR+zbdyrFt2tI=; b=XsPrZr
	GjlhdS1WStqiOgMVrxHSWzjmCnmQ65iSFdniU/Z1G/5d5kg3hWkYISxgzaapnRm2
	YQBGXgQDQcs254UWta70IVwadCBF1+cAt4RS4zCaE3sEyYsg09C06GugIeq0ehS+
	1jzc7b4xETtGYI4s95Iv+kKsFSUW/kA1NFHhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySX1KvHsBV2MMuwkfVVr0Ol+UTsbZJTI
	uZpJ5rZQfAzFUZd1tp6US2t3ylEAnFJvWldfNM8Cmqxou1c1KrG0bNMJGc/sqx0U
	3rlhu4kr4L1Yziog0a4kA716IJutBe0xB6/Ah958tGC4b5+GRerbuh5ZmhL15zGu
	YScuJuuoCXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BCCE370E3;
	Wed, 14 Aug 2013 15:41:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3E7D370DF;
	Wed, 14 Aug 2013 15:41:09 +0000 (UTC)
In-Reply-To: <20130814140853.GA32605@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 Aug 2013 10:08:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1043FA8-04F7-11E3-86A8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232289>

Jeff King <peff@peff.net> writes:

> Or hmm. Maybe that is what you mean by "choke on it". Choke on the
> invalid config, not on the new syntax.

Yes ;-)
