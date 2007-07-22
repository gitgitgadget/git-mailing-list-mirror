From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Sun, 22 Jul 2007 15:48:53 -0400
Message-ID: <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707221959100.14781@racer.site>
	 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
	 <Pine.LNX.4.64.0707222013200.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChQH-0001nP-KG
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758425AbXGVTsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759320AbXGVTsy
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:48:54 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:14465 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958AbXGVTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:48:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1737468wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 12:48:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dmz1evl9Y/COQhLEawpFPksSrG06XNj9DGZU7sAgMih1TXZ63IR/S5IjmEz6Cq0/e4ZIA4yONxClT9aDmjOlsU8jgxv5NhKNPlJF/o2weveBLeTd/iPBQZQC0HG2S/xfJVv80nccQwbVPdBHQGCMC8deSXEGa8lgR4mR/WzXVp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdQl7wApDCfbOii6XzV8H1VZl51N4PeSNcP2iRG1V2pakbjLI3Y++I4wpDKNNK2kBLuGgkSz4CEiJeYndp4d1NMBqTMj+myij044dp77kYbUOohI8nevfx0mmXQmBrh8X4/ZUo9Y17+FaXm7S6Ft/yiLPyHcMgcA6FvkYQBaCqI=
Received: by 10.114.195.19 with SMTP id s19mr2333409waf.1185133733344;
        Sun, 22 Jul 2007 12:48:53 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 12:48:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707222013200.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53308>

On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> But still, I think that it would be much better not to put this into Git.
> We do have diff gitattributes now, so that you can roll your own diff for
> specific files, but I still think that this is more a task for a
> standalone perl script.  Possibly being called from filter-branch to be
> done with the conversion once and for all times.

I can provide sample diffs if you want something to play with.

-- 
Jon Smirl
jonsmirl@gmail.com
