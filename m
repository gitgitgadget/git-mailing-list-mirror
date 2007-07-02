From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Mon, 2 Jul 2007 15:58:39 +0200
Message-ID: <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
	 <4688EF9B.8020405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 15:58:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5MQO-0008F7-L7
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 15:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbXGBN6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 09:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbXGBN6l
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 09:58:41 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:12363 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbXGBN6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 09:58:40 -0400
Received: by nz-out-0506.google.com with SMTP id s18so897121nze
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 06:58:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=StTLP93xtT9mpicrhBiwYlbynvgZoPjerdv/M0vSYcE+Jzt5gsQLW05TEXlmdyLvy7sk5FHD+/NTgIIVoBNc9PWFbQeu5DNuM01gFEeGrttgF8Z8GrLamtLBnjB/PqTCfT6J4CsJdS72Lve4F8YNHo9y36IP42QfqgxigYnGxZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OH+DDEdA4xbijpViw/U67Bd6XpUH/o31Zqm2BaLitegCCIGtTe8t9antUyCisK6GVOh3Y+7bNghjg3gmqg7ivrd+uUbW9eXV5cZT3bM8vMW3/GgxAlGpmprZRqe1X8R04ti+LC0o8cycFW4NYWefI8ManeZ+tgUWoZFtnGPpQ2w=
Received: by 10.114.158.1 with SMTP id g1mr5146361wae.1183384719250;
        Mon, 02 Jul 2007 06:58:39 -0700 (PDT)
Received: by 10.114.111.6 with HTTP; Mon, 2 Jul 2007 06:58:39 -0700 (PDT)
In-Reply-To: <4688EF9B.8020405@garzik.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51363>

On 02/07/07, Jeff Garzik <jeff@garzik.org> wrote:
> Robert P. J. Day wrote:
> >   for the umpteenth time, after doing a pull, i see this:
> >
> > $ git diff
> > diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
> > deleted file mode 100644
> > index e69de29..0000000
> > $
>
> I have the same problem.  git 1.5.0.6 on Fedora Core 5 or 6.
>
> I even tried a completely fresh clone, but the problem still appears.
>
I've seen that as well, but in my case doing a
$ git reset --hard master
fixed it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
