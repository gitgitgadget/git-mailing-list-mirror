From: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 14:02:53 +0200
Message-ID: <44589BED.20503@lumumba.uhasselt.be>
References: <445865A5.5030700@lumumba.uhasselt.be>	 <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>	 <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>	 <445895AC.6070109@lumumba.uhasselt.be> <46a038f90605030442k5c4eee9dj25d4a467942b0f74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 14:03:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbG4H-0005fp-MS
	for gcvg-git@gmane.org; Wed, 03 May 2006 14:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWECMCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 08:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWECMCy
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 08:02:54 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:38528 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S965161AbWECMCy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 08:02:54 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id 736251AB181;
	Wed,  3 May 2006 14:02:53 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id B6A021AB179;
	Wed,  3 May 2006 14:02:52 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605030442k5c4eee9dj25d4a467942b0f74@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19477>

Hi,

Martin Langhoff wrote:

> On 5/3/06, Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:
>
>> Yes, I installed 1.3.0 using "make prefix=/tmp/testje install"
>> but, I'm getting the same problem (other then my failing typing
>> skills ;-) :
>
>
> The problem is that, while you are executing git-cvsserver from
> /tmp/testje, git-cvsserver invokes git-log from the path, and that is
> the "bad" git-log. Change your PATH in .bashrc so that the /tmp/testje
> install takes precedence...

Prefixing /tmp/testje/bin to my PATH in .bashrc wouldnt work, so I just 
replaced
my locally built GIT-.deb package with a locally built v1.3.0 version of 
the package.
All worked fine now! :-)

With friendly regards,
Takis
