From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Documentation: Clarify which paths git-clean will
	affect
Date: Tue, 5 May 2009 13:17:07 +0200
Message-ID: <20090505111707.GC1436@vidovic>
References: <20090505091302.GB27900@frsk.net> <200905051155.28985.trast@student.ethz.ch> <20090505100506.GF27900@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Tue May 05 13:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1IeH-0002T8-SN
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 13:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbZEELRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbZEELRN
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 07:17:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:20035 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbZEELRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 07:17:12 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2588868ywb.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=LmFZ7SzLGnJ5PyNdx8CsXy8DcdQUYF4Pc8dNPRvoS1A=;
        b=Lc5Rv9TLcvEXIU3tIxdlLoSiZimFooXL1t4GbGVLvdHzgvpQdQFxvnPNze+vKGUmn1
         9T4WSrQVzuBxtIfylTAmzOIfYIJZ/uNHR66N1euLP5UZzcpl+ty2Qi5kIS1zANl0UWep
         Dg2Vpvou+nxEwN1MyLdzDTrMYoqqZryZs6dSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a74OOTnZPViXpAPD/PCJIun0xt9999wQZxCW2miSCTCvMKk3N/GymT5+Noixnl5tQa
         VcqUAQVQuF0hhUpFqSAvwljhEWUxP09X4hJBv1ak++XOn8dfiBF4hIjCOqPVmdU0GwBI
         y0Zhf0QuSmQmyO56cT2O6PJJw4JihJhofNKsg=
Received: by 10.100.11.3 with SMTP id 3mr15516165ank.102.1241522232181;
        Tue, 05 May 2009 04:17:12 -0700 (PDT)
Received: from @ (91-164-138-252.rev.libertysurf.net [91.164.138.252])
        by mx.google.com with ESMTPS id 2sm12532483aga.58.2009.05.05.04.17.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 04:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090505100506.GF27900@frsk.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118290>

The 05/05/09, Fredrik Skolmli wrote:
> On Tue, May 05, 2009 at 11:55:17AM +0200, Thomas Rast wrote:
> > Fredrik Skolmli wrote:
> > > --- a/Documentation/git-clean.txt
> > > +++ b/Documentation/git-clean.txt
> > > @@ -23,6 +23,9 @@ example, be useful to remove all build products.
> > >  If any optional `<path>...` arguments are given, only those paths
> > >  are affected.
> > >  
> > > +If no arguments are given, the cleaning is recursive, starting at the current
> > > +path.
> > 
> > That makes it sound as if the <path> case was not recursive, but it
> > is!
> 
> Auch, good point. Any suggestions on how to formulate it?

Maybe:

If any optional `<path>...` arguments are given, only those paths are
affected. If no arguments are given, the cleaning starts at the current
path.

The cleaning are recursive.

-- 
Nicolas Sebrecht
