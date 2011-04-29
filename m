From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: fix missing space in error message
Date: Fri, 29 Apr 2011 11:37:47 -0700
Message-ID: <7viptwx5s4.fsf@alter.siamese.dyndns.org>
References: <1304101404-4571-1-git-send-email-sylvain@abstraction.fr>
 <7vmxj8x5yj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:38:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFsZn-0004NP-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161Ab1D2Sh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 14:37:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab1D2Sh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 14:37:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5D3C5F51;
	Fri, 29 Apr 2011 14:39:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SOh8wVAUFr+vXz1e/9/mv5j3lII=; b=qRWBvz
	6msL1tQoKqZ0ItxcRdOwLYDW9ZGRzs09LjjSuonPwFti31s6bDv0Q58UZ1jRQcoz
	TtAI6/tIndnWU8d3O/Q6cmlLKeV8CM4AjRUKy1MNP63qpb8GgOSLljBcJp6mPxPv
	gebjtc74w3x+FQ1hDvhc+I4RJrGmY4vbanaK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1GeE/p0bxIGpghSWYTd6v8ZwQsD9XhE
	VuAlr49qhAwShx47HWJJJgKxtzMAAoaAo+e5wWtT8nC3SyeEivbxM0H34HhanFZt
	eLy0BcTW9bYUAFMGohaiOpcvNfIMk0IzOaSSlm1cy8iTQqV1Y0nXNwH16BduAwtT
	gk6Prd7f8q0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B48575F4A;
	Fri, 29 Apr 2011 14:39:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BDB0D5F49; Fri, 29 Apr 2011
 14:39:52 -0400 (EDT)
In-Reply-To: <7vmxj8x5yj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Apr 2011 11:33:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13F13D2E-7290-11E0-8B35-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172489>

Junio C Hamano <gitster@pobox.com> writes:

> Sylvain Rabot <sylvain@abstraction.fr> writes:
>
>> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
>
> Please keep in mind that these individual commits will eventually need an
> entry added to Documentation/Relnotes/1.7.5.1.txt where I describe what
> bug was fixed in a single paragraph, and it almost always talks about how
> a bug would have been triggered so that the readers can tell if the fix
> would benefit them.
>
> It would have been perfect if you wrote under what condition the user
> would see this error message in the body of the commit.

Will queue this; thanks.

Author: Sylvain Rabot <sylvain@abstraction.fr>
Date:   Fri Apr 29 20:23:24 2011 +0200

    git-send-email: fix missing space in error message
    
    When the command cannot make a connection to the SMTP server the error
    message to diagnose the broken configuration is issued.  However, when an
    optional smtp-server-port is given and needs to be reported, the message
    lacked a space between "hello=<smtp-domain>" and "port=<smtp-server-port>".
    
    Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
