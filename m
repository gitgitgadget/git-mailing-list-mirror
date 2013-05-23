From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 06:34:38 -0500
Message-ID: <CAMP44s2zR7qYp58M_TqUqRNW24Ap5m5DsH4WWuHD3MiBu2Wg0A@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 23 13:34:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfTnD-0002IV-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 13:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561Ab3EWLek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 07:34:40 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:46473 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758418Ab3EWLek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 07:34:40 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so3056873lab.23
        for <git@vger.kernel.org>; Thu, 23 May 2013 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TH06SvzyIRaFPxjsopeUzcPDVNGk7nsfG8dwgDjZEXk=;
        b=nKxdv49j29FygITdIQcHNG/IkNDRP418tdEHCxUy/C+qUUzvqd2WCIXp1i+PV56U6n
         5cYSOMiPNeFUVco32Ik7Uf5vpS3hJ+OfXpfPt227qoCiLWT7X3mk5venqY+vh/t7zrkt
         3zz8N8JZwq+kxpQGVZ9fBpGI7VN9eaX5ZegRkXo/ZY9iZ9DM1QLCgF4kXpPsUyZVjvuF
         eC4r9tFVxg/lPr8THKaVVS86MCvao1Yyexi5bv3PQghc8IVW9zavZlnj5KmDhvQFSfX1
         ecSq7oZwjGyRDVl1nDshDZZYZdKT/gY/fKCZQeMjhJWyf9sEtJbtL5AAPWKqVj0PuKPT
         Fs4Q==
X-Received: by 10.112.218.102 with SMTP id pf6mr6259855lbc.77.1369308878458;
 Thu, 23 May 2013 04:34:38 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 04:34:38 -0700 (PDT)
In-Reply-To: <20130522115042.GA20649@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225241>

On Wed, May 22, 2013 at 6:50 AM, Andreas Krey <a.krey@gmx.de> wrote:
> Hi everyone,
>
> I'm just looking into better displays of the commit graph (as
> displayed with gitk, smartgit, fisheye) - they tend to quickly
> dissolve into a heap of spaghetti.
>
> We had the idea that treating the first parent specially would
> have some advantage here - including graphically indicating which
> one of the parents of a commit is the first parent. (For instance,
> by letting that line leave the commit node at the top/bottom,
> and the other(s) to the side.)

I don't understand; gitk already shows the first parent starting from
the bottom, and the merge commits arrive from the right side. What am
I missing?

-- 
Felipe Contreras
