From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 19:34:17 -0800
Message-ID: <7vsj5jmjie.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130129194846.GD1342@serenity.lan>
 <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
 <7va9rroazl.fsf@alter.siamese.dyndns.org>
 <20130129230607.GG1342@serenity.lan>
 <7vwquvmkon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 30 04:34:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ORe-0001N8-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 04:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab3A3DeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 22:34:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab3A3DeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 22:34:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4DFC579;
	Tue, 29 Jan 2013 22:34:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+y7QosTG9vqqrd+wQRQ5EYLfoY=; b=pgJSI2
	T/Zfp4hclklomN9H4OAg8ZZG8r1Iqm7ybkjvXmwJhjfx6rxID/fOIQIdpn5vD7hS
	k+Z3Dg7PURReflP7gzvFnZn+K8KRiEmNxeI7/CrUmI0yxjfRNy9f1hFuadDL6ZTo
	XtsyZb8tDjADfwEQzqhsZlhE4oZnrErXlnsGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OnYZbxmCCPyeWXjRtvvqmDQAugWfhgsV
	BUS4nOruJzmpkSSJoCe0Nm8TsEEMlg166mKnNJGZUUJuKI0vQ1a/OlzKMh52DZN3
	CbMXK5KlZqika3rylnyEcamWq//4toa/XLfZPEUGkXhOPmw+UraceNEzEVuCJ0uu
	FQ1pq1kUD3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41FE1C577;
	Tue, 29 Jan 2013 22:34:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3001C574; Tue, 29 Jan 2013
 22:34:18 -0500 (EST)
In-Reply-To: <7vwquvmkon.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Jan 2013 19:08:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDDBAC4E-6A8D-11E2-B631-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214991>

Junio C Hamano <gitster@pobox.com> writes:

> Heh, I actually was hoping that you will send in a replacement for
> David's patch ;-)
>
> Here is what I will squash into the one we have been discussing.  In
> a few hours, I expect I'll be able to push this out in the 'pu'
> branch.

I ended up doing this a bit differently; will push out the result
after merging the other topics to 'pu'.
