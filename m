From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Thu, 23 Jan 2014 10:15:33 -0800
Message-ID: <xmqqha8uva2i.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
	<xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
	<CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
	<52DFE882.2040605@atlas-elektronik.com>
	<xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
	<CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
	<xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
	<20140122203030.GB14211@milliways>
	<20140123020913.GF17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ken Moffat <zarniwhoop@ntlworld.com>,
	Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 23 19:16:16 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W6Op5-0004Fb-GK
	for glk-linux-kernel-3@plane.gmane.org; Thu, 23 Jan 2014 19:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbaAWSPk (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 23 Jan 2014 13:15:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbaAWSPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jan 2014 13:15:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 547436554F;
	Thu, 23 Jan 2014 13:15:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rtFwbXwlYvZXGVqSXnPSGU6bBpc=; b=VUbA84
	q65ygjAYnMduKeZDP09Mcvl7Sv1m283WBRH1InWJtjdIrbO3OTIQhJaFHgcS1nxS
	MONeXW2/7DCoylStxRiote7EauJNiZS0sBXfkVAy7jWXLQfhTH3V35vvFPEqRdsq
	phEXZsbdcDcBjDob5h+8BwQTh3U646mtiOP54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PSi5Qh9kk0L0P2Q5w/xx3ImNZLRqCGFL
	7RD0aYmbSkNSeuLMpgaKUEIrs7nlqg5ncwf0gp1y72QCeMcDdMKCkWdo8P/CvDOO
	E3g/gkg2VROrQSt+yTtdWuJhSGMRhD7i0R5mVLthQZTFrmkuoWgOh56T49XNKrlL
	eIbNHBu/U/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34E086554E;
	Thu, 23 Jan 2014 13:15:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D55C36554B;
	Thu, 23 Jan 2014 13:15:35 -0500 (EST)
In-Reply-To: <20140123020913.GF17254@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 22 Jan 2014 21:09:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B085A88-845A-11E3-9D2F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240923>

Jeff King <peff@peff.net> writes:

> Junio, since you prepare such tarballs[1] anyway for kernel.org, it
> might be worth uploading them to the "Releases" page of git/git.  I
> imagine there is a programmatic way to do so via GitHub's API, but I
> don't know offhand. I can look into it if you are interested.

I already have a script that takes the three tarballs and uploads
them to two places, so adding GitHub as the third destination should
be a natural and welcome way to automate it.
