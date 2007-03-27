From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 18:08:12 +0200
Message-ID: <38b2ab8a0703270908y331a372du7cd340f1d884456d@mail.gmail.com>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	 <7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
	 <38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com>
	 <7vircnou7i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWEDa-00064L-Vd
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbXC0QIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbXC0QIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:08:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3328 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbXC0QIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 12:08:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1934696uga
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 09:08:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Av7zz2D1cluLTmkae12bjiO5AC3exIJxr1Neu6ZtDUSkToOvrrN8fFDvl/2wD3nnAe7/IRLf3XNbLJ0uvAQqQ/ColmmYsv46zfXhFq6ZLu1D7/lC69vqCBkF6MFrM6ddR3C4bpknMX5PR4TyV6idxi1QW+0OnPuS9DNuKLFLzaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gZy7nEbQuNS5HE4NEd/E0181Bk9GgwYpRtJQ1SQbaaSUvXtGOioCCMyXfEl7PU6SztonU+niqGqtb5dJjukuHTmyQ1QHs1z3UL0bRDgR+LiaGf6vVYgJmzDOSHwgib98WyUxEjXNg9JOe0sGQmms/sYB1H+7paejooXZaFwBUHI=
Received: by 10.114.122.2 with SMTP id u2mr3215920wac.1175011692402;
        Tue, 27 Mar 2007 09:08:12 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Tue, 27 Mar 2007 09:08:12 -0700 (PDT)
In-Reply-To: <7vircnou7i.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43278>

On 3/27/07, Junio C Hamano <junkio@cox.net> wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
> > IOW is it possible for git to know if it has been invoked interactively ?
>
> I do not think so, but I think alias expanding "git foo" while
> not expanding "git-foo" should not be too hard.  You need two
> extra preparation steps for such a change to be useful, though.
>

Isn't that too dangerous to rely on the fact that scripts will always
use "git-foo" syntax ?
-- 
Francis
