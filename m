From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 13:22:19 -0500
Message-ID: <32541b131003051022oe64428bsa387e64e30bbeaab@mail.gmail.com>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com> 
	<alpine.DEB.1.00.1003050953580.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: walt <w41ter@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 05 19:23:11 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NncAl-0003kn-0V
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 19:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257Ab0CESWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 13:22:45 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54546 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab0CESWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 13:22:44 -0500
Received: by gyg10 with SMTP id 10so20178gyg.19
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4c10wxUkIE+0Zi6vehSC8WA3qRxYW6SXEvvVGtW0mM8=;
        b=oEtd56+akfFqqd4/RZBYLgWIL6+WneotEVNITMhiox+1KmxWp8Ec2oEjGvD30Fi17N
         04vVvRMUHRK0Y7gINbpqz5XvDosxzZu6dAhyBCG7k9nVSKhubBFOsu8lcJFyxzvrIW3Z
         ohQr/Qdn93Cxtbq6fUVczicfdRY7q7cf3AAAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=c8U14tsdkaGLLtin2+HXl+4D2ghE0QbCh+cwZOvKuApOyXDnNEHAYfiLEzZDMkB/GX
         IggYiPnUNVMDUYFEl7TM1srQbBDFlihga9QDxEXhJxP3v7iHxibd8Sni8QxNLx4UzMCU
         +HjEjeC/S3L49qhieZWYOFmBPmye0XbyavU7M=
Received: by 10.150.127.24 with SMTP id z24mr1428253ybc.92.1267813359117; Fri, 
	05 Mar 2010 10:22:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1003050953580.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141593>

On Fri, Mar 5, 2010 at 4:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The trick now is to craft the commit in such a manner that it will not be
> noticed retro-actively. This is a simple case of social engineering: you
> have to imitate the style of the committer/author you are impersonating.
> The commit message must look like the usual ones (typos, preferred words,
> grammar, length of paragraphs, comprehensibility, etc)
>
> Likewise, the code has to be analyzed for style, and obviously for most
> likely targets of a backdoor (both in terms of "it is a perfect spot for
> a backdoor" and "it is not uncommon for the author to touch that
> part of the code").

There is still one major advantage to preventing modification of past
commits: once you find out there's been a breach, you can just go back
through the commits *since* the breach and double-check them.  Without
that guarantee, you have to recheck *every* commit, which is much more
work.

Not to say that a sneaky commit would be easy to detect, though.  I
often add bugs to my own code without even trying to hide them, and
they're still pretty hard to find afterward.

Have fun,

Avery
