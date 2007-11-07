From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 18:03:12 -0500
Message-ID: <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iptvm-00016C-DM
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbXKGXDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbXKGXDP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:03:15 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:16358 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbXKGXDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:03:14 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1859462nze
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 15:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kEwjgc5B360fg0MYgzWrRseDLPvWrIU8QcPIaq6XKrE=;
        b=DvBSZ9Dat36YvU+NtPDaZIvmVC8lJ913FWCuIohy6/Ei9vUO/DZIKT5wzZlE3scejb4nDtTmii8qLZCATampm2KRf/3zYPuZ8ppW/WuLUM88/pyu3kZteTTIsEk82JGS10k/+t8+8mNa+jY1bX+Mxk3PDKgmRk0VyS2EG4uRmp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q/twh+QzfM7k4zWouCkQmNq3cxwVxA9SUIiaxl+6eV0yUVnzq0/bln/FLszVvuZmYZRfNavVglPG3I6ZICsmI97n56ttyAw0+ErytHZps0JVHm99E0pKgZFz3uutkKxrrmUfzEtFwTA5aRnurPcAV/blgS1dbamr6kSXwvXCPmU=
Received: by 10.114.209.1 with SMTP id h1mr1784222wag.1194476592693;
        Wed, 07 Nov 2007 15:03:12 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 15:03:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711072255420.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63888>

On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Shouldn't git log default to "git log ."?
>
> Well, it is in line with the other commands being able to work on
> subdirectories, but doing the whole repository operation by default.

I agree with this and see how it got this way.

> We also tend to take the approach of viewing the history as that of
> the whole project.

But if you type 'git log' while cd'd into a subdirectory the whole log
is almost never what you want. It's this kind of thing that makes git
harder to use.

> This approach also means that it is a much more expensive operation to log
> the history as seen by a subdirectory, which is another reason why it is
> not the default.
>
> Hth,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
