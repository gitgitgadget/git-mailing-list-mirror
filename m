From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: ghost refs
Date: Wed, 7 Apr 2010 18:03:06 -0400
Message-ID: <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com> 
	<r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com> 
	<20100407210010.GB27012@coredump.intra.peff.net> <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:03:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzdLR-00033c-Hg
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab0DGWD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 18:03:28 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44549 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab0DGWD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 18:03:27 -0400
Received: by gxk9 with SMTP id 9so899350gxk.8
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=QUcqUWNuxidDX1+CIcUKYHYEIkBbCN5+klrz/vOAQoE=;
        b=OTO8NKMhnjStK9v+yoJzs2P3OFFC+xTcIH4dwJ7lz3FwOSSvfDnvSxrj9OJcr2LEZ3
         D/KsyWnv0aI1IKV4qq1O9Xj59uemTeTerJ4swdq0Z6HFLNcf49xsp9Rz+iUbanHe+NDE
         21vJpBJhI5YsOJqDyZ3KCqw+IkOlvCcel7WIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=peIWrK+g8vKSgSxTUnCZ/JfZP4t7YNglmn9pIwNAR9Rsl7RzWOVx21hHD1IAQH5fp/
         NLX9g2tQuxvg9fWL/FFAFs1zhh/zSQU1DVvYq4Opt1B3Bz4u4/D7IG2MlP14IHntcN8a
         Q4XkqsHAB22hFDjrE0bMUQaPHGZdTYOUX9C6o=
Received: by 10.150.150.20 with HTTP; Wed, 7 Apr 2010 15:03:06 -0700 (PDT)
In-Reply-To: <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
Received: by 10.150.207.5 with SMTP id e5mr5583804ybg.249.1270677806239; Wed, 
	07 Apr 2010 15:03:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144288>

On Wed, Apr 7, 2010 at 6:00 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:
>> You do have a reflog in the case of overwrite. Delete kills off any
>> associated reflog (it would be cool if we had a "graveyard" reflog
>> that kept deleted branch reflogs around for a while).
>
> Hmm, I thought you only had reflogs on your local branches, not the remote branches.

This used to be true, but I have confirmed that with the latest
version of git, remote refs have reflogs (as they should for safety).

Have fun,

Avery
