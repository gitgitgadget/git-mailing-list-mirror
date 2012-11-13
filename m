From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Tue, 13 Nov 2012 12:01:05 -0800
Message-ID: <7vbof1e0hq.fsf@alter.siamese.dyndns.org>
References: <20121113175205.GA26960@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYMfj-0005ny-P2
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab2KMUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:01:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755689Ab2KMUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:01:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30FE1A6BB;
	Tue, 13 Nov 2012 15:01:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2UDYZNjERnOtx+1oyDBhkwktk0=; b=UbKwkn
	vYfoTXaanMq+7gKl0/dgY/Ma7zy470P1LnW2yV7Ry08iXWDh1bd2l4zdtgMuk+aj
	TODgYuXwZqGymY5a/FCsju1LtS1IZmruPyKsVb2VIJ2iJ6DZZNMcThZf5XkyIle4
	LOpVulT7GWqlojHOWW+0TsYH0y1mL1/mBU91g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0ePx8h9YNfxL/WBwPZHbRnn1zQm7e27
	3nm8b9prMvMiuwo/7FM/Gdczz6j8A+GqHf0vceeiMbAmrv8nXCztETRWYUi+qfjh
	NlHELfmxnpSi2Ibv0tvVY8jchB6fMwciBS3Pv73nywH1B96dLUEOA5Nc8/oTFHtZ
	HQmJVcr2Jyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AC25A6BA;
	Tue, 13 Nov 2012 15:01:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F094A6B9; Tue, 13 Nov 2012
 15:01:06 -0500 (EST)
In-Reply-To: <20121113175205.GA26960@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Nov 2012 12:52:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC3A943A-2DCC-11E2-8A33-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209665>

Jeff King <peff@peff.net> writes:

> This is my final "what's cooking" as interim maintainer. I didn't
> graduate anything to master, but I updated my plans for each topic to
> give Junio an idea of where I was.

After exploding the first-parent history between your master..pu
into component topics and recreating one new merge-fix for
nd/wildmatch topic, I think I now know how to rebuild your
integration branches.

I still haven't caught up with the past discussions (and still am
slightly jetlagged), but I think I can take it over from here with
help from contributors.

Thanks.
