From: "Parag Warudkar" <parag.warudkar@gmail.com>
Subject: Re: Problem with git-clone
Date: Sat, 21 Apr 2007 22:35:21 -0400
Message-ID: <82e4877d0704211935i396c54c8ld279527039edff40@mail.gmail.com>
References: <loom.20070421T190848-931@post.gmane.org>
	 <20070422011743.GE17480@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 04:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfRvS-0001HY-W7
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 04:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbXDVCfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 22:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbXDVCfX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 22:35:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:39668 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbXDVCfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 22:35:22 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1233518wra
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 19:35:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCsypARNTSd/OZVGe1PpSUNdsf4dPl313fGKJO+W7POP9EsChGAPjSzb029Eluqet4rNmrD40XUCJewL8+I7i6EbMZXEhpD/A+oVhy/83GSWh+ibEOE6Mqktk/ypfgB6ZWQ8PysS+QqcUcUctmjdmNMRzi6egbG0VrjVH+BMPrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B7naLgC1gOs8rNlSdqd03YUtAz0WSTn5gdXT5CLGvAquiR77U8J72eBJzefLIZQavDaVW4ggR9Le2HcyhZv5XKw1VLnQgSZh2PhJrADvWwSb2Xaht5p7vuSNy/tWNnFR7UwisvvUnF2i9IqsW0DL/OmzgNJWZqGd5K/dgC2sjso=
Received: by 10.114.107.19 with SMTP id f19mr1899927wac.1177209321163;
        Sat, 21 Apr 2007 19:35:21 -0700 (PDT)
Received: by 10.114.37.19 with HTTP; Sat, 21 Apr 2007 19:35:21 -0700 (PDT)
In-Reply-To: <20070422011743.GE17480@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45210>

On 4/21/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Are you on Mac OS X?  We found that earlier versions of index-pack on
> that platform ran poorly unless we used pread().  A change was made
> in 1.5.0 to switch to pread for all platforms, which significantly
> improved performance.

Nope, I am on Linux. But I did some more debugging and found that my
router is the culprit - it has ACK errors in the logs and things start
working fine if I switch to another router.

>
> > git --version
> > git version 1.4.4.2
>
> I'd upgrade your Git, the current version is 1.5.1.1.

Yes, on my list.

Thanks
Parag
