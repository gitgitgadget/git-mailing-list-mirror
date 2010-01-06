From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: [PATCH 1/2] git-svn: ignore changeless commits
 when checking for a cherry-pick
Date: Thu, 07 Jan 2010 11:38:38 +1300
Message-ID: <4B4510EE.4090504@vilain.net>
References: <1262808529-1575-1-git-send-email-amyrick@apple.com> <20100106214338.GA5115@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Myrick <amyrick@apple.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 23:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSeWg-0003wM-PU
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 23:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab0AFWiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 17:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105Ab0AFWiq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 17:38:46 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:36467 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab0AFWip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 17:38:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id F2DE032AB4;
	Thu,  7 Jan 2010 11:38:38 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9PTFBSjJ+vU; Thu,  7 Jan 2010 11:38:38 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 7F005329DD;
	Thu,  7 Jan 2010 11:38:38 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20100106214338.GA5115@dcvr.yhbt.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136307>

Eric Wong wrote:
> Andrew Myrick <amyrick@apple.com> wrote:
>   
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 650c9e5..8c7c034 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -3052,12 +3052,36 @@ sub check_cherry_pick {
>>  	for my $range ( @ranges ) {
>>  		delete @commits{_rev_list($range)};
>>  	}
>> +        for my $commit (keys %commits) {
>>     
>
> Hi Andrew,
>
> I'll again defer to Sam for Acks on these.  Test cases would be nice to
> have, too.
>   

They look fine to me, agreed a test case would be nice and make sure the
features aren't lost later inadvertently.

Thanks Andrew,
Sam
