From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 15:26:56 -0700
Message-ID: <7v8wesh61b.fsf@alter.siamese.dyndns.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
 <7vljisk1m7.fsf@alter.siamese.dyndns.org>
 <55bacdd30910301505xe712b74m837dc862a6ee953@mail.gmail.com>
 <55bacdd30910301513u6ba6a575w2c65358ff368aeab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zw5-0006xV-HQ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbZJ3W06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbZJ3W06
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:26:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbZJ3W05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 18:26:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B176D583;
	Fri, 30 Oct 2009 18:27:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mXuzQlQOK19f
	2V4wZNP92hQtFZk=; b=lOegDHK0N1exPotZyCatdPsuuIGMciEXgagbBdgknzDt
	RqaNSLIGY87Y6hAEyzR7fjMoGbtWBFCuynEtPWSAzBP7HbWpMAYDiTQydNSxm1/R
	W4eXUeIfJ78sDXYwlniCTy5y/amPfeyJvlo7S85yGeEQYNmh/vUi4bDbfR8RmVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ova8TG
	DFve96ChO9a/rDoNJ1fT6+IOfxpkcSTNwqSXGtq/eeAOG2sJp+hnxt0bsaixleed
	cNloFI1SDBl8qwgQRhVWfFprgKkSaYzWFpNyw7yvKhkWeXwTmdPUeWwkKs4gbqcm
	Fa3FCeKZh1aFeTOikD7y/uoj0qv8EZeBcLwF4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 763F66D580;
	Fri, 30 Oct 2009 18:27:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4E056D57E; Fri, 30 Oct
 2009 18:26:57 -0400 (EDT)
In-Reply-To: <55bacdd30910301513u6ba6a575w2c65358ff368aeab@mail.gmail.com>
 (Erick Mattos's message of "Fri\, 30 Oct 2009 20\:13\:11 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5767DAE0-C5A3-11DE-B568-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131768>

Erick Mattos <erick.mattos@gmail.com> writes:

> 2009/10/30 Junio C Hamano <gitster@pobox.com>:
>
>>(besides, you write logs as if you are making
>> an order to the codebase to "do this!").
>
> Not a chance! =C2=A0Just trying to help.

Sorry, you misunderstood me.  What I meant was:

    It is customery for us to write our log messages as if the author o=
f
    the patch is giving an order, iow, in imperative mood.  Your "Chang=
ed
    blah" violates that style.
