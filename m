From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --quiet bug?
Date: Tue, 08 Nov 2011 13:37:37 -0800
Message-ID: <7v7h3axplq.fsf@alter.siamese.dyndns.org>
References: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
 <20111108212930.GA18529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Prasad Deshpande <prasadgdeshpande@yahoo.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 22:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNtMW-0000yt-L2
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 22:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab1KHVhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 16:37:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab1KHVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 16:37:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6848B5BB9;
	Tue,  8 Nov 2011 16:37:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2pEAtpRCZz9j4+8ksobnZOpLM1s=; b=Bu6CXX
	e0oO4I+9omfDL86FwcedmJ0gyXBOkg2x8+4xTuBS/hD9UBUQDYzL60HwxaxuV4O8
	vv1V+8G3iFgN171CkD/33dF27NLU+uq8b8cxHRPt+BtZtB/Y3BrxQepQhbTg3t0m
	eLkYGv9XK7gd3CeSUtYKcK1hXIJmrfHpg8Xzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GKRzCvp2ksK+vMCnAesixOPQEkWqTaOG
	QH7THAlnhKot1r4Er65PvaVG27dn+xMVc5vFybXQM49h22mHVQvEdOHgprm1aEWw
	5ZvOUWKqNGcTf7Fie3u4Krn5MvT6CyzJ9TsLF0o/RNK6xsXsiNafizxJV9QMRfYG
	W6Y39WB15NY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F2485BB7;
	Tue,  8 Nov 2011 16:37:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD4805BB6; Tue,  8 Nov 2011
 16:37:38 -0500 (EST)
In-Reply-To: <20111108212930.GA18529@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 Nov 2011 16:29:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E177A2AC-0A51-11E1-9E1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185114>

Thanks, the patch makes sense to me.
