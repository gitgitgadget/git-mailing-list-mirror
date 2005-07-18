From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Barebone Porcelain.  Where to stop?
Date: Mon, 18 Jul 2005 00:41:21 -0400
Message-ID: <42DB32F1.5020900@gmail.com>
References: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 06:41:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuNRb-0006rW-PM
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 06:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVGRElY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 00:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVGRElY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 00:41:24 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:11632 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261371AbVGRElX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 00:41:23 -0400
Received: by zproxy.gmail.com with SMTP id 14so800631nzn
        for <git@vger.kernel.org>; Sun, 17 Jul 2005 21:41:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qgIYLVAz0dwW80kGMmSLJXERaEDfsTUGz/zjI7p6/T5m5sJoqfGJAhxlTKBtFX27W+ujiUeK/kKdqUHhEMo3gWiFx/gQoy0dzNGCYM9g2qLqdg1oyko28NdehoaVjcA+KGu1TuQa/lxMCHJ47G+xIveAUo4tMR3hEEY332MfpeA=
Received: by 10.36.36.15 with SMTP id j15mr3085043nzj;
        Sun, 17 Jul 2005 21:41:22 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 20sm5743253nzp.2005.07.17.21.41.22;
        Sun, 17 Jul 2005 21:41:22 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> I have been somewhat disturbed and confused by the fact that the
> line between what Porcelain like Cogito does and what we ship as
> part of "core GIT" is getting more and more blurred.  This was
> especially so while I was working on the $GIT_DIR/branches/
> patch.

I have also been disturbed.  But I am gratified that such a core git 
personage shares my concern.   This is enough from a technical point of 
view, at least for me.

Any lack of porcelain momentum is probably due to git having better 
documentation than the current porcelains, such as cogito and stacked 
git.  The documentation, like tutorial.txt and Jeff Garzik's git kernel 
howto give the impression that most kernel folks use git instead of cogito.

I personally think that the cogito interface and stacked git interfaces 
are much nicer than git's, and would like to see these two tools achieve 
some momentum.

Another way of encouraging porcelain is by helping Pasky and Catalin 
out.  Myself, I have been sending corresponding patches for Cogito  and 
Stacked when making changes to git.  This is purely selfish: I use both 
of these porcelains, but if it became general practice, we'd probably 
see less breakage.

Bryan
