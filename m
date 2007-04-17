From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 17:55:32 +0200
Message-ID: <8c5c35580704170855ke426d86vac6e9b3b67fea5ea@mail.gmail.com>
References: <4624CD58.90103@gmail.com>
	 <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
	 <4624EAAA.6040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>, git@vger.kernel.org
To: "Rene Herman" <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdq1v-0006s2-Uf
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031096AbXDQPzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031099AbXDQPzk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:55:40 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:37670 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031096AbXDQPzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:55:40 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1518399nze
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 08:55:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UTUib4ng5fYDh0YhxhjEu5oolYVkqYgj5sRXKVtdJIfC+5qauwNqqT/YKdqD34HFK3WRH/a59ysAIBYGKNP3bM6a4TV7M1MIW6HCPuLoMHYebYa9aDrqMUsXUdovret+8gcbkrdvPu17M8paRNPMwcUZz/WmxViWjoQhnjVnrpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ej6dZbOyu6Ov7BWeawYP9g9fVm/TZNkJd+y7oM9zYzFGWXxpKtAOpaU7F/5iWuN2lnjdoMKnE+TxYcSrLnoHunSJt0hxza4E/Bt1GmJsFvwsp8RQA6iS5M3Wk9IoYxOFclRIMCMet7sG81s6V7c8ImlHemPy8PF9krkEb6q7FLY=
Received: by 10.115.92.2 with SMTP id u2mr2483597wal.1176825333036;
        Tue, 17 Apr 2007 08:55:33 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Tue, 17 Apr 2007 08:55:32 -0700 (PDT)
In-Reply-To: <4624EAAA.6040000@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44787>

On 4/17/07, Rene Herman <rene.herman@gmail.com> wrote:
> git clone -l -s -n <a local linux repo> local
> git checkout -b v20 v2.6.20
> git branch a
> git branch b
> git branch c
>
> Step 1, 3, 4 and 5 of this are nearly instantaneous but 2 isn't

I might have misunderstood your goal, but have you tried

 git clone -l -s -n <a local linux repo> local
 git branch a v2.6.20
 git branch b a
 git branch c a

Now a, b and c all point at v2.6.20, while HEAD points as master.

--
larsh
