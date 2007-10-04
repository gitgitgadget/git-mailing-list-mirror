From: Wincent Colaiuta <win@wincent.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 14:54:31 +0200
Message-ID: <5ACC5CA7-8314-4035-94EC-190138A25EBD@wincent.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 14:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQE4-0001mn-Ck
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 14:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbXJDMyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 08:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXJDMyk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 08:54:40 -0400
Received: from wincent.com ([72.3.236.74]:50789 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603AbXJDMyk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 08:54:40 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l94CsbIh015883;
	Thu, 4 Oct 2007 07:54:38 -0500
In-Reply-To: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59945>

El 4/10/2007, a las 14:27, Paolo Ciarrocchi escribi=F3:

> Hi all,
> I'm having and interesting discussion with an happy mercurial users
> which started reading the git documentation. He raised aquestion that
> I'm not able to answer:
>
>> $ git diff --cached
>>
>> (Without =97cached, git-diff(1) will show you any changes that you'v=
e
>> made but not yet added to the index.) You can also get a brief =20
>> summary
>> of the situation with git-status(1):
>
> Why do we have the option "--cached" and not "--index"?

I am not an "old timer", but I believe that it's because what we now =20
know as "the index" was original called "the cache". See:

<http://git.or.cz/gitwiki/GitHistory>

You're probably right that the option name is confusing, I guess =20
changing it to "--index" would be a good idea, continuing to support =20
"--cached" but marking it as deprecated before finally removing it at =20
some point in the future.

Cheers,
Wincent
