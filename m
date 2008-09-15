From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Diff-tree does not work for initial commit
Date: Mon, 15 Sep 2008 23:11:30 +0200
Message-ID: <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
	 <48CECA42.1050209@drmicha.warpmail.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Anatol Pomozov" <anatol.pomozov@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 23:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfLNa-0002TZ-AL
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 23:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbYIOVLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 17:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbYIOVLd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 17:11:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:8175 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884AbYIOVLc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 17:11:32 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1023425eyi.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C/Us7AfimEW0O6yfbcnCSYpF8xzAMsGzex3y3HVxAhg=;
        b=rDXGmA4HI/OngLOjkLb5v/McWOVcC+9FbvhmKKngeyh8xjFplInk4/0Fj+ZaLzRmXq
         jdpTNhFU3rLP2HTqZgrT/MSbcArv4fDc0+CdRUPuqSLpudj7TZIn+dXEcW9SbNeChQOv
         NaQsPeUgPWhJGEJq04V3t4npM8NkrSLFZ4pqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=OWmHjkfKFgFHlXqkGGijAPEdyCtVO/GeazTRncuRV80N2cLK2udQbz4zggVYwkL2g/
         bDN7VdkbIgJQTNJCFTuNTEQqGvDBf3KKdIB94Yp/S73DSwkfHLC3lx4Z/svKnHzV1Rpl
         8JEtKngSBogN+qC3iijX64g2QTwF+tAYzg2uU=
Received: by 10.187.181.4 with SMTP id i4mr13114fap.54.1221513090109;
        Mon, 15 Sep 2008 14:11:30 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Mon, 15 Sep 2008 14:11:30 -0700 (PDT)
In-Reply-To: <48CECA42.1050209@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95944>

On Mon, Sep 15, 2008 at 22:49, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> diff-tree is plumbing. Would this change break anything?

Some of my code uses "git rev-parse" on "HEAD^" to see if a commit has
a parent; I wouldn't be surprised if someone else has a script that
uses "git diff-tree" or such for that purpose, or at least assumes
that for a root commit it will complain. Anyway, as Junio said, for
"diff-tree" you can use the "--root" option. A better RFE would
perhaps be that "--root" be supported in more places.

-- 
Cheers,

Sverre Rabbelier
