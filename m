From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Thu, 27 Aug 2009 13:41:04 -0700
Message-ID: <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
References: <20090827203402.GC7168@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 22:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mglmn-0003XD-3R
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbZH0UlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZH0UlX
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:41:23 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:40702 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbZH0UlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:41:23 -0400
Received: by ey-out-2122.google.com with SMTP id 25so325354eya.19
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ptf4cHKhcgfWUjok1R+7GN7eNnt77hJTqyYqAePWHy4=;
        b=FagvmwR4xdG/ozNOdb/MhYUiphTPhgzhMt27zgeqfJleWNTWliLBCYr2W/JOi46Mnc
         6xj44/JSLEGjNI0G9NBuDXFAUISGpXGd4x/YN6a9+E6Jdd1YHHTA2tVEM1LmPdyNeJaT
         MOKPQLP6tEI66d9mTEP7dXhQJdU56bhQX4NK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=u9r2IdpBrfDTyRJ5NV+Jq8qKjMqbeuaRHlH5srvJ9txdXTU7cLf5ko6FRPR1FqV3pz
         TG1NRMFdcQmP7byv1KWd9dMhBHj2QupSzogbejT8fKA1W/5DwJUnXVpdeH2bN7BaEL2T
         ZrDts4p6+EqJMEGGh8E2A2wvSqsMHkNA60+wg=
Received: by 10.216.55.201 with SMTP id k51mr45443wec.184.1251405684087; Thu, 
	27 Aug 2009 13:41:24 -0700 (PDT)
In-Reply-To: <20090827203402.GC7168@kisimul>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127206>

Heya,

On Thu, Aug 27, 2009 at 13:34, seanh<seanh.nospam@gmail.com> wrote:
> 2. They don't want to look at the latex source but the PDFs built from
> it, which they're going to annotate with their comments. So I need an
> easy way for them to get the PDF of each commit from gitweb without
> having to checkout the repo and build it themselves. Normally I
> wouldn't commit the PDF files into the repo because they're compiled
> files not source files, but it seems that just building a PDF and
> committing it along with each commit to trunk would be by far the
> easiest way to achieve this. But will git store the PDFs efficiently, or
> will the repo start to get really big?

If they only care about the pdf anyway, why not have a separate branch
to which you commit the pdf's instead?

-- 
Cheers,

Sverre Rabbelier
