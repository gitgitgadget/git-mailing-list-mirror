From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gen_scanf_fmt(): delete function and use snprintf() instead
Date: Thu, 09 Jan 2014 14:56:21 -0800
Message-ID: <xmqqy52o933e.fsf@gitster.dls.corp.google.com>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
	<1389192220-13913-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1OWd-0000mD-64
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbaAIW41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:56:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbaAIW40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 17:56:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 099B562622;
	Thu,  9 Jan 2014 17:56:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FHq8G4Af+AZHT9Fxv71nFtGvHuk=; b=cpa4uf
	6ZpkCNysFgSgbhh9U3KjYgiO17g4ermcsJajYjyPY15jra397CbCcEKTGWtH2swD
	RC0LFpIXqqJyILEMW9OHF8Zody3Y6i4r1rGEa8Y4SsjdDxbJcpxLD5vp2dofnKkb
	LiuZkIza6+xXHtQeNnwTOwfnEPu0+rJyRSMWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llaGJUJcCOCxUXNI9ulYvIvl0g3qslTg
	xOQox8CS7j1cW8bBcwKQ7Na8pk5+oRVVQJueQmv4fMfbtOb9MDJnFCa4FsfmJXne
	Q0LamIu7f+SO6fzpOSUeIqqxEn1wOA/jAwmaCJufvihbt6NYUeUCCMmOWtUAxEZY
	rzHw9SNd54U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA35162621;
	Thu,  9 Jan 2014 17:56:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2555662620;
	Thu,  9 Jan 2014 17:56:24 -0500 (EST)
In-Reply-To: <1389192220-13913-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 8 Jan 2014 15:43:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43838786-7981-11E3-906E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240284>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> To replace "%.*s" with "%s", all we have to do is use snprintf()
> to interpolate "%s" into the pattern.

Cute ;-).  Thanks.
