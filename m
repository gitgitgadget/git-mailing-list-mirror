From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe not showing "nearest" tag
Date: Sat, 04 May 2013 23:42:18 -0700
Message-ID: <7vmwsaudv9.fsf@alter.siamese.dyndns.org>
References: <877gjeav64.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Sun May 05 08:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYseQ-0003Nt-TG
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 08:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab3EEGmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 02:42:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab3EEGmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 02:42:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA46416F2A;
	Sun,  5 May 2013 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gRDbBEKBrbSmj//HPDsLGP7PVAE=; b=edlFfg
	8IMBb640Y5jJeMYse+Li/un2gmz7CMaViI3ujwAnZ8vSygEuBkuJadDWo3lH//5M
	7aiUxqiozaCSbwi6Gu10NHyF7tYg88w89BqV/x4ZWLtCv0Y4TJS5ZS/DJu6VNt9W
	4fJASwFcs/ffMoFI3FVjct/GbK/TeQO10KA0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gAnxBzUkQiH6bmem54CNVbUu/6T6BbJq
	UWTByUczrXyeBNS8kjsGL6/RFkRTt7mwz3TgfH65A1fGkq4YWNdmZsZWMeQARb16
	iErhtcDQABPtdeybEv/v0nzLsmiVh+IfSBN7XZL4OWKTbZK1tE/5TdgLElsWvngv
	UmJDnRHWXL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFA516F29;
	Sun,  5 May 2013 06:42:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 647DC16F26;
	Sun,  5 May 2013 06:42:20 +0000 (UTC)
In-Reply-To: <877gjeav64.fsf@mcs.anl.gov> (Jed Brown's message of "Sat, 04 May
	2013 23:48:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF77D026-B54E-11E2-8F1C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223393>

Jed Brown <jed@59A2.org> writes:

> $ git rev-list --count v3.2..master
> 9651
> $ git rev-list --count v3.3..master
> 6378
> $ git describe --tags master
> v3.2-9651-ga018267

Is 'master' a descendant of v3.3?  I.e. what does

	git rev-list master..v3.3

say?
