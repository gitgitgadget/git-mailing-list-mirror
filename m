From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 22:50:49 +0000
Message-ID: <b0943d9e0803241550k3ef0dbe8nae3b00bac34fa20@mail.gmail.com>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
	 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
	 <47E81037.5030808@keyaccess.nl>
	 <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
	 <47E82BDD.9060507@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Josef Sipek" <jsipek@fsl.cs.sunysb.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Rene Herman" <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvVr-000319-WF
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYCXWux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbYCXWuw
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:50:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:53838 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbYCXWuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 18:50:51 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1947811wra.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xpxJnOnXIUvTLNgOAM58EpoTrrQfd9yBdKZiyBqt/zo=;
        b=LKrbPBoCTdnR5NZmBVhTkduwgol6XW8q3YyERYWtKyibUblFP8RFFPSCx+ZExofpQd7nMj/hyCq5+RQGQWNxEoA5ZPgrBO8g7N2JjLGZjtXPHgHDyheKYs9ng7oehFqQiDZw9OAD5B3B9fCHRNFJmpW2Krb9+x11SNWwnA+P/+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ey2cfk0IbvsJW/cK2uSqwij0xfL4LJ4v+9nYLAgSa/J31/w8FM/70SvEp5/5srqOutLsVKyEv3bxUhf1U6YoWKhV8pi+rKwZbyEVd7Gc+Dqqerad3qeMCwZyGuOFZhDmtGA6lS+ui1KaH3Cjt2W89LFjYr5H8BcS67M9MBttbi8=
Received: by 10.140.201.1 with SMTP id y1mr2690015rvf.200.1206399049480;
        Mon, 24 Mar 2008 15:50:49 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Mon, 24 Mar 2008 15:50:49 -0700 (PDT)
In-Reply-To: <47E82BDD.9060507@keyaccess.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78121>

On 24/03/2008, Rene Herman <rene.herman@keyaccess.nl> wrote:
> On 24-03-08 21:43, Junio C Hamano wrote:
>
>  > Rene Herman <rene.herman@keyaccess.nl> writes:
>  >
>  >> On 24-03-08 21:15, Jan Engelhardt wrote:
>  >>
>  >>> On Monday 2008-03-24 20:59, Catalin Marinas wrote:
>  >>>
>  >>>> Stacked GIT 0.14.2 release is available from
>  >>>> http://www.procode.org/stgit/.
>  >>>>
>  >>>> StGIT is a Python application providing similar functionality to Quilt
>  >>>> (i.e. pushing/popping patches to/from a stack) on top of GIT.
>  >>> I always wondered what the difference between stgit and guilt is.
>  >>> Does anyone have a comparison up?
>  >> And I remember some mumblings about git growing quilt-like
>  >> functionality itself. Anything on that?
>  >
>  > Not my mumbling
>
>
> Believe it was Linus. Seem to remember him saying something about possibly
>  adding a native queues-like interface not too long ago but it's proving
>  impossible to google for.

It was Linus indeed, on the linux-arch mailing list:

http://www.mail-archive.com/linux-arch@vger.kernel.org/msg05012.html

-- 
Catalin
