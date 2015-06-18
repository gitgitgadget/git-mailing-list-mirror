From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Thu, 18 Jun 2015 15:05:17 +0200
Organization: gmx
Message-ID: <126a1ed453d1624083c069b904dd25c0@www.dscho.org>
References: <557F791D.3080003@nextest.com>
 <87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
 <5582B8EC.1060205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Eric Raible <raible@nextest.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ZVh-0008TM-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 15:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbbFRNFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 09:05:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:50544 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbbFRNF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 09:05:29 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MDi9C-1ZLaDJ2spS-00H6Hs; Thu, 18 Jun 2015 15:05:19
 +0200
In-Reply-To: <5582B8EC.1060205@drmicha.warpmail.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:p/arqz1nYXNRx1LK1BAt6rjH+hoT3EVllZkoyIdLOHS7ochLUPG
 XT1xL4D820DKgR+qcxcTR5CGW3t87LOX8SPXZZ9ZQHisMIKczqPEdtirQKrSKJcF+iq7CIo
 6ND5eyB6EEkSN590PX+zkzsZvyOVT4Rr8KOr5t1/S6rOq0l7zien9rmwas+MMNc8Md5H5TF
 9Nf4DseeD1I+v5J7d6cSg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272005>

Hi Micha,

On 2015-06-18 14:26, Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 16.06.2015 11:43:
>
>> To list all the merge commits in the current branch, I would use the command-line:
>>
>> ```bash
>> git rev-list --author="My Colleague" --parents HEAD |
>> sed -n 's/ .* .*//p'
>> ```
>>
>> (i.e. listing all the commits with their parents, then filtering just the ones having more than one parent, which would include octopus merges if your history has them.)
> 
> :)
> 
> "--merges" (aka "--min-parents=2") is your friend here.

Learnt something!

Thanks,
Dscho
