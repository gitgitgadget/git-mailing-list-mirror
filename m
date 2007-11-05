From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 5 Nov 2007 11:28:03 -0800
Message-ID: <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7cW-0005vm-Lh
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbXKET2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbXKET2H
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:28:07 -0500
Received: from tater.midwinter.com ([216.32.86.90]:49485 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753501AbXKET2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:28:05 -0500
Received: (qmail 30923 invoked from network); 5 Nov 2007 19:28:04 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=BraE9Zeb5fmwKKWy/oiekQahHop2QYHTnnRDW8WmOsYsMa9Pj8O4PONbdr6Cexw0  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 19:28:04 -0000
In-Reply-To: <1194289301-7800-1-git-send-email-madcoder@debian.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63540>

On Nov 5, 2007, at 11:01 AM, Pierre Habouzit wrote:
> When git-revert has a file argument then redirect the user to what he
> probably meant.

That's a big improvement. Basically everyone I show git to gets  
"revert" wrong at first.

> +			die("Cannot find commit '%s', did you meant: "
> +				"git checkout HEAD -- '%s'", arg, arg);

But that suggested command is not going to convince anyone they were  
wrong about git being hard to learn. I wonder if instead of saying, "I  
know what you meant, but I'm going to make you type a different  
command," we should make git revert just do what the user meant.

There is already precedent for that kind of mixed-mode UI:

git checkout my-branch
vs.
git checkout my/source/file.c

-Steve
