From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [MinGW PATCH] git clone was failing with 'invalid object name HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 14:51:59 -0700
Message-ID: <a1bbc6950708061451o28272201w1713d8b8adfc695f@mail.gmail.com>
References: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708061134380.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIAUh-0006vw-Ey
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 23:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXHFVwC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 17:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755719AbXHFVwB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 17:52:01 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:26847 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbXHFVwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 17:52:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1232708rvb
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 14:52:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ojyd9lgBBjVgub2FgzdVfrj91NgqNdEQmw5dQ6GpKenayetMBLmt+aGex8fNU2IELBrUOTbSMOiMPfYFw6V0mxdRmF2sbVcsJknyZFYBZ/uoDcfcl2faqnA1XViTSOY+uWiYttX9uWkO/RkBaopJlHGbGVAS9LMCl0in+76sXME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YlXi52S1sPnAAvdjHwTzvzj550GbygP4Qygv6Agcrhlld0xTaZLnEf9zMexv9bgPLHL5lOfOztXiiLtiKb6jl/qsNXLAniZBZ8UkYNomYHadPcJTCzwyNgOrQtK11Sk9GkFfkPhMUM07oOt4EKXm8M4K4iMQlLR7bRBUqrGsU/c=
Received: by 10.141.63.20 with SMTP id q20mr2268357rvk.1186437120000;
        Mon, 06 Aug 2007 14:52:00 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Mon, 6 Aug 2007 14:51:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708061134380.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55173>

On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> long time (mainly because its maintainer is on holiday).  In the meantime,
> set_git_dir() is already there!

I didn't know that.

> BTW your patch was white-space mangled.

I'll be sending patches as attachments from now on.

- Dmitry
