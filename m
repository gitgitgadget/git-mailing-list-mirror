From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] clone: --branch=<branch> always means
 refs/heads/<branch>
Date: Mon, 09 Jan 2012 16:33:56 -0800
Message-ID: <7v8vlgcs5n.fsf@alter.siamese.dyndns.org>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 01:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkPfC-0001Uv-8X
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 01:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614Ab2AJAd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 19:33:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933544Ab2AJAd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 19:33:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5F064AD;
	Mon,  9 Jan 2012 19:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UydM+96VkYHorPpJBDcGt6YHfQk=; b=AlFWIv
	wsPqxxRU9QU033oJaNBsswFrwMVy67I1+K53mDLRVbvOSv3MaH4V/Wu25TFphhoG
	ECoGUE9qDqdnaGl5VNbjHq3NynbD6GCfUXywfOVEO7fMHoRImr4E+s9rPtLfEDsB
	gDA1re1ZqtiWs3k0zgSxOj0+PS3jzRSyxBlkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejBetToPNsfDJFctVi/ZLGtZ1HM+HXr7
	A+KfsBrE+qt8eQkKfiXsd+Jcx6CtaXUnMELG0zz3kMlrwaFOh0TREStqTUKk3WaJ
	pZAzLzrBAADJQUjAWBvLM6hyijPuNqWQk6LEMN36vz4TeB6xSn1oTmOOVfg/4xsm
	gdfLDcLnm8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2D0664AC;
	Mon,  9 Jan 2012 19:33:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6740464AB; Mon,  9 Jan 2012
 19:33:57 -0500 (EST)
In-Reply-To: <1326023188-15559-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 Jan
 2012 18:46:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C85D8FE6-3B22-11E1-B654-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188202>

Up to this point I find the series makes sense.
