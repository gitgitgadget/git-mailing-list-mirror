From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Thu, 10 Nov 2011 08:09:59 +0100
Message-ID: <4EBB78C7.101@viscovery.net>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com> <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com> <7vehxgu0fy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: nathan.f77@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 10 08:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOm7-0002wn-2C
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab1KJHKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:10:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40571 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754688Ab1KJHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:10:06 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ROOls-0002sz-Fr; Thu, 10 Nov 2011 08:10:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3962D1660F;
	Thu, 10 Nov 2011 08:10:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <7vehxgu0fy.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185189>

Am 11/10/2011 4:21, schrieb Junio C Hamano:
> Nathan Broadbent <nathan.f77@gmail.com> writes:
> 
>> Dear git mailing list,
>>
>> I'm assigning the `_git_fetch` bash tab completion to the alias `gf`,
>> with the following command:
>>
>>     complete -o default -o nospace -F _git_fetch gf
>>
>> The tab completion then works fine in git 1.7.0.4, but breaks on git
>> 1.7.7.1, with the following error:
> 
> We have been cooking for 1.7.8 and have the first release candidate
> 1.7.8-rc1; could you try it and report what you find out?

It looks like _git_fetch is not meant to be called directly. All git
completions must go through _git.

See also this post:

http://thread.gmane.org/gmane.comp.version-control.msysgit/13310/focus=13335

-- Hannes
