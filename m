From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] [GIT GUI PATCH] git-gui: fix open explorer window on 
	Windows 7
Date: Wed, 24 Feb 2010 12:15:03 +0000
Message-ID: <a5b261831002240415l5447ac94wd80c162fc9492fd5@mail.gmail.com>
References: <20100223225243.GC11271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkG95-0007za-5T
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468Ab0BXMPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:15:08 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45487 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0BXMPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:15:05 -0500
Received: by wya21 with SMTP id 21so1145350wya.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=05kNiH5r3cj0L3on3NRGDNRvY4+86C0vok4i59vJJgY=;
        b=P5t76a+srZBAXLNilNJKQ7df7tMGqsL90+T5giUmKxNuTeCrfkFUX79s3Xt6Zl2mFs
         RsPAFz6gXMcXhrVJv3VCYEg4P7mH/L8l7f4TrOZDT4TaILcnrghku2qNH9sDZ6BenvF/
         yOh9xnW3SqsNnt4BAltCZpbEGzLvcIce5xDiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=miG7h2a4GO+3x4LVTdASy/+V27aJUI70+FLS6fwrO4c15H61m3pNcWV510WcO0CfS4
         2EQ6HmUt+2U0ILv0paO3NCWUBdDNnALXBLi6sHQ4S86uxZRHZym7368PQOvOzifklqEG
         qAh9Yx9hsSAtzaxWWhGrELLDyj9Sl905oGOVw=
Received: by 10.216.91.18 with SMTP id g18mr3081600wef.203.1267013703837; Wed, 
	24 Feb 2010 04:15:03 -0800 (PST)
In-Reply-To: <20100223225243.GC11271@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140929>

On 23 February 2010 22:52, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> It seems that Windows 7's explorer is not capable to cope with paths
> that contain forward slashes as path seperator. We thus substitute slash
> with the platforms native backslash.
>

What bug are you actually addressing here? How can I reproduce it? My
experience on Windows 7 is that there is no problem but I assume I'm
doing a different operation. If I use the git-gui  "Explore working
copy" it opens the Windows explorer for me just fine.
