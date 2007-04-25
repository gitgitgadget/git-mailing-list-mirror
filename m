From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: basic question
Date: Wed, 25 Apr 2007 12:40:24 +0200
Message-ID: <81b0412b0704250340n555d4398i9288255562be78ba@mail.gmail.com>
References: <f36b08ee0704250234u5ee4557au22fefa637d25aef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 12:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgevF-00068e-51
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 12:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992466AbXDYKkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 06:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992530AbXDYKkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 06:40:25 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:1519 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992466AbXDYKkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 06:40:24 -0400
Received: by an-out-0708.google.com with SMTP id b33so3470ana
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 03:40:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SdevfQxtzYKNKAQ83TpG7aXvU1BiSI7HW1v3qBNwq4869w5Tt+BowmyCdSfmmd4/SlUmqAIw7dWfAKu6ByKLvRGWSZpUKbaWzSh6lv8etV/IfHcXlaAIFi3l5XV8wiTBA6Y8CGiY4oVNP2QirDI+pGWhjhBbU8ikp/MxVAxyaTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jl6K4ZylqSbpVI8PhkhE8BuMqbd3ZQd+Vw1BCf5wU2SHpUvkFu6u15bTAhgjtgLp4vwkXXx8NwhpJMAQUa5cW7gHa3OYLgRjnIMLPRPPPI7KL0YB14SUsu9w5ItPNol+BaoNBXVaV3Kz86UTrQ2DaqQelAU9eUWS7X9CxM8U9ms=
Received: by 10.100.195.10 with SMTP id s10mr2541anf.1177497624204;
        Wed, 25 Apr 2007 03:40:24 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 25 Apr 2007 03:40:24 -0700 (PDT)
In-Reply-To: <f36b08ee0704250234u5ee4557au22fefa637d25aef0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45518>

On 4/25/07, Yakov Lerner <iler.ml@gmail.com> wrote:
> I have bare repo X, and two clones A and B (basically my work copy and
> home copy of same personal files. I use 'git-pull origin' and 'git
> push origin master' to sync files).
>
> The same file 'xxx' was modified on A and on B, and committed on both.
> In A, trying now 'git-pull origin', I get 'xxx: needs update'.
> Which commands do I use now to merge xxx on A ?
>

You have _not_ committed the file xxx in A.

git commit -a
git pull B
