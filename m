From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Doc: mention the crlf attribute in config autocrlf
 section
Date: Mon, 16 Nov 2009 22:37:09 -0800
Message-ID: <7v7htpirmy.fsf@alter.siamese.dyndns.org>
References: <1258223700-4009-1-git-send-email-mmogilvi_git@miniinfo.net>
 <20091116195048.6117@nanako3.lavabit.com> <20091117035945.GA1728@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHgw-0002fV-Or
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbZKQGhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbZKQGhP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:37:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZKQGhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:37:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB8B89F4D8;
	Tue, 17 Nov 2009 01:37:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Kz/SffJkGQttm2lwT9WQngpfAc=; b=GdaIsC
	3tSxBThNuUUxGSgVp305SgH6IzVP4DzzGB/Brz+DKCDAZBtLP1UAGVeV5PArKMwF
	Ex99VvgytcDDT1DWr8GPbqImwYahECVUHBSuXv6BVhH9qXyb225ISIh5X11WnO52
	6CUCmG1OifEhmcio7F+e2CodDiGelOgRiUv7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2WiTdAS7X/+eQSzDFAmj6y/VTNUWLhr
	nOutZ96NfZNYBIVILszQKa4/08Bxc+7kCon1oIWA0iG3D0eFp4RZIubvA+/ylA4O
	xxTYkKIbIB4IPD3hlIUNmZcWd6Xq6aHssmLaiF66jPfWsOAzxjtgWheaOFQBjsUs
	/iJBRj+9Rpg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 791459F4D7;
	Tue, 17 Nov 2009 01:37:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D774E9F4D4; Tue, 17 Nov 2009
 01:37:10 -0500 (EST)
In-Reply-To: <20091117035945.GA1728@comcast.net> (Matthew Ogilvie's message
 of "Mon\, 16 Nov 2009 20\:59\:45 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5BC3A4E-D343-11DE-AFFA-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133066>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> On Mon, Nov 16, 2009 at 07:50:48PM +0900, Nanako Shiraishi wrote:
>> Quoting Matthew Ogilvie <mmogilvi_git@miniinfo.net>
>> 
>> > The reverse reference has long existed, and the autocrlf description
>> > was actually obsolete and wrong (saying only file content is used),
>> > not just incomplete.
>> 
>> What do you mean by "reverse reference"?
>
> I'm refering to the fact that the "crlf" section of
> Documentation/gitattributes.txt mentions core.autocrlf,
> which is in the opposite (reverse) direction as this new reference
> I'm adding.
> ...
> Do I need to resubmit the patch, in order to rephrase the commit
> message?

Thanks; I heard you, as your response was Cc'ed to me as well ;-)

How about this?  I didn't touch the patch text (other than dropping
trailing whitespaces).

commit ff68668695486b72b5f06146eddf85b70841088a
Author: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Date:   Sat Nov 14 11:35:00 2009 -0700

    core.autocrlf documentation: mention the crlf attribute
    
    The description of the configuration variable is obsolete and
    wrong (saying only file content is used), not just incomplete.
    It has used the attribute mechanism for a long time.
    
    The documentation of gitattributes mentions the core.autocrlf
    configuration variable in its description of crlf attribute.
    Refer to the gitattributes documentation from here as well.
    
    Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
