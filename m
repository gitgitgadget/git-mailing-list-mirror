From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 22:55:28 +0200
Message-ID: <51DC78C0.9030202@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwewg-0003jo-RO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab3GIUzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:55:31 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:3143 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751945Ab3GIUza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:55:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6190313004A;
	Tue,  9 Jul 2013 22:55:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DA22319F611;
	Tue,  9 Jul 2013 22:55:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vhag3v59o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230008>

Am 09.07.2013 22:37, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 09.07.2013 21:53, schrieb Junio C Hamano:
>>> +--lockref::
>>> +--lockref=<refname>::
>>> +--lockref=<refname>:<expect>::
>>> ...
>>> +This is meant to make `--force` safer to use.
>>
>> This is a contradiction. "--force" means "I mean it, dude", and not "I
>> mean it sometimes". It would make sense if this sentence were "This is
>> meant to make `+refspec` safer to use."
> 
> No, this *IS* making --force safer by letting you to say in addition
> to --force alone which is blind, add --lockref to defeat it.
> 
> I do not see any good reason to change the samentics of "+refspec"
> for something like this.  "+refspec" and "--force refspec" have
> meant the same thing forever.

So what? They still mean the same thing as long as --lockref is not used.

>  If --lockref adds safety to +refspec,
> the same safety should apply to "--force refspec".

No. --force means "I know what I am doing, no safety needed, thank you".

By applying the safety to --force as well, you lose it as the obvious
tool that overrides the safety.

-- Hannes
