From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH] How to keep a project's canonical history correct.
Date: Fri, 09 May 2014 21:01:46 -0700
Message-ID: <4639676.GfT2sDDHtN@thunderbird>
References: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com> <1399615721-566-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 05:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiyQp-0000i7-6G
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 05:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbaEJD6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 23:58:35 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:55314 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaEJD6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 23:58:34 -0400
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20140510035834.KXHI32389.fed1rmfepo103.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Fri, 9 May 2014 23:58:34 -0400
Received: from thunderbird ([68.231.74.114])
	by fed1rmimpo306 with cox
	id 03yZ1o00C2TxN4s013yZ9p; Fri, 09 May 2014 23:58:34 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.536DA3EA.0020,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Ve8pyiV9 c=1 sm=1
 a=So8zV0cAyE/J2U/+o1/Dyg==:17 a=HZTKFlc_eFYA:10 a=XtLmfymxdMcA:10
 a=G8Uczd0VNMoA:10 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=X2LLF9g5srOQu3ivF0MA:9
 a=CjuIK1q_8ugA:10 a=So8zV0cAyE/J2U/+o1/Dyg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id B616713F80C;
	Fri,  9 May 2014 21:01:47 -0700 (MST)
User-Agent: KMail/4.13 (Linux/3.13.0-24-generic; KDE/4.13.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248649>

On Friday, May 09, 2014 02:05:44 PM Junio C Hamano wrote:
> I needed a few tweaks on top while queuing.  You will find the
> result on 'pu' after I push it out.
> 
> In addition to one typofix ("because" lacking "c"), here are what I
> did:
> 
>  - Typeset concrete command e.g. `git pull` in monospace.
> 
>  - The second and subsequent paragraphs continued with "+" need to
>    be flushed to the left; leaving them indented will format them in
>    monospace (see "with `git pull --rebase` or something").
> 
>  - Be more explicit in describing 'trunk' being 'the first-parent
>    chain' in the text.
> 
>  - Refer to a newer article that discusses this exact topic.
> 
>  - De-emphasize 'fix-bug-12345' in "Merge fix-bug-12345" log message.
> 
>  - Describe what the final history illustration shows.
> 
> 
> Unless you have objections to the below (or suggestions for better
> alternatives), there is no need to resend the patch.
> 

I like the changes.
