From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk: Fix warning when removing a branch (take 2)
Date: Thu, 16 Aug 2007 07:46:46 -0400
Message-ID: <30e4a070708160446v5bdd177cn81553f5365b06460@mail.gmail.com>
References: <11872265153600-git-send-email-mdl123@verizon.net>
	 <18115.44826.758536.30810@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mdl123@verizon.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 13:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILdoZ-0005PZ-Dx
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 13:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXHPLqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 07:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXHPLqs
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 07:46:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:29184 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXHPLqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 07:46:47 -0400
Received: by nz-out-0506.google.com with SMTP id s18so76323nze
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 04:46:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oolzv3VcnMfegJ1qa4XPnndRUQZyBuHe/kjI5EothOwWIKEAhmG4F8OEtEUloBsXcShDISr5H6uHB2b2KuJI1mOkWxC/c6GsxnsCBp0O8/sRHF0x9WdHi2YpBq/WdoKLwWeHEJq3YTEq+woypZQUV6YvLcCzFwP4Mu/zHPh9BqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=STnaQP7jOGA2SIjA0RXwPs9aXoxiyM1QZGxYhr/7pppbURptb6lyIufth9Lc2n4np5P5fJJgDCQpInL2QHH0t/wwaHMTk1K75+Wk/6/8GihKm0yVAgvdq0xzZWe+Tm36GgnrQOi+IRg4MP8arjd/H3A4jebo02IeXSNi6XtONHY=
Received: by 10.142.177.7 with SMTP id z7mr84620wfe.1187264806353;
        Thu, 16 Aug 2007 04:46:46 -0700 (PDT)
Received: by 10.143.156.1 with HTTP; Thu, 16 Aug 2007 04:46:46 -0700 (PDT)
In-Reply-To: <18115.44826.758536.30810@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56007>

On 8/15/07, Paul Mackerras <paulus@samba.org> wrote:
> Mark Levedahl writes:
>
>
> Yeah, I missed that case.  Sorry.
>
> >     while executing
> > "if {$idheads($dheads) eq $head} {
>
> I think
>
>         if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
>
> should be what we want.  Could you try that?
>
> Paul.

That works. Thanks.

Mark
