From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Clean way to disable pager
Date: Mon, 20 Aug 2007 10:15:15 +0200
Message-ID: <vpqzm0mvcz0.fsf@bauges.imag.fr>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
	<7vodh3bbmx.fsf@gitster.siamese.dyndns.org>
	<vpq643bz4vx.fsf@bauges.imag.fr>
	<325563A3-050A-4830-9ACB-9ED15322F038@apple.com>
	<85ps1jp2w9.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 10:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2QV-0003BW-2x
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbXHTIPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbXHTIPu
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:15:50 -0400
Received: from imag.imag.fr ([129.88.30.1]:35306 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995AbXHTIPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:15:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7K8FFba012758
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Aug 2007 10:15:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IN2Pr-0005lI-Oy; Mon, 20 Aug 2007 10:15:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IN2Pr-0002iL-La; Mon, 20 Aug 2007 10:15:15 +0200
Mail-Followup-To: David Kastrup <dak@gnu.org>, Adam Roben <aroben@apple.com>,  Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <85ps1jp2w9.fsf@lola.goethe.zz> (David Kastrup's message of "Mon\, 20 Aug 2007 00\:37\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Aug 2007 10:15:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56189>

David Kastrup <dak@gnu.org> writes:

> Adam Roben <aroben@apple.com> writes:
>
>> On Aug 19, 2007, at 12:44 PM, Matthieu Moy wrote:
>>
>>> +    [-p|--paginate] [--no-pager]
>>
>>   I think that [-p|--[no-]paginate] would be more consistent with the
>> way negatable options are normally specified.
>
> Disregard previously existing code, I'd vote for using an option set
> like the following:
>
> --pager
> --pager=less
> --pager=cat
> --no-pager
>
> "--paginate" is rather artificial in contrast.

ACK. I thought of naming the option --no-paginate, but I don't think
that good english. --dont-paginate would be good english, but doesn't
match the --[no-]whatever scheme.

Perhaps using David's proposal, and keeping the --paginate as a
backward compatibility, deprecated switch is the way to go.

-- 
Matthieu
