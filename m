From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-config: add --path option doing ~ and ~user
 expansion.
Date: Thu, 31 Dec 2009 21:15:23 -0800
Message-ID: <7vocleo178.fsf@alter.siamese.dyndns.org>
References: <1262191913-8340-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZrL-0000xV-2C
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab0AAFPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 00:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086Ab0AAFPb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 00:15:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0AAFPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 00:15:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15845ABFEE;
	Fri,  1 Jan 2010 00:15:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LTtkKqu5BxsLbWWTQV85X8CrqR0=; b=U/g1RNK6ahZszpT1OWI+DqS
	7ziM+JfJFIIk0DtALB8HCtKOtnQqqnLqidYm0nYk05iJzDOjY0j75uHIyNS8K0ay
	VZvy+wN0vMxb0K8InrLvOYqoeZ+SPxQ8YVYerGRt6gxMFaRK4Lqf1OMmdnxPvAD8
	cW8MTKC1LXgnxWR1yhtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cvqKdQmToDuBQXYZaLRt5VbHXHvDdtUrKZLjEWDo+ccdGj1kW
	cIeIxMJQ6sOkBXkPiI5XBnNUpT9nDHr5lRLgY96ti2IHU6DfbecOf6JbVBV+rYKe
	r3LZIBBI2IepT4blZLfCMV9+O3nq83SO3qWUd9z9luxrY82GBENWQC8OYg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E94E2ABFED;
	Fri,  1 Jan 2010 00:15:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0FB0CABFEC; Fri,  1 Jan 2010
 00:15:24 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC9B371A-F694-11DE-8BCC-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135999>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> 395de250 (Expand ~ and ~user in core.excludesfile, commit.template)
> introduced a C function git_config_pathname, doing ~/ and ~user/
> expansion. This patch makes the feature available to scripts with 'git
> config --get --path'.

Makes sense.  Thanks.
