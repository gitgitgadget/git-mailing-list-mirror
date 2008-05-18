From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: [BUG] make test fails on osx (t7502-commit.sh)
Date: Sun, 18 May 2008 18:13:10 -0400
Message-ID: <1A30A982-33B4-45BD-8291-FE1F61AFD6F9@gmail.com>
References: <75B80F22-AC86-4D3F-A7E6-7DE70AEE5114@gmail.com> <46A56F20-DFB7-451E-9E81-71FA51FE1E27@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon May 19 00:14:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxr96-0005aJ-6a
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 00:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbYERWNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 18:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbYERWNX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 18:13:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:26572 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbYERWNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 18:13:22 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1340329wxd.4
        for <git@vger.kernel.org>; Sun, 18 May 2008 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=otcbdwRpdWTbAp044Psou6o5+/G6/gn4QcuV4L4FvhI=;
        b=s/fZfx9ydYtq8Zf/wDCV0mSx43ajPKPdDQvTjJZyp8r06pj2tXzUtba2kFkBXMgIVYPO7FOfNm+tiUQC1tLHNFG5GOj1o91GSIaFHkfrIISIrdG1aU9LbCF2bE2EpCWRRvcejtRCoM6Kkd20AkfrKnuuhafzqjp2Ybi4VFPyY/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=SW0Q8GwSmwNomcqRhLt1rdCnBy+ZbYH6saGBaL6rfl4o9teJ42hUJI7bta/JBlFssUH40DIw9QkQiIC5PkLSOvwSWCCSn8TdUiVwF/QDw76DgMo8LGyO6LEpDxCqYLdKkoTU46vGPw5ybjWua5kc9dIxqtvqEXj15NbBx365t4Y=
Received: by 10.70.49.1 with SMTP id w1mr8321218wxw.19.1211148801170;
        Sun, 18 May 2008 15:13:21 -0700 (PDT)
Received: from ?192.168.1.101? ( [65.96.170.12])
        by mx.google.com with ESMTPS id h13sm10299887wxd.36.2008.05.18.15.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 May 2008 15:13:20 -0700 (PDT)
In-Reply-To: <46A56F20-DFB7-451E-9E81-71FA51FE1E27@sb.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82398>

On May 16, 2008, at 10:58 PM, Kevin Ballard wrote:
> On May 16, 2008, at 7:59 PM, Rhodes, Kate wrote:
>
>> just checked out the main branch  
>> 1fbb58b4153e90eda08c2b022ee32d90729582e6
>> The offending message from make test follows.

[snip]

>
> See http://marc.info/?l=git&m=121089732118252&w=2. A patch was  
> submitted to fix this problem, but apparently hasn't been accepted  
> yet.

[snip]

Thanks. I can confirm that that patch fixed it for me.

-Kate
