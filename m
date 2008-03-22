From: =?ISO-8859-1?Q?Nagy_Bal=E1zs?= <js@iksz.hu>
Subject: Re: Cygwin: problem with renaming and case
Date: Sat, 22 Mar 2008 20:58:45 +0100
Message-ID: <47E564F5.6010005@iksz.hu>
References: <47E3DD28.4030302@tiscali.it> <37fcd2780803211157n15cec620gb5ab1d3e57ccd37b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Frank <streamlake@tiscali.it>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 21:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9sc-0007f6-Mp
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbYCVT7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbYCVT7J
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:59:09 -0400
Received: from smtp.aranyoroszlan.hu ([195.56.77.57]:54237 "EHLO
	smtp.aranyoroszlan.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYCVT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:59:08 -0400
Received: (qmail 3098 invoked by uid 263); 22 Mar 2008 20:08:13 -0000
Received: from 213.178.104.196 (js@iksz.hu@213.178.104.196) by tcb.aranyoroszlan.hu (envelope-from <js@iksz.hu>, uid 256) with qmail-scanner-2.02st 
 (clamdscan: 0.92/5779. spamassassin: 3.2.4. perlscan: 2.02st.  
 Clear:RC:0(213.178.104.196):SA:0(-1.4/5.0):. 
 Processed in 3.679647 secs); 22 Mar 2008 20:08:13 -0000
X-Spam-Status: No, hits=-1.4 required=5.0
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tcb.aranyoroszlan.hu
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RDNS_NONE autolearn=no version=3.2.4
X-Envelope-From: js@iksz.hu
Received: from unknown (HELO ?192.168.1.100?) (js@iksz.hu@213.178.104.196)
  by tcb.aranyoroszlan.hu with SMTP; 22 Mar 2008 20:08:09 -0000
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <37fcd2780803211157n15cec620gb5ab1d3e57ccd37b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77848>

Dmitry Potapov wrote:
> I wonder do you really need to have two files on different branches whose
> name only differ by case, especially when you work on case insensitive
> filesystem? I suspect the answer is no. In this case, you can choose one
> policy for file naming and stick to it. For instance, that all names should
> be in low case except Makefile, or something like that. This policy can be
> enforced using pre-commit hook.
>   

qmail-1.03 is one of the rare species which has two files which differ 
only in their case, namely INSTALL and install.  The first one contains 
the documentation, the latter one is compiled from source.  Apart from 
that I don't know any other affected projects.

On the other hand, most of the software developers are morons, 
especially in a corporate environment.  The problem is you cannot refuse 
their work all the way, and they like to create evil twins (file names 
which were removed and added again), and case collisions.  I could even 
see a lot of symlinks in a clearcase vob which poined to 
`..\..\..\../a/b/c'.  Developer stupidity is unlimited.

Regards,
-- 
-jul-
