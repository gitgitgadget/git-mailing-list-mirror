From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Announcement: Git Extensions stable (windows shell extensions)
Date: Thu, 18 Dec 2008 14:44:41 +0100
Message-ID: <bd6139dc0812180544h2af10f9bsd76fb148bca1ee3e@mail.gmail.com>
References: <1229540813648-1669264.post@n2.nabble.com>
	 <c115fd3c0812171204ve560583w4c76aac0ac08d8ae@mail.gmail.com>
	 <1976ea660812171757s37e8435cxc4d34ade04635b81@mail.gmail.com>
	 <1229587749729-1672012.post@n2.nabble.com>
	 <bd6139dc0812180036m4c70dea4gfe160a5fff1faf65@mail.gmail.com>
	 <1976ea660812180540g5efbcb42oe498503216d8a3c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Henk <henk_westhuis@hotmail.com>, git@vger.kernel.org
To: "Frank Li" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 14:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJCV-0002jw-0y
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 14:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYLRNon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 08:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYLRNon
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 08:44:43 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:1453 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYLRNom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 08:44:42 -0500
Received: by yx-out-2324.google.com with SMTP id 8so156630yxm.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 05:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=1PTXu243qUHi/4QvXY3C3RfsypEeMzNOiTAs9uWYqoE=;
        b=KXBRYzv6mjppqEKjVzZ/c150vyoZbbScd0RzADIQDZmub0jWXpBYK5X0PitjmNBJgn
         GfKGJf7wzIL+AUFZ7qZC6FT54JoM9lEusd+c3SnQPbqmGiqAFVhEkwzeZFX1Xrwe8L+R
         tr4STUJG+BQR2eQNtmniezdZi3pvamqvG4wd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=SuOm+839vwbZVrTDB6Xj1WQxfzyEbS51ASz5VZtFzhkRNBBJVVhYbC6cEf1edWZnaN
         IrydCMCjkYr9kCuT1S2N3KglOAq1/BW2EUBRASeq586pZemPjKMd6WnUJelyAeCWz9Zn
         uN98cwgBs2mgzExbzLJXVZArqJ0IrPvPUSlSw=
Received: by 10.150.181.7 with SMTP id d7mr3570213ybf.12.1229607881238;
        Thu, 18 Dec 2008 05:44:41 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Thu, 18 Dec 2008 05:44:41 -0800 (PST)
In-Reply-To: <1976ea660812180540g5efbcb42oe498503216d8a3c9@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: fdbf76f026f629d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103458>

On Thu, Dec 18, 2008 at 14:40, Frank Li <lznuaa@gmail.com> wrote:
> I am considerring how to implement clone.
>
> I hope Git can provide a client library like SVN.
> I see libgit2 project. I hope git itself should use the same library.

The goal of libgit2 is to provide a library that git will use itself
for basic object manipulation. I do not know if operations like clone
are planned.

-- 
Cheers,

Sverre Rabbelier
