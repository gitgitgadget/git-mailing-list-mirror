From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Git Documentation
Date: Tue, 22 Jul 2008 11:47:38 -0400
Message-ID: <76718490807220847i298f256bm4c3f85bfde079ee2@mail.gmail.com>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>
	 <200807220917.57363.johan@herland.net>
	 <alpine.DEB.1.10.0807220035110.1125@asgard.lang.hm>
	 <200807221121.22520.johan@herland.net>
	 <alpine.DEB.1.00.0807221335560.3391@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, david@lang.hm,
	"Scott Chacon" <schacon@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 17:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLK6S-0002Ve-QG
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 17:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbYGVPrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbYGVPrk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 11:47:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:23777 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbYGVPrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 11:47:40 -0400
Received: by yx-out-2324.google.com with SMTP id 8so340279yxm.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8NiFj+hKr864hlcxGPxenu2zaVkZ5L8mDIhiR7gcqIc=;
        b=mVYx0VAVSYP6AZZLNIDwDVKU9+HQYSig6C/tgqG+IGrY3p6NukPdHklXf0LlfOraFw
         eofDFhpj+nZXLyhPC+2w2D4a7sYv5Ajrz65kokoBKbOeZVUoGPOakovRe6rgJlgcXXUb
         9cH380dDnaCadrns7SD45sY9ELVn4S77EwITc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kqc77Y0i7Z6npGcpth7bkRhXQfUxPu6lgtoCJra2DftKDJch2AJdHbE2EwfITvsCbb
         W9KP/1nfLamW44HeuR/MEBLkBv/41ZFj+/h5XOGLUQttwxRHvHuspmvkraKInftBHSce
         5YJ0ULBqqtjsNOuISGGX/GLa/K0S2LaGLIS9s=
Received: by 10.150.133.17 with SMTP id g17mr5631527ybd.196.1216741658748;
        Tue, 22 Jul 2008 08:47:38 -0700 (PDT)
Received: by 10.150.50.2 with HTTP; Tue, 22 Jul 2008 08:47:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807221335560.3391@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89491>

On Tue, Jul 22, 2008 at 7:40 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Most people hate to know the internals.  They buy the car, and never want
> to look inside the motor compartment.  They buy wine, and never want to
> know how it is made.  They buy an iPod and never want to know who
> assembles it, and how, and in what environment.

I agree with this. And I like the top-down approach. Nonetheless, I
think there are a few git concepts that are important to understand.
Specifically, I don't think you can use git without understanding
the index.

Unfortunately, git isn't quite as good about abstractions yet as
some of the items you make analogies to. And even car's leak:

   "And you can't drive as fast when it's raining, even though your
   car has windshield wipers and headlights and a roof and a heater,
   all of which protect you from caring about the fact that it's
   raining (they abstract away the weather), but lo, you have to
   worry about hydroplaning (or aquaplaning in England) and
   sometimes the rain is so strong you can't see very far ahead so
   you go slower in the rain, because the weather can never be
   completely abstracted away, because of the law of leaky
   abstractions."

   http://www.joelonsoftware.com/articles/LeakyAbstractions.html

:-)

j.
