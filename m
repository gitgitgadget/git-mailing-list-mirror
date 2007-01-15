From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-remote exclude
Date: Mon, 15 Jan 2007 11:55:23 +0000
Message-ID: <200701151155.26111.andyparkins@gmail.com>
References: <45AA44D6.6080605@gmail.com> <Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Quy Tonthat <qtonthat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 15 20:32:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2R-0000Tc-JA
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:31 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9q-0003eK-S8
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbXAOLzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 06:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAOLzd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 06:55:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbXAOLzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 06:55:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1328960uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 03:55:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EFi6P7csErBlzV/VRq1M6gP75/DpIYw6rAmT32ajG6NmKomMLbJq/6mIAUk0ptSQdvB4hL42E8tn3wOPyfCKqe0qfVtGIKjUF38uXWECb/xSuwQIt3FZOLmrnJU10s+MPjDp2DiDZ2LFZ6dl7C4SKT94SopIAMx0Z/jLhuwSnu4=
Received: by 10.67.99.1 with SMTP id b1mr5292938ugm.1168862131079;
        Mon, 15 Jan 2007 03:55:31 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm5479933ugc.2007.01.15.03.55.29;
        Mon, 15 Jan 2007 03:55:29 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36874>

On Monday 2007 January 15 10:23, Johannes Schindelin wrote:

> But then, I don't really see _why_ you would want such a solution. After
> all, you are more likely to be interested in _specific_ branches, rather
> than all branches _except_ a few.

That's not true.  I have a patch (that doesn't work, so it's not submitted), 
that would allow me to have:

[remote "origin"]
    url = git://git2.kernel.org/pub/scm/git/git.git
    fetch = refs/heads/*:refs/remotes/up/*
    fetch = !refs/heads/html
    fetch = !refs/heads/todo

i.e. I don't want those two branches, but I do want everything else.  I'd also 
like to be able to do "!/refs/heads/temp/*" so I could block a whole 
subdirectory of branches.  I have a feeling that this would come in handy for 
people like the person who was recently talking about having 880 branches in 
his repository, with only a few active.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
