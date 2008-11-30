From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: how to hide some branches
Date: Sun, 30 Nov 2008 16:16:46 +0100
Message-ID: <81b0412b0811300716q1b973fcex7b54dcc70132a415@mail.gmail.com>
References: <493261C9.4040608@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sun Nov 30 16:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6o5J-0003ys-HP
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 16:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbYK3PQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 10:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbYK3PQt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 10:16:49 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:25715 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYK3PQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 10:16:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2051868rvb.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 07:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IaAvbaF0hEwlu8QvAa85mpPEI5bwJERvTEg0BDRatx0=;
        b=IHZENi+3OnK+amEUfWkzw+IfE7DZ2oYwdooniyZ8Ku72Pp7dIp0hbTT7/t2/jmCE5q
         rbA4P/3FwN/os4DZlpBoek4u8tH9R8haJBRBmHvBPx9BanfP0owX311PCCQGte8AZk1P
         DF6rsKtAIvbJuVtNgJT31ILdPuoCXLHooWTMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xKC63PxQEK2p20pYx+eRSdYO88YaSm3CMVbAkySQeoY8nCOyl4h5z8504FV5QIJtHB
         Yb8JsQU9VdDQHvVWp4HNPgWpzRy8C4whC2/SeWmTlR8nq8lZzDApSJ71K1FQbUOzRlNw
         +nuDKwazRXZRxZAybI9pul4Ep8pP8DmAj8dF0=
Received: by 10.114.137.2 with SMTP id k2mr5819464wad.146.1228058206296;
        Sun, 30 Nov 2008 07:16:46 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Sun, 30 Nov 2008 07:16:46 -0800 (PST)
In-Reply-To: <493261C9.4040608@obry.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101976>

2008/11/30 Pascal Obry <pascal@obry.net>:
> I create a new branch for every new feature/fix I work on. After some
> time I have many (too much) branch listed when doing:
>
>   $ git branch
>
> I'd like to hide some (not removing them).
>
> Is there a solution for this?
>
> How you people handle this?

Rename them into something _not_ under refs/heads:

  git update-ref refs/hidden/branch branch
  git branch -D branch

?
