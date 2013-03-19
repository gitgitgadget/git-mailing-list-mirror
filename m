From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 08:43:56 -0700
Message-ID: <7vwqt3jsxv.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
 <514852D7.9080607@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:44:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyiD-0000jC-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750Ab3CSPn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:43:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932285Ab3CSPn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:43:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09A04AC40;
	Tue, 19 Mar 2013 11:43:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+NgRoHiZ2D7fJ7mitgOEU1pDpPA=; b=loHykY
	edwaKmnN3YG8jIy1uck1Om/o1ZLBf5j5USar3aTBiaVO/gIISmb+klm4zC5KwUSU
	R5FsQlvLNBKaLyi//XGrdiIpeQ1WH0xv2iFSvtHvvjk2YGy4xLrHmhRqMlb6Ur5+
	XBQ9BDqUUe/tvoqCW3BOaNosVn0fqAtD1960Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UCDXB1PNJ7lasYSdMzbhmwJiLJsFbc8R
	/w2S4UkjqRajZx37DQMC2wEPRdyIpymYETAMliEThvgsNRjw5i5kuG3MvpLixtlk
	3wSu6kgrRTgdEuP7q8Mv9ayEMW7b3BFnbg3A8x6Qmgzz5QMo0kPAQQFzSBv0BVSr
	2p+rYyqtA7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0996AC3F;
	Tue, 19 Mar 2013 11:43:57 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74022AC3E; Tue, 19 Mar 2013
 11:43:57 -0400 (EDT)
In-Reply-To: <514852D7.9080607@ira.uka.de> (Holger Hellmuth's message of
 "Tue, 19 Mar 2013 12:58:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFCFB472-90AB-11E2-8198-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218525>

"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de> writes:

> Am 19.03.2013 12:33, schrieb Duy Nguyen:
>> git push . foo:bar
>
> '.' has more like a "here" semantic, '..' might be a more fitting
> mnemonic here.

Heh, why not say "origin"?  Or rename it to "o" if you like in your
own repository ;-)
