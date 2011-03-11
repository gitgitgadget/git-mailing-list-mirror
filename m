From: "Alexey Feldgendler" <alexeyf@opera.com>
Subject: Re: Correcting forgetting to make a new branch
Date: Fri, 11 Mar 2011 16:46:50 +0100
Organization: Opera Software ASA
Message-ID: <op.vr6rgcqs56e9f9@xman.eng.oslo.osa>
References: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 16:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4YM-00057A-L1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab1CKPqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:46:53 -0500
Received: from smtp.opera.com ([213.236.208.81]:45049 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab1CKPqw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:46:52 -0500
Received: from xman.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p2BFkpcW022692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 11 Mar 2011 15:46:51 GMT
In-Reply-To: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168911>

On Fri, 11 Mar 2011 16:31:18 +0100, Howard Miller  
<howard@e-learndesign.co.uk> wrote:

> The scenario is that I have done work on a branch and made a number of
> commits. What I wanted to do was to start a new branch before I made
> these commits. Unfortunatel, I got distracted and forgot that I hadn't
> done it.
>
> Is there are neat way to create the branch and 'move' the commits over?

Just create a new branch right where you are, it will be correct.

However, the branch that was active before when you should have branched  
will have been unintentionally updated. To fix that, you'll need to move  
the old branch a few commits back:

git branch -f <old-branch> <where-it-was-before>


-- 
Alexey Feldgendler
Software Developer, Desktop Team, Opera Software ASA
[ICQ: 115226275] http://my.opera.com/feldgendler/
