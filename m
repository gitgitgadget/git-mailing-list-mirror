From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Really remove a file ?
Date: Thu, 9 Oct 2008 20:56:35 +0200
Message-ID: <81b0412b0810091156v15dea27an95050a06cfb4f8df@mail.gmail.com>
References: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: marcreddist@aim.com
X-From: git-owner@vger.kernel.org Thu Oct 09 20:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko0hp-0002K1-7H
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 20:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbYJIS4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbYJIS4h
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 14:56:37 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:25924 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbYJIS4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 14:56:36 -0400
Received: by hs-out-0708.google.com with SMTP id 4so48459hsl.5
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2z/6sToiwSz3XpELO/+5dNEGTCBDgL3okqwAKBfv5/4=;
        b=NaSr37tmhuJb8+RCOhRvHEgMwaq2d03ahqYRLzVC2SKG/9x0WtQxJmNHXmCJEkKW/z
         +iJWRKGLzmm1BaR3Oc2S5c3iG53YKHf9y96q6U8+y8RA1TDkRmfjEsPUPMIlmrdZIsR6
         ZIaBGvmPnhYunXD04CdGIRq1pVmhicYWCyY3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PLxW7QJTh1zn+6DklhYeVHCNA1ERThqn7pl1o0QNtmaAM9I1ti81b2kYHVxZi+Y/rF
         o+uuzIRd7RU/6Ayt6uuuOLIYBL46r6dChvBWTmm9nGATWkd5qkm7ZvC+QLmu9cHraH1K
         uQXXHVzk05CkYgEqIpD3+qZCJvNgI2EaFi3kk=
Received: by 10.100.212.6 with SMTP id k6mr787220ang.0.1223578595185;
        Thu, 09 Oct 2008 11:56:35 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 9 Oct 2008 11:56:35 -0700 (PDT)
In-Reply-To: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97873>

2008/10/9  <marcreddist@aim.com>:
> So is there a way to really remove a file in the git repository so that it
> never existed (I mean not having the diff in the logs and the data stored
> somewhere in the .git directory) ? Or if it's not the was git is supposed to
> be used, is there a way to hide the diff (even from git-log) or something ?

Yes. But you'll change the whole history (of course, it should _never_
mention the file).
See git filter-branch (there is even an example at the end of its man page.
Replace mv with rm)
