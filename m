From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: commit --strict feature request
Date: Wed, 24 Mar 2010 12:14:21 +1100
Message-ID: <SNT124-W65458CD48BBB9A6A831FDEC4250@phx.gbl>
References: <4BA8FEA4.60504@gmail.com>,<SNT124-W659C1D09B747F338E04DF4C4250@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <berdario@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 02:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuFB2-0000Sp-5C
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 02:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0CXBO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 21:14:26 -0400
Received: from snt0-omc2-s33.snt0.hotmail.com ([65.55.90.108]:22998 "EHLO
	snt0-omc2-s33.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378Ab0CXBO0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 21:14:26 -0400
Received: from SNT124-W65 ([65.55.90.72]) by snt0-omc2-s33.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Mar 2010 18:14:24 -0700
X-Originating-IP: [211.30.173.126]
Importance: Normal
In-Reply-To: <SNT124-W659C1D09B747F338E04DF4C4250@phx.gbl>
X-OriginalArrivalTime: 24 Mar 2010 01:14:24.0693 (UTC) FILETIME=[57779650:01CACAEF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143061>


> From: timmazid@hotmail.com
> To: berdario@gmail.com; git@vger.kernel.org
> Subject: RE: commit --strict feature request
> Date: Wed, 24 Mar 2010 12:10:06 +1100
>
>
>> Date: Tue, 23 Mar 2010 18:47:16 +0100
>> From: berdario@gmail.com
>> To: git@vger.kernel.org
>> Subject: commit --strict feature request
>>
>> Hi, i usually use bzr, and today i was searching for a commit --strict
>> equivalent in git... i asked around and it seems there isn't one, so i'm
>> writing this.
>>
>> basically, by doing commit --strict it refuses to commit if there are
>> untracked (and thus not ignored) files in the tree, this helps against
>> forgetting to add new files (actually i find it so useful that i've even
>> changed commit to be an alias to commit --strict in my bzr aliases )
>>
>>
>> greetings
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
> Hi,
>
> I think (someone correct me if I'm wrong) that being able to commit only part of the changes you made at a time is one of the major points of git (at least for me, anyway), so such a feature might go against the whole design.
>
> Also, what you could use is 'git commit -v', which allows you to review all the changes you are commiting, and allows you to write a better commit message anyway, as you can look at the changes, instead of going from memory.
>
> Another option might be to use a gui, such as 'git gui', which gives you a clear visual of what files have unstaged changes.
>
> Hope that helps until somebody competent replies.
>
> Tim.
>
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 
Oh, and I just realised, 'git commit' does actually show you a 'git status' (by default in v1.7.0) when you write your message anyway, so you don't even need the '-v' to see what files are staged/unstaged. 		 	   		  
_________________________________________________________________
Browse profiles for FREE! Meet local singles online.
http://clk.atdmt.com/NMN/go/150855801/direct/01/