From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 12:56:21 -0400
Message-ID: <9e4733910608180956n64e3362fm5c72d652e6b6243a@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
	 <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com>
	 <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 18:57:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7e9-0001IM-Jy
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWHRQ4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWHRQ4W
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:56:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:25404 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751422AbWHRQ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 12:56:21 -0400
Received: by nz-out-0102.google.com with SMTP id 14so53262nzn
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 09:56:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nYdtbDYT1OTY0jgTnoi3hnDm5AxDOOeHM+TVBlMWpZZ7wQpwyv09r4y8lsQ2sYL6b5AL0tZPcWLl6rALgS0u6ysRUtoVjGH8sBjSrQeDiJQmbIfApaP4ziy7HXVh4Zas64Kjtghsw3FPWJWfKTkBt1jxdcZVipL57fciPKcHCeM=
Received: by 10.65.93.18 with SMTP id v18mr4004408qbl;
        Fri, 18 Aug 2006 09:56:21 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Fri, 18 Aug 2006 09:56:20 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25678>

On 8/18/06, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 18 Aug 2006, Jon Smirl wrote:
>
> > I attached Shawn's code. He is gone until Monday and can't defend it.
>
> I will have a look at it next week as I'll be gone for the weekend as
> well.

I looked at it some and couldn't see anything obviously wrong with it,
but it wasn't a detailed inspection.

As comparison, I just tar/zipped the Mozilla CVS repo and it is 541MB.
The 295MB git pack number does not have commits and trees in it, it is
revisions only.

It is not impossible that when the trees and commits are added to the
295MB number that it won't end up being near the 541MB number. We
already know xdiff is better at generating diffs than CVS diff. And I
still have to add 250K log entries and trees. Those are going to add
at least 100MB.

I will get back to work on the import code over the weekend. One of my
2 year olds gave me a cold so I have been useless the last couple of
days.

-- 
Jon Smirl
jonsmirl@gmail.com
