From: David Aguilar <davvid@gmail.com>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 02:32:47 -0700
Message-ID: <20100817093246.GB26357@gmail.com>
References: <loom.20100817T054731-955@post.gmane.org>
 <20100817093008.GA26357@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Seth House <seth@eseth.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 11:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIQt-0001Gc-0Q
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233Ab0HQJ0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 05:26:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47673 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab0HQJ0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:26:00 -0400
Received: by pvg2 with SMTP id 2so2281144pvg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0APWYa9wxyAGs6RLdHNzFyGkatqdsepfhWmeshy4cks=;
        b=nvQiYogIP6KYrAR+sZqK+Y/KDPdBPlipOS+NVVUpq6OJP350qsglMfpulwQYXOOtWl
         siucZDnZ+WPfy5dw58E34DxxgkPBlj7kmfXyiwAjRFQRHmjq98fk8VP8BVr61iuCRFdo
         46s5hInnSKJpoYq6XxC2eCwtxX7dlHIVvZX6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gzuiG6uipGdz45w1uixnGpdbhY0FWfZDtNt4w/cc+jm5fXUX4fX91LRurcHUEYnKzV
         IBFUwsl7ZhSphFALr+v7rQEDXoq6Sxy15odawTr3Z+v9DO/fzNBf+JU/K4ZoTF+ZIQ71
         Au/rPDYfZV/HfCzr97nXlOA60xd8MARtPRLbI=
Received: by 10.142.136.1 with SMTP id j1mr5545856wfd.343.1282037160563;
        Tue, 17 Aug 2010 02:26:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v13sm7154395wfv.5.2010.08.17.02.25.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:25:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817093008.GA26357@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153736>

On Tue, Aug 17, 2010 at 02:30:23AM -0700, David Aguilar wrote:
> On Tue, Aug 17, 2010 at 04:34:20AM +0000, Seth House wrote:
> > [...]
> > For small conflicts, I like the conflict markers and simply editing the
> > conflicted file with Vim. For files with lots of conflicts I would like to use
> > vimdiff but I wouldn't expect the conflict markers to appear there -- it's
> > redundant information in a 3-way merge.
> > 
> > Is there a better Git Way (TM) that I'm missing? Is my Git setup borked
> > somehow?
> > 
> > I have the following in my ~/.gitconfig and a stock Git installation on Arch
> > Linux.
> > 
> > [merge]
> >     tool = vimdiff
> 
> 
> What happens if you remove this section?:
> 
> > [mergetool "vimdiff"]
> >     cmd = vimdiff
> >     trustExitCode = true
> 
> mergetool has built-in support for vimdiff.
> You shouldn't need to define mergetool.vimdiff.cmd.

Typo,                          ^^^^^^^^^^^^^^^^^^^^^
Should say:                    mergetool.cmd.vimdiff

-- 

	David
