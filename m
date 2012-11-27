From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH] Documentation/git-push.txt: fix typo in remote tracking
 branch path
Date: Mon, 26 Nov 2012 17:57:11 -0800
Message-ID: <50B41DF7.2000705@nvidia.com>
References: <1353977748-17110-1-git-send-email-bcasey@nvidia.com> <7vy5hnomsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdAQS-0002XV-A7
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 02:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976Ab2K0B5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 20:57:13 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:14309 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462Ab2K0B5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 20:57:12 -0500
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B50b41eb20000>; Mon, 26 Nov 2012 18:00:18 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2012 17:57:10 -0800
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 26 Nov 2012 17:57:10 -0800
Received: from [172.17.129.244] (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.279.1; Mon, 26 Nov 2012
 17:57:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vy5hnomsl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210526>

On 11/26/2012 5:30 PM, Junio C Hamano wrote:
> Brandon Casey <bcasey@nvidia.com> writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> This example in the documentation seems to be trying to describe the likely
>> remote tracking branch that will be updated by a push to the "origin" remote
>> with the destination branch 'satellite/master', but it forgot to specify
>> the remote name in the path specification.
>>
>> So,
>>
>>     refs/remotes/satellite/master
>>
>> should be spelled like
>>
>>     refs/remotes/origin/satellite/master
>
> I might make sense to rename 'origin' to 'mothership' in that
> example and explain that this is emulating 'git fetch' run on the
> mothership to integrate the work done on 'satellite' using 'git
> push' in the opposite direction, which is often necessary when you
> can only make connection in one way (i.e. satellite can ssh into
> mothership but mothership cannot initiate connection to satellite
> because the latter is behind a firewall or does not run sshd).
>
> If you were to run 'git fetch' on the mothership to intgrate the
> work on the 'satellite', it would have a remote called 'satellite',
> and would keep remote-tracking branches for the branches local to
> 'satellite' in the 'refs/remotes/satellite/' hierarchy.  You would
> push your local 'master' to their 'refs/remotes/satellite/master',
> to emulate 'git fetch' done on the mothership in the reverse
> direction.
>
> So refs are correct. The context is not sufficiently explained.

Ah, I see.  Yeah, I think that is complex enough to merit an
extended explanation.

-Brandon


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
