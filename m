From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Tue, 01 Mar 2011 08:05:10 -0500
Message-ID: <4D6CEF06.6040406@cisco.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <4D6CDD2F.5070107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: unlisted-recipients:; git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:05:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuPGY-0005JP-BS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 14:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab1CANFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 08:05:20 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:52154 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab1CANFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 08:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=394; q=dns/txt;
  s=iport; t=1298984718; x=1300194318;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=d8CHzyPbvSL6e6c6wI5PCbAHaoRqAW3BxmAYTpes6U0=;
  b=MZ2mUCxTc3IltN9cj2cFLRWS0iwVhjxkB7KvqF3CrjkbsmH3kIn2+1q7
   Z3KFF4zf641SeJ+ctSXG8sjmprz3xR8rkXxbS3+0ePOjorr2gkAPaKauM
   gMZL1O+qwApjNuVx4ioZGKMokUK+NNjr9wUTzJogBwiWkvITsS2u6BlV7
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EABJ+bE2rR7H+/2dsb2JhbACEJ6IkdJ8EiwWRJoEng0R2BIUShw2DQA
X-IronPort-AV: E=Sophos;i="4.62,246,1297036800"; 
   d="scan'208";a="336955295"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-5.cisco.com with ESMTP; 01 Mar 2011 13:05:12 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id p21D5BFh008042;
	Tue, 1 Mar 2011 13:05:11 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
Illegal-Object: Syntax error in CC: address found on vger.kernel.org:
	CC:	unlisted-recipients:;git@vger.kernel.org
					     ^-missing end of address
In-Reply-To: <4D6CDD2F.5070107@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168217>

On 03/01/2011 06:49 AM, Michael J Gruber wrote:
> Michael J Gruber venit, vidit, dixit 01.03.2011 11:21:
>> Introduce a leading ':' as the notation for repo-wide pathspecs.
>>
>> This is in line with our treeish:path notation which defaults to
>> repowide paths.
>>
>> Heck: Even ':./path' works for pathspecs, and I have no clue why!

I like it.  Thanks for looking at this.

Phil
