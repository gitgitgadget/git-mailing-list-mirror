From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Sat, 3 Nov 2007 00:26:32 +1100
Message-ID: <ee77f5c20711020626s2ec21f1p68f7602dedfdb33a@mail.gmail.com>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com>
	 <472AFFE4.9060004@op5.se>
	 <ee77f5c20711020450hdfe064fsace9349fe6494ec9@mail.gmail.com>
	 <fgf4qu$e8c$1@ger.gmane.org>
	 <ee77f5c20711020553x1a329fa5g90f38d5b8c1a062e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:26:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InwXy-0001JV-De
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbXKBN0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 09:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbXKBN0e
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:26:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:11211 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbXKBN0e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 09:26:34 -0400
Received: by nz-out-0506.google.com with SMTP id s18so659027nze
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3nUTZFuKbDOJQKmilrcvg+m19QXxHadWQam3dVFT1wo=;
        b=Rf+2O+Y2AFV25VABM3OP8Nh44bzzRHuHkoYgrWklrExqzSPgryTvGxTes1MbmcxFTsdIhEM2bVwBJ3BvAc6ffPP9bAnSUAwNzl87p+GL4d6H/DDlid2fXZCOTLJ3Q528wisTcel03mcu6td62IVeIckKU7MlSHyr40zFbVHOzTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xz/27tWFT8WEIxxJ5RYVMm7ASqN6jQwI4rCW8GaSU6c3CjXyuXp/MHPeObgs0Bm3nNCz09ERjX2e4jAOH54eOwpPIdlVLk3bC8GXUwQH6oxI6O4P1Ia28QIWw46h6BeRY/bxd4lUlcZ9qsodiq2ZHyEhP8ANLgDVc2DxpY3s/NM=
Received: by 10.141.169.9 with SMTP id w9mr861623rvo.1194009992623;
        Fri, 02 Nov 2007 06:26:32 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 06:26:32 -0700 (PDT)
In-Reply-To: <ee77f5c20711020553x1a329fa5g90f38d5b8c1a062e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63116>

On 11/2/07, David Symonds <dsymonds@gmail.com> wrote:
> On 11/2/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > Nice idea, but the syntax is
> >
> > [core "whitespace"]
> >         trailing = error
> >         space-before-tab = error
> >         indent-with-space = warn
>
> Whoops, of course. My brain is a bit muddled tonight.

Okay, I've put my money where my mouth is, and coded up an equivalent
to Junio's patch from the start of this thread. I'll send it through
in a couple of minutes.


Dave.
