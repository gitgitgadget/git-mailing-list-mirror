From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Wed, 11 Jan 2012 07:18:54 -0600
Message-ID: <20120111131854.GG32173@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino>
 <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 14:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rky0C-0005xo-5N
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 14:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490Ab2AKNN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 08:13:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36313 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab2AKNN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 08:13:58 -0500
Received: by ggdk6 with SMTP id k6so281979ggd.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hmWYqi7kEn5mVbzun99wknlp3U2Z67PwLA2riPRBfas=;
        b=fmGY43sbobVe+ZTA6htCVE8wPE+OfZ+Apzn4lJCNFnRK5xMxpo4owy2JQTkxJbRXP/
         Rgf1IMsIjStkQ+2OalnI/txlSl34bM1lkUhZbfw8/LGAd6ejz9usXxMm9EoGyYTiPPhO
         aBg3h9NYpws/TmralJs0HxZqwh1pfgw36OiM0=
Received: by 10.50.160.201 with SMTP id xm9mr7271143igb.16.1326287637926;
        Wed, 11 Jan 2012 05:13:57 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gh7sm2781393igb.1.2012.01.11.05.13.57
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 05:13:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188364>

Ramkumar Ramachandra wrote:

>                                                             Once the
> painful move to sequencer.c is completed, we can think about all these
> things.

Honestly, moving code verbatim between files is very easy.  Repeatedly
rebasing a patch that carries out such a move would presumably be
hard, though.  But this pain is unnecessary!

Just like I haven't been reviewing the code movement, I'd be perfectly
happy to read a "patch" that says

	"And then we move the functions from the following list to
	sequencer.c.  I'll send a patch doing so once work has settled
	down in patches earlier in this series."

Now you are telling me that in the super-final future my worries are
valid, but I should forget about them today, because later in this
series there is some code movement.  That we need to get this painful
part over with.  I would be much more comforted if you said that in
the future my worries were _not_ valid, that the current design is a
good one, and that these patches are not making the program worse;
otherwise, wouldn't it be better to skip whichever are the
questionable patches and just carry out the code movement, which
doesn't depend on them?
