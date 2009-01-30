From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Thu, 29 Jan 2009 20:28:39 -0500
Message-ID: <76718490901291728y2edb0520ie87de783a43c408d@mail.gmail.com>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 02:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSiCt-0000o0-H6
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 02:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435AbZA3B2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 20:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbZA3B2m
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 20:28:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:61760 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZA3B2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 20:28:40 -0500
Received: by rv-out-0506.google.com with SMTP id k40so208191rvb.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 17:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/kI0Yfudd9NNkfeiDHXq3FrAQe9e7UoyPEDVyTmBL4U=;
        b=GgsRUWZ3GLMcW79biAfJiHqwaUCJyPrZCGvqysEWabjnow4kbxOdFQIaWKnxUcJyP1
         T63Ysp/GwF6tnbFeyfb3XhhD+eJwy+bqjrAPR3rxo9526oBSUBHnPmuQWcavCyE5fIEp
         /2KYV70FG31VgtRJ+qtvoTzTWuGt0CPRO3eTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=exlnF5MRktUnLVR/X7frEhAcOKDVpovnalWM/S27p0i96dvnJKL2NAwNRdpACavB2e
         BRZiI8Xt0JjdXeZ0Kr0UuTr/M8hCgk84vKpXF0Q1dWJTx9jirRLXDwdzL1/Tvm8UJe7k
         CZU0JjtdErLzHcWOBzqfFWQO6PcUvhQDHNTvM=
Received: by 10.141.20.6 with SMTP id x6mr306556rvi.40.1233278919752; Thu, 29 
	Jan 2009 17:28:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107761>

On Thu, Jan 29, 2009 at 7:34 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Or, the reason could be that we made a design mistake, and that the
> number of puzzled new users should tell us something.

I happen to have spent some time looking at Mercurial the other day
since I was curious how it's evolved since I last played with it, and
so w/that perspective, I think that git did make a small design
mistake. With mercurial, pull and push are symmetric opposites.
Neither, by default, updates the working copy.

(Confusingly for users of both mercurial and git, the mercurial
equivalent of "git pull" is "hg fetch". Doh.)

Anyway, I think that this may be what leads to confusion. git pull
updates the working copy, and beginners I think expect that push,
which sounds like the opposite of pull, ought do the same thing.

j.
