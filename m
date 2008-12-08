From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 08 Dec 2008 19:43:53 +0100
Message-ID: <493D6AE9.6020504@tuffmail.com>
References: <493A6CEC.4060601@tuffmail.com>	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>	 <493C1F36.7050504@tuffmail.com>	 <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>	 <493C47FD.4080302@tuffmail.com>	 <493D1CC2.8050407@drmicha.warpmail.net>	 <493D66BB.3060907@tuffmail.com> <eaa105840812081040s1036b79an9914c1f74d6d7f6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Peter Harris <peter@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 19:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9l6X-0000iF-AF
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 19:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYLHSn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 13:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLHSn4
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 13:43:56 -0500
Received: from mxout-03.mxes.net ([216.86.168.178]:2956 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbYLHSnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 13:43:55 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 8092323E49F;
	Mon,  8 Dec 2008 13:43:54 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
In-Reply-To: <eaa105840812081040s1036b79an9914c1f74d6d7f6a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102573>

Peter Harris pisze:
> On Mon, Dec 8, 2008 at 1:26 PM, Grzegorz Kossakowski wrote:
>> After doing that git svn rebase resulted in:
>> [really long list of revisions]
>> r707379 = f61a2d30b6ac5a5136b46fa2b9b5b91e4763feb1
>> r710118 = 40997fe552e8581b75b08fed41a6b63a33d58bdf
>> r720135 = a8160766ec40fd7ebf95bfa7cebfa50dfa2f9c3a
>> r720180 = b094a222bab3671c8277087e7a96589ec76dd5e4
>> r720182 = 736b8ed6519c64ad120de2ccf08f135062ee09db
>> Done rebuilding .git/svn/origin/trunk/.rev_map.13f79535-47bb-0310-9956-ffa450edef68
>> Current branch master is up to date.
>>
>> Is this expected output?
> 
> Yes. The rfoo = sha1hash part is git-svn rebuilding its index.
> "Current branch master is up to date" is git-svn calling "git rebase
> <svn-branch>", and git saying that there is nothing to do, since there
> have been no svn commits to that branch since the last time you ran
> git svn rebase (or since you cloned the git mirror, or since the last
> time the git mirror pulled from svn).

Thanks for confirmation and explanation.

The remaining question is who should address this issue with non-existing trunk ref? Should I ask
Jukka, who maintains svn mirrors, to put instruction into his scripts that will add trunk reference?

Would it be the best practice?

-- 
Best regards,
Grzegorz Kossakowski
