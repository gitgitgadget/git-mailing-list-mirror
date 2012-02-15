From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 15 Feb 2012 10:13:12 -0800
Message-ID: <7vaa4k0xtz.fsf@alter.siamese.dyndns.org>
References: <4F3120D4.1050604@warmcat.com>
 <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org> <4F3247CA.1020904@alum.mit.edu>
 <CAHkRjk451=_XaQuUXmxAvB3sRRz6-J+c7A2ZrfLwfGz=z05Lag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>,
	=?iso-2022-jp?B?QW5keSBHcmVlbiAo?=
	 =?iso-2022-jp?B?GyRCTlMwQlcvGyhCKQ==?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 19:13:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxjM1-0002TU-W4
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 19:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab2BOSNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 13:13:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2BOSNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 13:13:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1AF0623C;
	Wed, 15 Feb 2012 13:13:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VTf/1dDepYTzygte8njeyI7H64E=; b=RuNyIW
	yTWL7fcRfAFWvUNaX931xKfDJBiV8LeqJ2dO49S4amkVdOitPAYAzVYwLAUzoMr5
	WP8gYSiSbSioKXy05aldic9zM7onF1Vfg7jqTL+E874r1Z5vPdV3uVDJ7FmStX54
	S7u6MImYX+51Hz79mTHPpXt4Sha9LUq5AvEeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B/Wn1xng8jaRTYsyR4z6umEE0TgLTlUp
	Cs+auePf5qIYm5fa2OrMiDLL6t680OWSFDjO00XAbMjL0ofuG3Z6ue+Bk2fLED93
	3r7TCqrcdMgMcOfBAsdeiJxOs5OEpp/BkvGYhFcfQ5EF42mUqDM4UdOVayf7m88O
	ZfVw1LYnal0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97DDB623B;
	Wed, 15 Feb 2012 13:13:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 165AF6239; Wed, 15 Feb 2012
 13:13:13 -0500 (EST)
In-Reply-To: <CAHkRjk451=_XaQuUXmxAvB3sRRz6-J+c7A2ZrfLwfGz=z05Lag@mail.gmail.com> (Catalin
 Marinas's message of "Wed, 15 Feb 2012 12:24:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9F755FE-5800-11E1-9F98-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190844>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> ... I'll
> publish it to the 'master' branch shortly and release a 0.16.1
> hopefully this week.

Thanks.
