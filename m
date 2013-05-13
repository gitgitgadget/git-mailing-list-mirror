From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt string
Date: Sun, 12 May 2013 21:57:19 -0700
Message-ID: <7v61ynsci8.fsf@alter.siamese.dyndns.org>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
	<1368289513-8700-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 06:57:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbkpC-000558-FO
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 06:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab3EME5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 00:57:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060Ab3EME5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 00:57:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42CEA198D6;
	Mon, 13 May 2013 04:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=K+8PNpo+UsL6jDm+IUBEszZMZ84=; b=tJ4WCFQyJPafcQ02leol
	205wTuc6XDK0EMDCfF3jLZVylSISsRekMCVOSBc4V26hbHC4aXPwGR+Vi+kqyggx
	UfmbRCPFDkXRrfr2VwJaauCmEJCqbwwKxqNL3jLxjembJW1rsP4RshgDi02EyNNU
	BkBRWfO5FzERzlUKsC5RNVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aJfvV+xjSS93C9qapQJNCLLmmMsLVIwAJ0P22kSzEg7Pfz
	skO40t2uwp+Jammja/7J2Ksocx/NSeHxDXExzeMkLx/vdjlIfTzI2o9uTKhqFc8f
	Ql7Z2EIcY4O/25SwlHetJlyWpnzucFVTI4CKGDWI7IenbI5eMhTZyi2aoUMyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 368BC198D5;
	Mon, 13 May 2013 04:57:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B108E198D3;
	Mon, 13 May 2013 04:57:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97DDC406-BB89-11E2-BC8E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224085>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Nobody has branch names that end with + or *.  Then why put a space
> after the branch name and before [*|+][=|<|>] in the prompt string?

I do not think the space is for disambiguation.

It is like asking why typeset a space after a sentence a tad wider
than a space after each word: grouping related things together, and
separating groups of different kind apart, to make it more readable.
