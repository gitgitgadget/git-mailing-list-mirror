From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Tue, 6 Feb 2007 00:11:26 +0100
Message-ID: <8c5c35580702051511m6d31973bw1f19832afe583487@mail.gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
	 <20070201191323.GA18608@spearce.org>
	 <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net> <epv3r9$4f7$2@sea.gmane.org>
	 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
	 <Pine.LNX.4.63.0702051208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 00:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HECzo-0004CE-A3
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 00:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbXBEXLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 18:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbXBEXLd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 18:11:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26489 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965041AbXBEXLc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 18:11:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1446726uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 15:11:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ebOCfE6QVTIDC175eBF2YY90kQvMrtTi011k+mcB00xxkfblgP3YZ5DnzUBLmMwQ7cIs8scrDDgfVKbII1zd/TOqxwcQZt4aQhV5c2ekaHu+svwBHhx+nJV1Jd1TlKBtQYrjdRqN66enNNI3B27xDpPXqj0UZynn8v82raVzFr4=
Received: by 10.82.187.16 with SMTP id k16mr1432201buf.1170717086111;
        Mon, 05 Feb 2007 15:11:26 -0800 (PST)
Received: by 10.82.158.7 with HTTP; Mon, 5 Feb 2007 15:11:26 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702051208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38798>

On 2/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 2 Feb 2007, Lars Hjemli wrote:
>
> > I think the following makes perfect sense:
> >
> >  "HEAD@{yesterday}" = current branch, yesterday
> >  "@{yesterday}"     = detached head (no branch), yesterday
>
> Okay, so you say "HEAD@{yesterday}" does _not_ give you what HEAD pointed
> to yesterday, but "@{yesterday}" does?
>
> Instead "HEAD@{yesterday}" looks up what HEAD points to _now_, and _then_
> goes back to yesterday, finding out what that particular branch pointed to
> then, _regardless_ what HEAD was then?
>
> Oh my, that's convoluted.
>

Well, luckily Nicolas got me thinking straight again:

  http://article.gmane.org/gmane.comp.version-control.git/38507

-- 
larsh
