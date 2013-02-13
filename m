From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Wed, 13 Feb 2013 11:56:35 -0800
Message-ID: <7vip5w6l8s.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
 <511BEA75.6000002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:57:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5iRy-0004FQ-DM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 20:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631Ab3BMT4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 14:56:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932354Ab3BMT4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 14:56:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8197BBAF8;
	Wed, 13 Feb 2013 14:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7GE0kOZyWEjLpV0OHftOQy9az3c=; b=xQ1Rlr
	lQIY7zS4gm3IkiXk+oG+EmsO66/VK7QyEFseG/Dv7X+mDPnQobEthi1+iIKbIfG1
	N6IyOzdyMx0dD6R+g1wHrQByhhTG1eo6Y7BS+pNA9sLA86aqPLX3kHVjQxHnY+3d
	6xSJPXPtYaGZrB7S8wumd8+B9CNhjdeMJ+gHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=didASQ8CWa+j454gW5gU0DpqruqSXwPv
	SKYvE40KccQclNJD7HXDD/Z+kw6fJ54f4ukLriUOA+57UgniwO+J0Z2cJDdY5pqJ
	QqC739xL2YNMIauBWwqah/3ADe6NccC6jzoGXK+ePVF4j9ciu3mSKNKNoy+RxRMT
	2PTgpLzSeJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75838BAF6;
	Wed, 13 Feb 2013 14:56:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E441EBAF4; Wed, 13 Feb 2013
 14:56:36 -0500 (EST)
In-Reply-To: <511BEA75.6000002@web.de> (Jens Lehmann's message of "Wed, 13
 Feb 2013 20:33:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79863194-7617-11E2-9F5A-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216280>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Junio, this looks like a we have v5 as soon as we decide what to do
> with the "not initialized" messages when '.' is used, right?

OK.  I myself do not deeply care if we end up special casing "." or
not; I'll leave it up to you and other submodule folks.

Thanks.
