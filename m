From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add technical documentation about ref iteration
Date: Mon, 22 Aug 2011 15:01:37 -0700
Message-ID: <7vhb59umv2.fsf@alter.siamese.dyndns.org>
References: <20110803180319.GA13057@sandbox-rc>
 <7vei12b9aq.fsf@alter.siamese.dyndns.org> <20110822203645.GD11745@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 00:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvcYz-0006xY-GO
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab1HVWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 18:01:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab1HVWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 18:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEC1C45E9;
	Mon, 22 Aug 2011 18:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zsc8CzXUvfBSa3V02H0Wk7CRf8E=; b=NS+DVX
	1AZLwTEqacj+GozlOvvFepy2Lox3Ayp8watgQFg3JkJP8WbQcjq64R5BINwqYa5T
	GcSXdvKDGKAyL1AgFhOVd9cZiiuAST91EPWmLMbyNf3EtiPW8VbdH2iSfLzWZq0a
	HJ3m8IXnVFdjYHCDFizOZ8W9GPw+MNnKrWd4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RHcoQzRZ0Xn4xfwo3go7i50RVL/aj5Rt
	HztETymXTPOql1VhmkQKWDHpTjKfRLczpsf/P3o+3bSV9nP4zrT0T8AB/O40HryE
	YfE1pKkWmJonrDIxSedintrVDx8D/A6U54YfIbKAawc25qKRCjiEkFLrQXNCZX7y
	1y9hpNl8/hI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F2345E8;
	Mon, 22 Aug 2011 18:01:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FB4A45E7; Mon, 22 Aug 2011
 18:01:39 -0400 (EDT)
In-Reply-To: <20110822203645.GD11745@sandbox-rc> (Heiko Voigt's message of
 "Mon, 22 Aug 2011 22:36:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FC3B794-CD0A-11E0-8639-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179895>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>
> Hi,
>
> this is an update of the previous doc patch.

Looks very good; thanks.
