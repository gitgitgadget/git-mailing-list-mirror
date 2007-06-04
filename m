From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Mon, 4 Jun 2007 09:21:54 +0100
Message-ID: <200706040921.55861.andyparkins@gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 10:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7pW-00062l-Cy
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbXFDIWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbXFDIWG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:22:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbXFDIWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:22:03 -0400
Received: by ug-out-1314.google.com with SMTP id j3so686232ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 01:22:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DG87x36o3R5B0MkzQQ2cMZQHPJ5SlJwi5s+D/YCC4m7qJGT8jDkEdYDje0Xl0QoTRr0UwHTdF/2Lc1d/dAZMpQGXZkI6Zlait/myn3tzQKfSUuNADc/mDyZyJV/wp1Rf49zUBbTMcs8fF3ygnINlLAIASDQiebFUMFEirXSpuX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nZZnPcaXgWKUBrnVF+h13QoVyn/ZSR74NhEAnsjiGTAAKtSxnb2xjimVMGlMDP+wPDcdr8teK0OtavZG3delBQfrpOjdo4x2ekwCu9Q4r0oi/iHA2jjIyykP4ftp1s+zh3yUzsKC2pQUAtCjod2wW9SXLX2SYQfGrSP/YQBZHSU=
Received: by 10.67.19.13 with SMTP id w13mr2975339ugi.1180945321570;
        Mon, 04 Jun 2007 01:22:01 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm233299ika.2007.06.04.01.22.00;
        Mon, 04 Jun 2007 01:22:01 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49081>

On Sunday 2007 June 03, Marco Costalba wrote:

> Care has been taken to allow the wheel browsing experience to be as
> natural as possible, in particular a way to avoid to switch when user
> just wants to scroll has been implemented. Also, getting a responsive
> scroll and switch command avoiding false positives was not immediate.

I'm really sorry to say it Marco, but it's really disturbing.  You've 
obviously made great efforts to make it useable, but it just isn't.  The 
scroll wheel behaviour being inconsistent is just annoying.  Sometimes 
scrolling works, sometimes it doesn't, sometimes it switches content, 
sometimes it doesn't.  It's obviously based on timeouts for the different 
functions, but that just means that I have no idea what a particular 
operation will do at any given time.

I'm not sure I like the labels with arrows either; and the fonts changing size 
and visibility is inconsistent and discomfiting.

On the plus side - I do like the idea of being able to perform these 
operations; jumping from revision to revision, or from log to patch is nice.  
However, I think it is unwise to invent a new graphical metaphor for an 
operation that already exists - the tabbed widget.  Similarly, the up and 
down are obvious candidates for toolbar buttons - an already established 
visual.

So - I think that the non-standard methods should be dropped (sorry); and be 
replaced with tabs for the patch/log switch and toolbar buttons for the 
up/down.  Also, the scroll-to-switch, while an interesting idea, gives 
unpredictable behaviour and so is uncomfortable to use.

Sorry for being so negative; it's a shame after your obvious hard work.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
