From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Is there some env variable like GIT_LANG (like LANG)?
Date: Tue, 22 Mar 2011 20:30:55 +0100
Message-ID: <4D88F8EF.8020609@dirk.my1.cc>
References: <4D879E11.6040609@dirk.my1.cc>	<7vipvcp8e3.fsf@alter.siamese.dyndns.org>	<4D87ABA5.1030609@dirk.my1.cc>	<AANLkTikXsYONY5rUSF5138bQ=R4gCopOO8fu=3np+c98@mail.gmail.com>	<4D87B6D4.3040601@dirk.my1.cc> <AANLkTi=wwFw09QkrttvxvuEoHyuQ+61wa0YMysDQC05D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q27IS-0001BB-HP
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab1CVTbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 15:31:07 -0400
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:47647 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1CVTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:31:00 -0400
Received: from [217.87.114.235] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q27I8-0003Wf-OB; Tue, 22 Mar 2011 20:30:56 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <AANLkTi=wwFw09QkrttvxvuEoHyuQ+61wa0YMysDQC05D@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169769>

Am 21.03.2011 21:48 schrieb Lasse Makholm:
>>>
>>> Alternatively, you might like something like the following in your
>>> .bashrc:
>>>
>>> function git
>>> {
>>>      LANG=C command git "$@"
>>> }
>>>
>
> Just make sure you include the "command" part or the function will
> call itself indefinitely...
>

That would be like my favourite forkbomb: ":(){ :|:& };:"
WARNING: Don't type that in the shell! The system hangs
immediately, even if it looks like only smileys.

Thanks a lot. It does exactly what I want. And it's a good
trick for other applications as well.
