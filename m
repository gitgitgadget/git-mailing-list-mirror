From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Fri, 30 Mar 2012 22:38:10 -0700
Message-ID: <7vd37tjpod.fsf@alter.siamese.dyndns.org>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120331034802.GB2475@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, peff@peff.net,
	j.sixt@viscovery.net, gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 07:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDr1W-00056n-4v
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 07:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548Ab2CaFiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 01:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab2CaFiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 01:38:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A27EC4BB1;
	Sat, 31 Mar 2012 01:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XICG3NE6AWU7a3s74/JhXEKB58k=; b=NnfTp0
	D5LSKd5Zfa0vOCXzdrnUs83pVpUnqqUmSdmEyAXxTfz1JXXwwTARvD0SFcd+5y/N
	AWm8lMdY0bSGBbQeSSk6Z6ltLsKn4281Gww6c47qNcvnCk9FQTDloDyib2gp2RYJ
	qcgnOWzG/U+GXIvCEWaNRMHWM25lRTgweqoSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuRWMy7z3HuGJJQLhBzMmd543xsk5UM8
	JdU5mlGEhaar+bR9Ok0oqNLklDiYCuC0pZAJ64HvbcPJZbiVlGtojkrCZk5k1zcT
	JdfGR4+rDM5Scv6u9m6ypZq4BekxEAhktRyVCrW3FAoX3h65t5CC4OH+nNAFWN9g
	vgx9J+hGZlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97E5F4BB0;
	Sat, 31 Mar 2012 01:38:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2336B4BAF; Sat, 31 Mar 2012
 01:38:12 -0400 (EDT)
In-Reply-To: <20120331034802.GB2475@burratino> (Jonathan Nieder's message of
 "Fri, 30 Mar 2012 22:48:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4808DDC-7AF3-11E1-AFB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194433>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ben Walton wrote:
>
> The underlying problem is an old one.  Thanks for fixing it.
>
> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, all of you who participated in the review process.
