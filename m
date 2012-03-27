From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 16:05:54 -0700
Message-ID: <7v1uodzlt9.fsf@alter.siamese.dyndns.org>
References: <4F71E415.9030800@gmx.ch> <4F71F902.8090200@in.waw.pl>
 <4F7223D0.5000801@gmx.ch> <7vr4wdhilj.fsf@alter.siamese.dyndns.org>
 <4F722D18.50502@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, peff@peff.net
To: Mathias Weber <mweb@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCfSk-0001BH-KR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab2C0XF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:05:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136Ab2C0XF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:05:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 765D479B4;
	Tue, 27 Mar 2012 19:05:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=InrNMOXMdBzwuMYiwPZDuDvKPk0=; b=EjfBpI
	eMo8q5EsZBCijEcm290SPi09+xzHqYJv1EC76EeYD0EwbSKGtOHqqDfeDxsLsRaV
	hgFHNPT+z+PHnzPUjuTnn/iTxO7O7p0lw9Mx53g6BdFFeAdNh3Wl53JBhOQAZNg5
	BkI4wtQCEatvkKna9A31yHaB45p+c3V++a8BE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdBSycK2x/T63eJj+0SJue1VlLF7//sl
	INR/p/3e58bdcDaS+6kwdql4k3WKEkkToPYb3L5u1hLgvQC4MmgdCOmkdKIEuG0g
	gArbylZ5sT2FBfU9AeydGjO1CW4e7seMygA6A4Eq4du13bOxtGmEsSfsz8NwZkzp
	FGdGvRO/kR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D50E79B3;
	Tue, 27 Mar 2012 19:05:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04A5479B2; Tue, 27 Mar 2012
 19:05:55 -0400 (EDT)
In-Reply-To: <4F722D18.50502@gmx.ch> (Mathias Weber's message of "Tue, 27 Mar
 2012 23:11:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68A02AF6-7861-11E1-97E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194093>

Mathias Weber <mweb@gmx.ch> writes:

> ... To change the committer you have to
> provide the env variable GIT_COMMITTER_NAME and GIT_COMMITER_EMAIL or
> change the config file. I haven't found a option to change the
> committer. I think the tagger is about the same as the committer.

OK, so not giving an easy option to forge it, while leaving the door open
for scripts to use GIT_COMMITTER_{NAME,EMAIL} to override it if needed, is
a good way to keep people honest and make the behaviour consistent across
tools.  I can understand the reasoning.

Thanks.
