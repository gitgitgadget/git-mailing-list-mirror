From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: how optparse can go horribly wrong
Date: Sat, 26 Sep 2009 15:44:01 +0200
Message-ID: <fabb9a1e0909260644w781d3c3h4fca22e3b7d97768@mail.gmail.com>
References: <20090925233226.GC14660@spearce.org> <20090926015127.GA12994@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Sep 26 15:44:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrXZe-0003Dw-Lj
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 15:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZIZNoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 09:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbZIZNoU
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 09:44:20 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:38133 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZIZNoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 09:44:19 -0400
Received: by ewy7 with SMTP id 7so3265307ewy.17
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=zj7cnBuhT25o1KMpjXKZ0ITnFJnpsnvT7+qmzeOLBmw=;
        b=pARe3nP/shNfbodKKC14H/pHKOH5fUVF8enZaEjZuQvKUhY71+0yezuSXNcTKq3s6f
         AWW5PekXV5JsaK5r2Ux4W+uYO1BScNenfreP8YXK7xQ6m2mHp6ZJ1RFbqB6nvtSPsBwx
         NmurwlL2DDjoaFtW/r4vMkpv6+qa9WgBoO1b0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=djnftwCtQLxs6Yd6EyFXEWh5e2eD6GiDu8UiyRzS6y17icoWf4OEUcqbQlrJ/Mbo9K
         HlJFYCVZDeOab067un6ZB5MRuxslUaQ658+Rr4GFpdRSi/cvej0uHZzytC3WOLBcguBK
         yIAtagZEpfWJVfdt3/erjn/rYOe3XQhb8SqBQ=
Received: by 10.216.20.210 with SMTP id p60mr265093wep.92.1253972662604; Sat, 
	26 Sep 2009 06:44:22 -0700 (PDT)
In-Reply-To: <20090926015127.GA12994@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129155>

Heya,

On Sat, Sep 26, 2009 at 03:51, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> Doing this only to -m flag would break consistency. That said, I don't
> have any opinion in disallowing the sticked form for _all_ short
> options.

Perhaps instead disallow it for short options that do not take a
one-symbol argument, that is -n4 makes a lot of sense to me, but -m"my
commit message here" not so much.


-- 
Cheers,

Sverre Rabbelier
