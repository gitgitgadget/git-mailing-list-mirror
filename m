From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH/RFC] Pro-Git thanks, Control-flow bug report
Date: Mon, 25 Jul 2011 21:39:41 +0200
Message-ID: <20110725193941.GA95001@sherwood.local>
References: <20110725125037.GA24198@sherwood.local>
 <20110725162548.GA7071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 21:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlR0P-0003fW-4s
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 21:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1GYTjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 15:39:53 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:48843 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1GYTjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 15:39:51 -0400
Received: by fxd18 with SMTP id 18so9461864fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1NY8IbBrO6txZ421E3VTEhCzHrUU2WGOC6ysO3nkl/I=;
        b=leHg1yCModOwcmb7wAbqoxSI6BtdC1liHlGi/xobrqP43y7elk3JVA+My9nv9DNTlj
         MIqNiQvsPutdklusJDTUTqoOlv4ERTfPdLjULGQ3BrhpITcaT3GU70B6qkJgZE5xzsz9
         UB6uIqxFTU40HqnUGuV+sGaix0nVaRiF/etPM=
Received: by 10.223.94.78 with SMTP id y14mr7250161fam.24.1311622790380;
        Mon, 25 Jul 2011 12:39:50 -0700 (PDT)
Received: from sherwood.local ([89.204.137.190])
        by mx.google.com with ESMTPS id n18sm2951071fam.31.2011.07.25.12.39.47
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 12:39:49 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110725162548.GA7071@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177810>

@ Jeff King <peff@peff.net> wrote (2011-07-25 18:25+0200):
> Hmm. What's old is new again, I guess. I posted a patch to fix this
> almost exactly 3 years ago:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/90427

Unfortunately your patch from then seems no longer be sufficient
(i.e., from my point of view, say), since this is also coloured:

  ?0%0[steffen@sherwood git.git]$ ./git -c color.ui=auto -c color.pager=false log

>..> It's an ordering problem. [.]
>..> However, breaking the dependency chain would require some pretty
>..> major surgery, I think. [.]
>..> I think the "right" solution would be refactoring the color stuff
>..> to make the decision closer to the point of use. [.]

> A more elegant solution would be to push the query to color.c to
> happen at the time of color use, instead of during the startup
> sequence.

Beginners luck.  In the end git(1) will get a visual.c output
manager, and sideband.c rid of that TERM pollution.  :-)

--Steffen
Ciao, sdaoden(*)(gmail.com)
ASCII ribbon campaign           ( ) More nuclear fission plants
  against HTML e-mail            X    can serve more coloured
    and proprietary attachments / \     and sounding animations
