From: Illia Bobyr <ibobyr@blizzard.com>
Subject: Re: surprising behavior from merge
Date: Sat, 12 May 2012 02:25:09 +0000
Message-ID: <4FADCA05.60109@blizzard.com>
References: <9A9AD20F-B316-4DC1-8C6A-E0FC6ED80A61@highlab.com>
 <ae419d8bbc2b44bfa4c0a7eb421f5037-mfwitten@gmail.com>
 <4FADA967.10808@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "seb@highlab.com" <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat May 12 04:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST21V-0003K8-BS
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 04:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340Ab2ELCZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 22:25:13 -0400
Received: from mx10.blizzard.com ([12.130.201.12]:25953 "EHLO
	mx10.blizzard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab2ELCZL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2012 22:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=blizzard.com; i=ibobyr@blizzard.com; q=dns/txt;
  s=mail; t=1336789511; x=1368325511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vOAAkfhWkflRqaIY9ow6Zxr05jjVxrVNJduYRVwz+pc=;
  b=A1XUbCoxJOLWJeHR20yhCzkYMoCcwttqHTPRccgACOlqFfQkxmyiUZU1
   34nQFEvc8cjH2tO8jZ8Rt2/gYLF6tNj5XD/+4yQlcT85v3NYmcQko45NT
   H1q+ko8U6CyBa/rSEacM6UTPZmtmMm5my7gAcL6ilFQG95QbtpdP/blQ7
   A=;
X-IronPort-AV: E=Sophos;i="4.75,574,1330934400"; 
   d="scan'208";a="3550817"
Received: from irvex205.corp.blizzard.net ([10.130.14.26])
  by mx10.blizzard.com with ESMTP; 11 May 2012 19:25:10 -0700
Received: from IRVEX016.corp.blizzard.net (10.130.2.71) by
 IRVEX205.corp.blizzard.net (10.130.14.26) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Fri, 11 May 2012 19:25:10 -0700
Received: from IRVEX008.corp.blizzard.net ([fe80::c5f9:f4ad:53fc:4d4b]) by
 IRVEX016.corp.blizzard.net ([::1]) with mapi id 14.01.0289.001; Fri, 11 May
 2012 19:25:10 -0700
Thread-Topic: surprising behavior from merge
Thread-Index: AQHNL8YUnm0RZJOIHkyHUk/rRIDzLpbFuWkAgAACaICAACbigA==
In-Reply-To: <4FADA967.10808@highlab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.129.238.124]
Content-ID: <AFBC6A58952D9746A80F394F175FD515@blizzard.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197710>

On 5/11/2012 5:05 PM, Sebastian Kuzminsky wrote:
> On 05/11/2012 05:57 PM, Michael Witten wrote:
>> On Fri, 11 May 2012 16:25:29 -0600, Sebastian Kuzminsky wrote:
>>
>>> The simplified repo is here if anyone wants to inspect it:
>>> https://github.com/SebKuzminsky/merge-problem
> ...
>
>> In other words, rather than burdening people with the task of
>> constructing a mental picture of what you have done, you should
>> show them as directly and precisely as possible; in this way,
>> people can go about the business of discussing your issue much
>> more quickly and, most importantly, PRECISELY.
>>
>
> Ah, I had intended the extremely tiny git repo I linked to to provide 
> the info in the most concise way possible.  The surprising behaviour 
> happened at the final commit in the repo, which was made by 'git merge 
> other'.
>
> I can email a list of commands to reproduce the issue later tonight if 
> that would make anything clearer.

The repository you provided is actually quite simple and clear, though I 
have no idea why this might be happening.  Or if it is an expected behavior.

At the same time if you provide a list of command if someone will be 
fixing this they may server as an automated test.  Git has a lot of them.

--
Illia Bobyr
