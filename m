From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 18:20:10 +0100
Organization: OPDS
Message-ID: <1B5C619E91F7437EA844D1D3DD3E6798@PhilipOakley>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <3c10d6593152436c9dd3a5b5773e3c79-mfwitten@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Michael Witten" <mfwitten@gmail.com>,
	"John S. Urban" <urbanjost@comcast.net>
X-From: git-owner@vger.kernel.org Sun Sep 04 19:20:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0GMi-0004Hi-9U
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 19:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab1IDRUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 13:20:06 -0400
Received: from out1.ip09ir2.opaltelecom.net ([62.24.128.245]:53175 "EHLO
	out1.ip09ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751085Ab1IDRUE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 13:20:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAJyyY05cHIaz/2dsb2JhbABBihmeTnmBQQEEAQEFCAEBLh4BASELAgMFAgEDDgQDAwklFAEECBIGBwkBDQYBEggCAQIDAYdcCAK3NYYKYASHPJVuhxI
X-IronPort-AV: E=Sophos;i="4.68,329,1312153200"; 
   d="scan'208";a="489268066"
Received: from host-92-28-134-179.as13285.net (HELO PhilipOakley) ([92.28.134.179])
  by out1.ip09ir2.opaltelecom.net with SMTP; 04 Sep 2011 18:20:01 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180689>

From: "Michael Witten" <mfwitten@gmail.com>
> On Sat, 3 Sep 2011 21:32:03 -0400, John S. Urban wrote:
>> Also, I have some commits with multiple tags pointing to them. It has 
>> come
>> to my attention that might not be an intentional feature. I could find
>> nothing in the documentation explicitly stating multiple tags were 
>> allowed
>> to point to a commit; but the tags seem to be unique "objects" so I
>> see no reason this should not be an expected feature?
>
> Well, everybody, it sounds like John's confusion is a good example for
> why `tag' is another TERRIBLE choice of terminology.
>
> See here:
>
>  http://article.gmane.org/gmane.comp.version-control.git/179609
>  Message-ID: 
> <CAMOZ1Btmk86vmp1gRuCfG7yRuc6fD3_oYBvtq2VKK9Ywu8ay0A@mail.gmail.com>
>
>  http://article.gmane.org/gmane.comp.version-control.git/179942
>  Message-ID: 
> <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
> --
In terms of things understood and misunderstood, I found that Branches and 
Tags were reasonable terms for use within Git at the time I read about them 
(I'm still getting to grips with git in a hostile Windows environment).

There were other areas of confusing (to me) terminology, such as heads, 
tips, and refs, which are 'the same' within particular contexts. In the same 
way the Index/Staging area can be confusing without a good visualisation.

The fact that Git has both Trees, and Branches but relating to different 
parts of the architecture can be a bit confusing, but wasn't too much of a 
hassle.

The fact that git does merging with relative ease is one reason that brings 
on the 'branch' problem. If merging is a major activity that is kept 
independent of the SCM, as it often is, then branches take on a bigger 
meaning as being proper sub-projects with all the attention that comes from 
there. If they are simple, lightweight, easy to use, and 'discard' then the 
concerns should reduce, unless that is, local customs keep worrying the 
issue. Most SCM systems are built on archaic principles that pre-date 
computers, so a new methodology has an uphill battle.

In terms of Figure 0 in Sourceforge, It doesn't fully represent the 
information that Git would have, because the order of parentage would be 
available, though Git doesn't mandate that branch names are remembered (but 
is normally within merge commit messages). This means that some folks would 
feel unhappy about the bundle of diverge/merge links in the DAG that don't 
have Names, which is a very human concern.

Overall, I'm not too unhappy with the terminology, and yes I would like 
filter-branch to be able to copy across tags when creating a publishable 
history - it probably just need me to understnd the right --tag-name-filter 
<command>.

Philip
