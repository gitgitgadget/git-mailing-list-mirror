From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: check for valid commit from server
Date: Fri, 19 Aug 2011 13:18:13 -0700
Message-ID: <7v62lt2m0q.fsf@alter.siamese.dyndns.org>
References: <1313674563-12755-1-git-send-email-pclouds@gmail.com>
 <1313766693-20798-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 22:18:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuVWH-0005Uq-DJ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 22:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1HSUSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 16:18:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553Ab1HSUSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 16:18:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D124436;
	Fri, 19 Aug 2011 16:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vaaC4vtYb1ttNPZyQF3GOJjW59A=; b=ocPB8H
	WWE1Kp2FmQAquu07gaUIWcdIk0+eoY/weJymhXujPD+agyYXzoJlERdnx0IepRod
	izqMJT2QQRuGJ09YTTOkPnLqTAabFkLTWilSSaHW8FED/WaVw2qqhEXSkohj+jl2
	l1ZRt/UtNo18hvH6YYd3cRmc3rA0v+gHQkiTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZPzAsaPVwEL/MHtJuQafiM+8er8DpdcP
	DUgJo3eM2bTMLZNoRTzeGxeVZtA6oWJsGNufxYO7jg7XB6gfy3qeqp4Gse/wZspW
	qYC3FCPl8TVAYUgfFtGCiIYb23bN7VHOIzAvNkyqSpeZVWSAo/1f0CcZXEo6A8/5
	8sJTm1FrZ/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D58D4435;
	Fri, 19 Aug 2011 16:18:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 348B84434; Fri, 19 Aug 2011
 16:18:15 -0400 (EDT)
In-Reply-To: <1313766693-20798-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 19 Aug
 2011 22:11:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EA05090-CAA0-11E0-B6F3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179722>

Thanks, but already queued the one from yesterday in 'maint' ;-).
