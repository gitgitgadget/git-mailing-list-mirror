From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 13:04:02 -0800
Message-ID: <xmqq61pbybi5.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
	<xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
	<CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
	<52DFE882.2040605@atlas-elektronik.com>
	<xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
	<CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
	<xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
	<20140122203030.GB14211@milliways>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>,
	Stefan =?utf-8?Q?N?= =?utf-8?Q?=C3=A4we?= 
	<stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Ken Moffat <zarniwhoop@ntlworld.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 22 22:04:26 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W64yI-0007Zg-86
	for glk-linux-kernel-3@plane.gmane.org; Wed, 22 Jan 2014 22:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaAVVEU (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 22 Jan 2014 16:04:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbaAVVES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jan 2014 16:04:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B59E65F2F;
	Wed, 22 Jan 2014 16:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=weO0S1yroZ999vjqJWr6q20BWLA=; b=axWti/
	Cai3/GXhjf7GJZ4v9ea3j1+dUUQlXtdXM9Li4CNwAc2Ctyj0aD28DBaNE51C92fC
	PcTCxMajHW4606w5i1KKbISGSjyPz5969EVvcSa5GZaZrmEqmMvc5fZudWxIxAth
	dQdYx1nIcR4PR5BDikePpXjP9088qani0a8BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nApRWNVGaGsVHgssGfoZ4KQzaKkAdZzM
	mvfuFi7ufWYTewxgSj/coYb3pNg/j/8XGJ9SUz4/21dJGr5tiqioCbOhTB6nCjB8
	k3I9KCoaQQ//G85M4Z52qgDWSIy54XDLPbUXEwAAjLkdreM2Jr7lyj1RtFHn4cPW
	XkLosEeO0h4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F7E665F2D;
	Wed, 22 Jan 2014 16:04:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE7FA65F2B;
	Wed, 22 Jan 2014 16:04:15 -0500 (EST)
In-Reply-To: <20140122203030.GB14211@milliways> (Ken Moffat's message of "Wed,
	22 Jan 2014 20:30:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C08A0C60-83A8-11E3-BDB2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240857>

Ken Moffat <zarniwhoop@ntlworld.com> writes:

>  I note that all of these *are* still available at googlecode for
> the moment : https://code.google.com/p/git-core/downloads/list

As I said, Cgc is not the ony download site.  The end of

    http://git-blame.blogspot.com/p/git-public-repositories.html

lists the two sites that currently have the material.  I may replace
Cgc with something else (and add it/them to the list), but in the
meantime I do not think k.org will go out of business in anytime
soon, so...
