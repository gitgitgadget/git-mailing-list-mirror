From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 11:37:08 +0200
Message-ID: <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
	 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:38:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0Qv-0003te-MT
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYH2JhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753922AbYH2JhM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:37:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:13387 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYH2JhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:37:10 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1297481ugf.37
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=A7gV/9OlZmf7cVyB+OJWgBvZ8+p7ovJuFuhUtBB6J0s=;
        b=oJnxCXd62TQsTuauxl4Ftw/xJzT6GZcHNIDQeS1EwqNVyuQemI5LbsUHWYnVZTtTKZ
         e1jp91bh2h/q+oCwXKWVth9BgaU33P6kl5ldoVtnt9vmhPD8r2tKdIT0ip4brrjR6aVv
         +T6F59W/FYJQA30V/JuGk42qRrj2Bqo/OQFRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VjfubNwr3d2dwBjGzvMkhnCSUAYt2InC8hqkgJaFts8ADuZ2D2kmsLPF6Uk7CfWft5
         1QBxfTSXDr8YJ7c/9bYttdpsz4W27lI2sNkB7qFuCIiL5qy+6RSTCwK3dOfd/006a9RE
         +jNWv0ETwoerQtVb82ksJ7Q3SP4P8Ji7EZaW4=
Received: by 10.66.222.6 with SMTP id u6mr4402485ugg.21.1220002628725;
        Fri, 29 Aug 2008 02:37:08 -0700 (PDT)
Received: by 10.67.22.17 with HTTP; Fri, 29 Aug 2008 02:37:08 -0700 (PDT)
In-Reply-To: <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 29, 2008 at 11:27 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> $ rm .git/HEAD
> $ echo ref: refs/heads/NEW-BRANCH-NAME > .git/HEAD
> $ git commit
>

well, it looks pretty git internal hack thing to me.

Shouldn't we add a new option to git-branch to do that, like:

    $ git branch --detach <new-branch>

?
-- 
Francis
