From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] refs: split log_ref_write logic into log_ref_setup
Date: Wed, 02 Jun 2010 11:14:30 -0700
Message-ID: <7vzkzdcneh.fsf@alter.siamese.dyndns.org>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
 <1274488119-6989-3-git-send-email-erick.mattos@gmail.com>
 <7v632bs13c.fsf@alter.siamese.dyndns.org>
 <AANLkTikPypcmGB6NuTl-SQZR3lnIvdmVG5E8wjVAlIej@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 20:14:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJsSi-0006tt-Ho
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 20:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641Ab0FBSOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 14:14:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599Ab0FBSOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 14:14:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C9F9B846E;
	Wed,  2 Jun 2010 14:14:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bDVtT/QY6L5nJXCL8sV+UKi8n6Q=; b=vMQDVa
	KLl/66XRMdHME52nhS/g/7LiM9masG+vAEErPvmHUMptA4W8fLh2M5SqM9vPrNuM
	pDIiVJuDFJFd+G5H41wpreMmQlMAU+NxN9kT9pZ7J3Rsfnce9oHYqsb5KzvOt+rh
	MlLgiGlTvocMen1TdBdVdZX7lC0BXbj5fSB7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjztTniRG6waQKZy98Njthdh/0/NxkYd
	/nCiSt199V3DpUmB0zOnuTkRnHTuCpbZ4OV8V78v3LCH4g7BtYW1NyfzWW2hqMug
	DuZtkuzQ3RERHWPXbp6SF2KaQpDqqk7hgZLtNJQIOuExETqUUTFQWPCL5mvfaEwp
	Ic/ojO9eU1E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49FAFB846D;
	Wed,  2 Jun 2010 14:14:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F06BB846C; Wed,  2 Jun
 2010 14:14:32 -0400 (EDT)
In-Reply-To: <AANLkTikPypcmGB6NuTl-SQZR3lnIvdmVG5E8wjVAlIej@mail.gmail.com>
 (Erick Mattos's message of "Wed\, 26 May 2010 15\:11\:05 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2FE4506-6E72-11DF-94B3-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148268>

Erick Mattos <erick.mattos@gmail.com> writes:

> Now just a question, Junio:
>
> I forgot to sign-off those patches, should I have to send them again?

I would have appreciated a whole re-send while I was too distracted by
non-git stuff during the past few weeks, but now I am more or less settled
in, it's Ok to just send a separate "Signed-off-by:" like this one:

    http://article.gmane.org/gmane.comp.version-control.git/148230/raw
