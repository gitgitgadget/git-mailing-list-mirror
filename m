From: Kevin Ballard <kevin@sb.org>
Subject: Re: [BUG] make test fails on osx (t7502-commit.sh)
Date: Fri, 16 May 2008 22:58:36 -0400
Message-ID: <46A56F20-DFB7-451E-9E81-71FA51FE1E27@sb.org>
References: <75B80F22-AC86-4D3F-A7E6-7DE70AEE5114@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 04:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxCe6-0007CT-Lf
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 04:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbYEQC6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 22:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYEQC6w
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 22:58:52 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:35253 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753150AbYEQC6v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 22:58:51 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 34B7918DB5B;
	Fri, 16 May 2008 19:58:47 -0700 (PDT)
In-Reply-To: <75B80F22-AC86-4D3F-A7E6-7DE70AEE5114@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82332>

Hi.

On May 16, 2008, at 7:59 PM, Rhodes, Kate wrote:

> just checked out the main branch  
> 1fbb58b4153e90eda08c2b022ee32d90729582e6
> The offending message from make test follows.
>
> -Kate
> P.S. My apologies if this is a dupe. I didn't see it when i searched  
> the archives.
>
>
> *** t7502-commit.sh ***
> *   ok 1: the basics
> *   ok 2: partial
> *   ok 3: partial modification in a subdirecotry
> *   ok 4: partial removal
> *   ok 5: sign off
> *   ok 6: multiple -m
> *   ok 7: verbose
> *   ok 8: cleanup commit messages (verbatim,-t)
> *   ok 9: cleanup commit messages (verbatim,-F)
> *   ok 10: cleanup commit messages (verbatim,-m)
> *   ok 11: cleanup commit messages (whitespace,-F)
> *   ok 12: cleanup commit messages (strip,-F)
> *   ok 13: cleanup commit messages (strip,-F,-e)
> *   ok 14: author different from committer
> sed: 1: "expect": invalid command code e
> * FAIL 15: committer is automatic
> 	
> 	
> 		echo >>negative &&
> 		git commit -e -m "sample"
> 		head -n 8 .git/COMMIT_EDITMSG |	\
> 		sed "s/^# Committer: .*/# Committer:/" >actual &&
> 		test_cmp expect actual
> 	
> *   ok 16: do not fire editor in the presence of conflicts
> * failed 1 among 16 test(s)
> make[1]: *** [t7502-commit.sh] Error 1
> make: *** [test] Error 2\

See http://marc.info/?l=git&m=121089732118252&w=2. A patch was  
submitted to fix this problem, but apparently hasn't been accepted yet.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
