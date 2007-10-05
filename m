From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Many gits are offline this week
Date: Fri, 5 Oct 2007 18:41:43 +0400
Message-ID: <37fcd2780710050741x1760a585yeaa9023a8d8cdccf@mail.gmail.com>
References: <20071005010448.GQ2137@spearce.org>
	 <863awq5p1y.fsf@blue.stonehenge.com>
	 <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com>
	 <86tzp54sez.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 16:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdoNO-0000ZW-T9
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 16:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762533AbXJEOlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 10:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762373AbXJEOlr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 10:41:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:17173 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761723AbXJEOlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 10:41:46 -0400
Received: by wr-out-0506.google.com with SMTP id 36so389978wra
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2nhUjhuYyHgxDAtyiB8zE79y6zW81uYLGGSfoiShYFw=;
        b=oXEEtw6L6Gh30mGvwpngX39+jDWdDH4N8z0QUqk8Tg/KNDbi3Ffqh7iK3j6l1h8Gd6tRA82n6ePJ8N5W8DF1eOEws2ht/95da0eIgqW+b4HOLJYbjApKmikqlBg/nEPQeNySu8wZDu5z8B3o6OUkHpb0PeE0Z+izvOeXrQBculU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PCjsDANI2psRaBM744vgiyZ1fyZp9afpgBxfcYg9QvGxGCyK+Ig8IB9/ziT+FjjfmL8UMMKpnxli5umu+TYUsNpX+prAcBU+srSgwaUBocw4d/RL/lKsGPZ6ZhYxVeVsTSYJG9fHA75tR2vo0Lio+vKfR5gqnEAPKc2zIwlm9go=
Received: by 10.143.17.13 with SMTP id u13mr1748919wfi.1191595304299;
        Fri, 05 Oct 2007 07:41:44 -0700 (PDT)
Received: by 10.143.37.15 with HTTP; Fri, 5 Oct 2007 07:41:43 -0700 (PDT)
In-Reply-To: <86tzp54sez.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60088>

Hi Randal,

> I've had the slides reviewed by Smarter People Than Me on #git already, so
> hopefully most of it is accurate. :)  They're temporarily at
>
>   http://www.stonehenge.com/pic/Git-2.0.3-to-be.pdf

I believe I have found one mistake in your slides. Slide 18 reads:
"git-commit -a" is like "git-add .; git-commit"

But it is incorrect, because "git-commit -a" does not add new files, so
it works like "git-add -u .; git-commit".

Dmitry
