From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Branches & directories
Date: Thu, 18 Aug 2011 19:13:01 -0500
Message-ID: <20110819001301.GA32743@elie.gateway.2wire.net>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org>
 <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
 <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 02:13:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCi4-0007m4-BS
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 02:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1HSANL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 20:13:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59124 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1HSANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 20:13:09 -0400
Received: by gya6 with SMTP id 6so1881489gya.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MmP+ft8XcIsvjwMbw9/WsUSSbnx0Gx19Bqrm5AJD2Cg=;
        b=CzyxSGqcYReBoslspN3vT1EvvpCaom8uhGd4xEOEVF70vpl077hcoFB8WB9Z/hSlAQ
         skYOiuJcR4qCTfei9PsEaib/sHbLID13qShmQjMh1rcevMTBnGDVyOFcl3bDzRKsRmP9
         KTZyGwTastZJ4+jY3GCgzrINDWKqMuUFxTL/k=
Received: by 10.236.76.228 with SMTP id b64mr2390999yhe.18.1313712789030;
        Thu, 18 Aug 2011 17:13:09 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.ameritech.net [69.209.48.207])
        by mx.google.com with ESMTPS id j45sm1870770yhe.22.2011.08.18.17.13.06
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 17:13:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179666>

Hi Michael,

Michael Witten wrote:

> As an aside, the problem here is likely a manifestation of the fact
> that nobody understands what a branch is

I agree with Michael J Gruber that this is not the useful kind of
hyperbole.

In olden times, there was more talk of the refs in the refs/heads/
hierarchy as being branch heads which point to the tip of a particular
branch of history.  That is still exactly what they are.  By abuse of
language, people sometimes use the term "branch" as a synonym when
there is little risk of confusion.

If you have found tutorial documentation that is confusing on this
point, by all means, fix it.  You are talking as though a
documentation bug is a fundamental design flaw that cannot be fixed by
the likes of you and me.
