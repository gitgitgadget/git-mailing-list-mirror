From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: ignoring file modes completely
Date: Sun, 06 Feb 2011 14:14:20 +0100
Message-ID: <4D4E9EAC.4030508@drmicha.warpmail.net>
References: <4D4D6BC2.90101@io.com> <1296921829.5467.1.camel@localhost.localdomain> <4D4D7636.7090608@io.com> <4D4D81C9.5080002@op5.se> <4D4DA4C1.5050501@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	jaredhance@gmail.com
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Sun Feb 06 14:13:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm4Qi-0000yu-0x
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 14:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab1BFNNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 08:13:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50224 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752397Ab1BFNNW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 08:13:22 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D0F52207D7;
	Sun,  6 Feb 2011 08:13:20 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 06 Feb 2011 08:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8dAf8k1GQgw4RnRKiHvCxQnOEeU=; b=NjPouG/rMu3rGBgdOI0COVTEBeBRRdofOWro2u/08GFWDXUE03PFnKYG1R76hMLd6oP+bEf4LiETWluVLczair/tlfY/ZJeBbZ1bsyrhtyYEY0NCl/Gj6w+if7KVmzBwJJ9jV69wgUAYMSnhi8ISUvvufqF+/AckgNFh043CSpo=
X-Sasl-enc: n1oofdfw1pGmL3KaBcWL02CkNReKsQoN28mtfC8GV+Cx 1296998000
Received: from localhost.localdomain (p54858388.dip0.t-ipconnect.de [84.133.131.136])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C66A4034EB;
	Sun,  6 Feb 2011 08:13:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D4DA4C1.5050501@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166145>

Rafael Kitover venit, vidit, dixit 05.02.2011 20:28:
> On 2/5/2011 11:58 AM, Andreas Ericsson wrote:
>> On 02/05/2011 05:09 PM, Rafael Kitover wrote:
>>> On 2/5/2011 11:03 AM, Jared Hance wrote:
>>>> On Sat, 2011-02-05 at 10:24 -0500, Rafael Kitover wrote:
>>>>> Hello,
>>>>>
>>>>> I found the core.filemode option, which ignores executable bits, but I
>>>>> need an option to ignore all mode differences, and such an option does
>>>>> not seem to exist.
>>>>
>>>> The only mode tracked by Git is the executable bit, so this shouldn't
>>>> even be an issue. Are you sure the executable bit isn't the problem?
>>>>
>>> $ git config --global core.filemode
>>> false
>>>
>>> Output of "git diff HEAD" :
>>>
>>> diff --git a/Makefile.PL b/Makefile.PL
>>> old mode 100755
>>> new mode 100644
>>> diff --git a/t/02ads.t b/t/02ads.t
>>> old mode 100755
>>> new mode 100644
>>> diff --git a/t/02cxn.t b/t/02cxn.t
>>> old mode 100755
>>> new mode 100644
>>> diff --git a/t/04os.t b/t/04os.t
>>> old mode 100755
>>> new mode 100644
>>
>> Those are all executable bit diffs.
>>
> 
> Ok, but I have core.filemode set to "false" as I showed, why does this 
> happen then?

I can't confirm this on linux with current git. What are your versions?
Do you have a minimal example (starting from git init)?

Michael

BTW: Leaving out helpful folks from cc does not help... I should not
have to re-add them by hand.
