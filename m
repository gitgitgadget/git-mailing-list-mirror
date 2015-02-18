From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Wed, 18 Feb 2015 10:47:16 -0800
Message-ID: <xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
	<20150218170007.784be6aa@pc09.procura.nl>
	<54E4CFDC.40401@drmicha.warpmail.net> <20150218182547.GA6346@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9ee-0004se-BS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbbBRSrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:47:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754121AbbBRSrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:47:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C13236E1F;
	Wed, 18 Feb 2015 13:47:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KxXGjKyZHYpkRQjw6G/7QWa3kBM=; b=fNMnIO
	4Evta2L4/Go1clClIVDMWwFw+QcjVNZfFHcCpSaJNIIX/OkTWmHQ4TSPcdLbXDFK
	grIV6ZpGbj92EVBEFllkVO2uhHGJUScw4qsxdZYM1akuOxY479fxs2frKgAdhOMQ
	hSgG5sTktoRogvZfkbJrc+tkC50jJjw8sh0Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+r5Ior2qU2gIzAm3qT0RbHxsuJPtz8+
	qugroA8TI59rhOJaN0Ugib4fp+GsCdVGYaO8vNIuSp+YfVlMK6HQ0ikbPA8D/l5/
	mJLfptobNfLw8Rbh1hS7FZsTDI9Ap2+2hJpkdEZzfGROF7LgDstWWFlr+1dzf/Or
	uhEOtTUb58c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D6B36E1E;
	Wed, 18 Feb 2015 13:47:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14B0A36E1D;
	Wed, 18 Feb 2015 13:47:17 -0500 (EST)
In-Reply-To: <20150218182547.GA6346@peff.net> (Jeff King's message of "Wed, 18
	Feb 2015 13:25:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FAAAD86-B79E-11E4-973C-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264040>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 18, 2015 at 06:46:04PM +0100, Michael J Gruber wrote:
>
>> Well, how can we help if we don't even know the limitations of that
>> platform?
>
> I'm not sure, but I think the original call for help may have been "I
> will give you shell access to these boxes if you want to play around".

Yeah, that probably was my bad---I didn't make it clear enough that the
request for volunteer from H.Merijn was exactly that.

> It seems like we could use
>
>   (cd src && tar cf - .) | (cd dst && tar xf -)
>
> here as a more portable alternative. I don't think we can rely on rsync
> being everywhere.

Thanks; I wasn't even aware that we used rsync in our tests.  We
certainly do not want to rely on it.

Why not "cp -r src dst", though?
