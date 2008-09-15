From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Help using Git(-svn) for specific use case
Date: Mon, 15 Sep 2008 22:59:10 +0200
Message-ID: <bd6139dc0809151359i357987c5vb2544b1b5c99802f@mail.gmail.com>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
	 <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pico Geyer" <picogeyer@gmail.com>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 23:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfLBF-000710-MH
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 23:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbYIOU7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbYIOU7N
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:59:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:30096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbYIOU7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 16:59:13 -0400
Received: by ug-out-1314.google.com with SMTP id k3so894131ugf.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uWhir6RIaMoBv8ZZ9lhFgoDqvLFvO1iNEfC21YHM0aY=;
        b=f8HEW7dWssvLhVA+9CgOeTa+n2Jgev8lBMakyaTeuKwRzpujHQ7N0zMkuqupLs0AHj
         s5RiEJ8zCwQuKUBkr5i4UVRgAkgYNQzbA5DHV+G9LSlBGPs8pyEU0it0CHbA5CVNadXk
         E87odBp38YUlrQ0Zgwvls3Q2z1ZC8qF7Os14s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=b9MPVQJuKPahvFt5w8h24gCXQ5wqEfhZw/OaehP728HQfKCU2yFRuvX9IcWVP63A7d
         8EQjCwE4wI0+uEdHh9TJSCfNfegb2RX25uLGBqAEw6HTAAnsKPpQ818mw3JGt4Xb5TZl
         H7JHZGbhYNfgUlndf2ugX/sUZojxRiCzdl690=
Received: by 10.187.194.7 with SMTP id w7mr9420fap.75.1221512350538;
        Mon, 15 Sep 2008 13:59:10 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Mon, 15 Sep 2008 13:59:10 -0700 (PDT)
In-Reply-To: <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95942>

On Mon, Sep 15, 2008 at 21:55, Dmitry Potapov <dpotapov@gmail.com> wrote:
> [...] Another problem with
> this approach is that the author is not preserved. In SVN, all commits will
> look like all changes are done by the person who run "git svn dcommit".

I thought this was fixed in a more recent version of git-svn? Didn't
it even work both ways?

-- 
Cheers,

Sverre Rabbelier
