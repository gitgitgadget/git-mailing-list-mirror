From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 15:21:24 -0700
Message-ID: <xmqqtwxa3ul7.fsf@gitster.dls.corp.google.com>
References: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:21:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaXCV-0006zW-RY
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 23:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbCXWV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 18:21:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752117AbbCXWV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 18:21:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B8D94355E;
	Tue, 24 Mar 2015 18:21:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; s=sasl; bh=mbYfyEqYSZnPllhbYnPWiBdd7
	LA=; b=F/Q8L6WdvZGSCLkZa64M0coe+pqiPrltE2icK1z8vy6bs9uQe3cpg3avm
	jj+GwMtZtZKiZF3pLoP4KubIpGnJJFEnQqOkxwIrZ/WTkY0w7ne9+AwM4E0afhE6
	/PK/A9+TS9uYK0e0qppu3JO+PkW/Rk5B9Ehkhj778QRAOpHCwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; q=dns; s=sasl; b=H0KNNo8FP8rF70A9oJb
	niHHcZk3OrVseC1RBBFnryfBRnSYfN8PSRCFCX20JRxJZI8Qjos4PNg7V2nQVULO
	ExtxLld+kkNO4AAHeryFDcCksktEgZh0kMvRRGC1Hl63Wei93jk2YrGw8od1b0iY
	lBw/SXAGvo8LrNz2eGvMszQo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04D464355B;
	Tue, 24 Mar 2015 18:21:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8074B4355A;
	Tue, 24 Mar 2015 18:21:25 -0400 (EDT)
References: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl>
In-Reply-To: <xmqqmw338khu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Mar 2015 14:35:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BFB3CB6-D274-11E4-8058-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266234>

> * pw/remote-set-url-fetch (2014-11-26) 1 commit
>  - remote: add --fetch and --both options to set-url

This has not seen any activity for a few months since $gmane/261483; 
is anybody still interested in resurrecting it?
