From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 12:42:54 +0100
Message-ID: <4D89DCBE.3060400@drmicha.warpmail.net>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>	<4D89D052.5030801@drmicha.warpmail.net>	<AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com> <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:46:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2MWK-0000Zr-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 12:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715Ab1CWLq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 07:46:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51546 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932242Ab1CWLq3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 07:46:29 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 52113205BA;
	Wed, 23 Mar 2011 07:46:28 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 07:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4BcA2PwM2q614PazLUvCfmSTYto=; b=mVgRplS99qEeAuB911NteWx9RnRGqrHZ1G0KmgbKAznrHxDQ4zcNflbxoVM1sGK9F9a6RlWGaz06nGbmx9RaQ8iLYQPZrO2KNz1n1ifVEhP9kBuuopGn/owAX43CugHFIJF1vomWNGq7bFbCIr0SGLDAi3+BIKlM3ebOq1yM4Dk=
X-Sasl-enc: LU8QBqrizyy4kBCf40QKnBTAvzKbR5p6R7gT6yN7WcMc 1300880787
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EEDCF40578F;
	Wed, 23 Mar 2011 07:46:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169820>

demerphq venit, vidit, dixit 23.03.2011 12:28:
> On 23 March 2011 12:27, John Tapsell <johnflux@gmail.com> wrote:
>> On 23 March 2011 10:49, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>>> John Tapsell venit, vidit, dixit 23.03.2011 11:33:
>>>> Hi,
>>>>
>>>>   Could someone add a feature to  ls-files  to list all the files in
>>>> the repository, but relative to the current path?  It would be useful
>>>> for many different aliases, such as "git locate".
>>>
>>> That is in the works, we just have to decide between two suggested
>>> notations:
>>>
>>> git ls-files :
>>> git ls-files :/
>>
>>
>> What's wrong with --relative  or something?

??

ls-files already lists files relative to cwd. What you need is a way to
specify that you want all files, not just those beneath cwd.

>>
>> I've never liked magical strange notations.  ":" already has a meaning.
> 
> +1

I think you've both been missing out on the discussions about
--full-tree and refspec notation for that...

Of course ":" has a meaning. "git show HEAD:" lists all files at the
top-level of the tree at HEAD. That is exactly why ":" has been
suggested to denote the top-level for pathspecs also. Note that this is
much more general than just an option for ls-files.

Michael
