From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: git-prompt.sh vs leading white space in __git_ps1()::printf_format
Date: Wed, 12 Dec 2012 21:25:59 +0100
Message-ID: <50C8E857.5080000@xs4all.nl>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com> <20121128132033.GA10082@xs4all.nl> <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com> <50B66F41.1030305@xs4all.nl> <7vlidltpyj.fsf@alter.siamese.dyndns.org> <50C7B811.7030006@xs4all.nl> <7v7goo6vi3.fsf@alter.siamese.dyndns.org> <7vy5h45e7b.fsf@alter.siamese.dyndns.org> <20121212085507.GA32187@xs4all.nl> <7vlid35fe4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 21:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TistI-0005Af-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 21:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab2LLU0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 15:26:35 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:3139 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab2LLU0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 15:26:34 -0500
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id qBCKQ0ml008771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2012 21:26:01 +0100 (CET)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vlid35fe4.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211392>

On 12/12/12 18:50, Junio C Hamano wrote:
> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
> 
>> This removes most of the ambiguities :-)
>> Ack from me!
> 
> OK, as this is a low-impact finishing touch for a new feature, I'll
> fast-track this to 'master' before the final release.
> 

Ok, wonderful!
BTW, I tried the thing I mentioned and it was safe to do:
PS1='blabla$(__git_ps1 x y)blabla'
will not eat your prompt, although I'd recommend putting something
useful instead of blabla ;-)

Cheers

Simon
