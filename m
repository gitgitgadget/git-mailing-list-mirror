From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: How to change a submodue as a subdirectory?
Date: Thu, 15 Nov 2007 13:36:16 +0800
Message-ID: <46dff0320711142136r2c70d698vd380c02188f95507@mail.gmail.com>
References: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com>
	 <20071114202651.GC3973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 06:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsXP1-0005C8-8g
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 06:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXKOFgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 00:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXKOFgS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 00:36:18 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:20857 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbXKOFgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 00:36:17 -0500
Received: by py-out-1112.google.com with SMTP id u77so3260478pyb
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 21:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0ncH/Y/SpPzKK6+VTE3yGWFBx4wNzXZfFJbERkk5+54=;
        b=VjqETunmNE8iSQkmHYdfXYN71IpL1i9UvgWrTK+86NpiaxoOWYRne6FeSaGBDS+mZ8tagI9x0fBuorRtMcf5wwCvCoOzAFJbfF0JomFg1JEKsx8aaU0SyGKiZ3Mw/VRM8j38b+oJfldYuXOdMUaBZfcG5PdctxSAIszMORbLiDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qDXnqKWjlV7WCxRNjNKkfe2F75fR+mXOxfBMctl3+ujCpz7JiP3xXY/+AOR9XAWYidgC1GcphlsUiYkYrv3X4SP7HXOPjIdFrJXl/D8eZudQGNk8v4HR7JsfACDHSOdSbto183n+SjEDOqXa/4FckWb91LgfisYX8dvU2znRtZM=
Received: by 10.35.77.18 with SMTP id e18mr366263pyl.1195104976775;
        Wed, 14 Nov 2007 21:36:16 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 14 Nov 2007 21:36:16 -0800 (PST)
In-Reply-To: <20071114202651.GC3973@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65061>

On Nov 15, 2007 4:26 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Ping Yin, Wed, Nov 14, 2007 15:37:57 +0100:
> > I have a super project superA, and a submodue subB. Now i decide to
> > switch subB from submodule to sub directory. Any good way to do that
> > and not losing any history?
>
> $ mv subB sub
> $ git add sub
> $ git update-index --force-remove subB
> $ git commit
>
> Which history were you afraid of losing?
>
I want to keep the history of the submodule



-- 
Ping Yin
