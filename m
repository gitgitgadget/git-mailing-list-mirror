From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 0/2] add support for per branch merge policy
Date: Thu, 20 Sep 2007 15:38:48 +0200
Message-ID: <8c5c35580709200638v75fcf611m7c6465d074c9244d@mail.gmail.com>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
	 <8c5c35580709200607s428e898ay32fd4cdad30f096e@mail.gmail.com>
	 <Pine.LNX.4.64.0709201424270.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 15:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYMF6-000397-CE
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 15:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbXITNiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 09:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbXITNiu
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 09:38:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:23525 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbXITNiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 09:38:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so612220wah
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ARvMiaABAC4TrRKu4Yp1vaBDi+TVYznc+tVwlBbYgR0=;
        b=EebzTyRNR4lvXUFqp1M7Sd0Q1mXjW8dPUQv4KzcSBXBisCFWKUV1/C6O6yxWfN3eM442a5OioL5LrIqDUEJJGi+BUPQErJRE6KvvorL0njsQ9fjOGtiRvEQQypkbl5ir7aqfFbt0FlC1YUXIV9qCRhi9oBnSVZHOElPTRORA4qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DE6I2+UMcHjk/K5xRW0zwuA/824Ky4kdz2bzwbP3/BlWtZlqUs2V8haKUb7gJYF9RbFDm755ZFOYETfXRalo80dgisTrVvXSrMKB2D1PxuFUNOPeenocG/+G6GlRWql+CPeWU4vQzJONLVos3X0Errl6NMKI1nQtDf6Ko380avM=
Received: by 10.115.110.6 with SMTP id n6mr2133020wam.1190295529031;
        Thu, 20 Sep 2007 06:38:49 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 20 Sep 2007 06:38:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709201424270.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58780>

[...joining two posts in one...]

On 9/20/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On 9/20/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > > branch.<name>.integrationonly
> >
> > Btw: we might want to call this 'branch.<name>.mergepolicy' with the
> > possible values 'synchronize' and 'integrate'.
>
> IMHO this is way too limiting.
> Why not have something like branch.<name>.mergeOptions instead?

Yeah, that would be more powerful, I'll give it a try.

--
larsh
