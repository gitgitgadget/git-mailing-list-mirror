From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 15:34:00 +0200
Message-ID: <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
References: <20070329075010.GA3493@hermes>
	 <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
	 <20070329125803.GA16739@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 15:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWulU-0002Yn-E7
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 15:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbXC2NeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 09:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbXC2NeE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 09:34:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:47504 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbXC2NeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 09:34:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so221521wra
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 06:34:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KGRZI46mNSaR0B6Z8T56GZ6i/fjMmorEgY7uFMz4fHezhPxUFRilwSZWSUcTJ+xSJEqXeRGqUyhtJafAggJUE6eQtYPwJO7NAg9MtBGe9qR5KB8sy4nnXWJzwD24N3fMugpvo3xhFVyk8vus4KfgpR73VaLY5dAEeJpje3rS6K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sGJkAAdvx6zM5J+Wb9sQ2aUm/1sne/LMkgAKyPK89PPWvT1TUhtbG01vaT/E6yep+W4clc66Y1111LUX8xh9KlEbcc4t0pMJAETMcZ2vzKSgS/svqtUh/L7DZbQGFWlXXjggXkKzWv2VrZnK1lpJIOp9PU8hy6bXylyq6Da9m6U=
Received: by 10.100.142.12 with SMTP id p12mr356080and.1175175240309;
        Thu, 29 Mar 2007 06:34:00 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 29 Mar 2007 06:34:00 -0700 (PDT)
In-Reply-To: <20070329125803.GA16739@hermes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43432>

On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> On Thu, Mar 29, 2007 at 01:29:46PM +0200, Alex Riesen wrote:
> > On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> > >I have been keeping my Maildir in git, a non-trivial merge that causes a
> > >segfault in git-merge-recursive.
> > >
> > >It does not appear to matter which direction I try to merge.
> > >
> >
> > BTW, what git do you have? git --version?
>
> 1.5.1.rc3
>

Did it crash before? If it didn't, is it possible for you to bisect
the commit which caused the problem?
