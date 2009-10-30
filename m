From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 10/19] Allow helpers to request marks for fast-import
Date: Fri, 30 Oct 2009 05:26:04 -0700
Message-ID: <fabb9a1e0910300526v5cbcf685l69f60c58b7e3732@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-11-git-send-email-srabbelier@gmail.com> 
	<200910300921.00561.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:26:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3qYo-00070L-TO
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbZJ3M0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 08:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756143AbZJ3M0V
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:26:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:28038 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbZJ3M0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 08:26:20 -0400
Received: by ey-out-2122.google.com with SMTP id d26so3546eyd.19
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=go4R7O1g2dyyo5BqEpKwgGXxSwfUJ5EsEhpIPzMLejE=;
        b=Kt55Fyrtb7Vc4WLjaZaK3l7jO4yjeWYgjt/rneWVtlpeZivj831DLI+EM+YxVQwnjb
         xQ5nBCROCDpEjArzX0txorkNJzTAu//0JShMJIwNVNuo13ZE1TwZRR3u9whQkZnWuf6Q
         a9CBxUzms3kaIpAU2kcY97MLJeGm+DpXYsySo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ARp09vSCnV7NHHcrMvZpDgWk0xqeXnkVO+BNfSSmvkh+qeOz/xz3ztKmImOan7g/oz
         Esz2C5c2BuhidhD5PaGgU8nezKmZ1trwmNhF3ISfPmU4kwXx1CA/CRkAlJ8HXWjUr3Dz
         Ffb8x27Wr8pKzmThFaAZJcwneky02CZsesBt4=
Received: by 10.216.88.79 with SMTP id z57mr554185wee.22.1256905584104; Fri, 
	30 Oct 2009 05:26:24 -0700 (PDT)
In-Reply-To: <200910300921.00561.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131699>

Heya,

On Fri, Oct 30, 2009 at 01:21, Johan Herland <johan@herland.net> wrote:
> Please drop this patch from the series. The functionality is not needed,
> since we'll use the fast-import "option" command from the sr/gfi-options
> series instead.

In that case I will rebase the series on top of sr/gfi-options then as
soon as I reroll that one. Also, do you need to change anything else
in git-remote-cvs to do that?

-- 
Cheers,

Sverre Rabbelier
