From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: use path accessor for Git::SVN objects
Date: Tue, 18 Sep 2012 11:10:05 -0700
Message-ID: <7v1uhznqwy.fsf@alter.siamese.dyndns.org>
References: <20120918000931.GB17939@dcvr.yhbt.net>
 <20120918142941.GA2925@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 20:10:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE2FY-0000vQ-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 20:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab2IRSKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 14:10:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab2IRSKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 14:10:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA8BA83A2;
	Tue, 18 Sep 2012 14:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUm2L01r78+0n0o26KI/eu0y+zo=; b=l6IowZ
	E6j/g9VdDmtO8kYcsvBetTlDIQ8wann9UNiRgPSZu04flQptwfHnvPdgi9XRU833
	Y2sgXhXTL5vENXIYwEpcSudiPT6mdJDPPAnVr92Hx/FNizGkLa2r7VlW0sewf/6f
	X0f7+zpqmmyWFBYMKNTwTAdlbyWXeAMsJFCH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tn6Z4400r/zii8PRMbt761erRetFPIty
	L/l/plzL8ABo9dKHR0OtQoCaWa/q4BkVu2kFYVAyDVz2VQB2VpE5RzTgBaBqELtH
	Dhpw110ZztCisufyWC6aXT49YRqAhmvguyYDibpP9JC5lsw0DK0fWHU9C0Zc9O1f
	DPQDEtz/Alk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9562883A1;
	Tue, 18 Sep 2012 14:10:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E8D083A0; Tue, 18 Sep 2012
 14:10:06 -0400 (EDT)
In-Reply-To: <20120918142941.GA2925@elie.Belkin> (Jonathan Nieder's message
 of "Tue, 18 Sep 2012 07:29:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13B8EDC2-01BC-11E2-BA83-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205844>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Eric Wong wrote:
>
>> The accessors should improve maintainability and enforce
>> consistent access to Git::SVN objects.
>>
>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>> ---
>>   (RFC since I could've missed something)
> [...]
>>  git-svn.perl       | 2 +-
>>  perl/Git/SVN/Ra.pm | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> I think that's all of them, so for what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for helping to move things forward.
