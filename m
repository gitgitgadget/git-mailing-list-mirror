From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] gitk: improve dark background
Date: Fri, 26 Nov 2010 17:34:35 -0800
Message-ID: <7vd3prpn10.fsf@alter.siamese.dyndns.org>
References: <1289451597-6950-1-git-send-email-david@fries.net>
 <20101126224136.GA26477@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: David Fries <david@fries.net>
X-From: git-owner@vger.kernel.org Sat Nov 27 02:34:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM9go-000888-Kz
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 02:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab0K0Ber (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 20:34:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0K0Beq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 20:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9F7D2E30;
	Fri, 26 Nov 2010 20:35:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s9zA5Nmnv7zwVleE92I6kdmtsU4=; b=c0vozH
	89r/oPSK6Oa9ztyJn+3lUCVZM+fjyLhJHmFCHZsYOHGs3DcSxMWxFEhfrpMSHvOA
	fhASsUeqHlhu6uF5RHscRGZzpRi0xiV/FxgOfV4IG3YhTg3U2pu75/BXNL3TwY84
	BfxkeZAUYgX5qjCjMXhr+it/SKyW2u7pNrxwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z08tq+00kj2ru4ImK399RBL85Z3cz1aY
	Kl7ZxYRz9xLLdwx/5U8x8kYscX/pbJoImHhQNA2MTjvN2DR6xQYtwFAQCh6Bk24g
	b+q3I/pS6C4wm1OK5SM4Mvf7xy+ZQ55dEPUUHPQbUe16wk2EIYvA7rugJ1GzjDea
	2VJ4DRr2t2s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A9072E2E;
	Fri, 26 Nov 2010 20:34:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56A862E2D; Fri, 26 Nov 2010
 20:34:54 -0500 (EST)
In-Reply-To: <20101126224136.GA26477@spacedout.fries.net> (David Fries's
 message of "Fri\, 26 Nov 2010 16\:41\:36 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B9727FA-F9C6-11DF-B7A5-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162291>

David Fries <david@fries.net> writes:

> I submitted the 'gitk: improve dark background' patch to the list,
> made improvements based on the feedback, and submitted the result two
> weeks ago without any further feedback.  I put my changes off of
> master, but gitk is identical in both maint and master.  Can you pull
> the changes?

I saw the patch, but I didn't really look at it (I don't use gitk very
often, and I am an old-fashioned "darker ink on lighter sheet" user so I
wouldn't be a good judge on your change).

I don't take patches to gitk or git-gui directly to my tree.  Please Cc:
the maintainer of that part of the system (Paulus, whom I am Cc'ing this
message) the next time.

Thanks.

> branch gitk_colors from
> git://gitorious.org/~dfries/git/dfriess-git-mainline.git
>
> This e-mail is also a replay to the last posting of the patches.
>
> On Wed, Nov 10, 2010 at 10:59:54PM -0600, David Fries wrote:
>> The gitk preferences allow for the user to select different colors.
>> The setui is even set to dynamically detect how light or dark the
>> background is and set the selection color to be the opposite, but
>> there are a few other color selections that don't currently work with
>> a dark background such as the black outlines.  This patch improves the
>> color selection.  In some cases it just needs to use the current
>> forground color, other places it is more complicated.
>> ...
