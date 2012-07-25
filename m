From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Wed, 25 Jul 2012 15:08:23 -0700
Message-ID: <7v1ujzbijs.fsf@alter.siamese.dyndns.org>
References: <500AEB11.4050006@ramsay1.demon.co.uk>
 <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk>
 <7veho1exu6.fsf@alter.siamese.dyndns.org>
 <501043D9.70604@ramsay1.demon.co.uk> <20120725205120.GD4732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9ku-00065z-24
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2GYWI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:08:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab2GYWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:08:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3FAF7F14;
	Wed, 25 Jul 2012 18:08:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vldx3gPZtSCPC586RZgy9un3y0s=; b=EDfXp4
	qEov7Gq6oJfnZOtlloAQq1JFR6TZw55XjUzMYnXWS/RnZQKyhnTAwBt/JMKZsQD+
	bpK57ej+3Y+Mt+ZVmwS1fkGwO9a45l5w0yJB8h4J2JYdEgtQSQ3JHTlRFiaWpCXl
	yE1q5aVcku+Nu7Uit5bdl37X7+7iy9XNaH5HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vuWOjJoHUhPNQjYmP3K2pSJlraY6A+tb
	pshz3qDCMZ7Joyo2Uo90CDcVy1n3wnHOPme1G6TdDdOlbCC017ULneIGD3/mcokt
	3P9IUWoojaHe6murOOUCdmEtLRpRPw6uXSj0A+Li1jkBGeNA8y5r7pz1b4+aovHA
	jDTz7mZs0Hw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E02547F13;
	Wed, 25 Jul 2012 18:08:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 617747F12; Wed, 25 Jul 2012
 18:08:25 -0400 (EDT)
In-Reply-To: <20120725205120.GD4732@burratino> (Jonathan Nieder's message of
 "Wed, 25 Jul 2012 15:51:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4176C320-D6A5-11E1-BE00-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202208>

Jonathan Nieder <jrnieder@gmail.com> writes:

> FWIW I find Junio's test_setup name more self-explanatory.  What
> mnemonic should I be using to remember the _fixture name?

Previous exposure to things like Rails?
