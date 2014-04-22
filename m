From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 12:55:21 -0700
Message-ID: <xmqqioq13zrq.fsf@gitster.dls.corp.google.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
	<20140422045951.GA60610@gmail.com>
	<xmqq38h56zj0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:55:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcgn6-0003wl-Un
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052AbaDVTze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:55:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757026AbaDVTzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A87E07F43E;
	Tue, 22 Apr 2014 15:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QtMuQub3YOzFpfCy88p8frLzCdk=; b=SNeHCw
	XBtOGGf9kWSCrtYtFa0KOpolbQZC19aE3YFql0ejpFtzR45bCj7jNHa/Zmz+P5MH
	4i4pVRi+pPbwcsqcrCKKalRv59zBhxjWJhV8G9tNNHCgso9k2775nX0bZ6c6u9fH
	hAdTGHbpJWtuxsy6klOqiC6jOvwDuTy5E1ATU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZ6ZfP/lYSyUBJic5JTwq+aJY+NoM2D/
	M/x1u4vQCs60XbYjD84upUe8r3MuoJK22e7YDhpk9OS34L+4OgOM9dBxt+2lyZv8
	tzSutaRnlfYXNfUD/08kRim1iWEFvQ1vXMOuoL/w1bPDzjtwOqdFfLigS9fn1Jz4
	Fx0iKKGoiPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80BC37F43D;
	Tue, 22 Apr 2014 15:55:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BC3D7F42A;
	Tue, 22 Apr 2014 15:55:23 -0400 (EDT)
In-Reply-To: <xmqq38h56zj0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Apr 2014 10:32:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A62AA72-CA58-11E3-9BA4-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246779>

Junio C Hamano <gitster@pobox.com> writes:

> Do you have reaction to the other one "[PATCH 1/2] merge: enable
> defaulttoupstream by default"?

Sorry, that other one is not even about difftool/mergetool.

I just checked that patch myself, and found it sensible for the
longer term.
