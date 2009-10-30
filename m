From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 02/19] Allow fetch to modify refs
Date: Fri, 30 Oct 2009 22:24:35 +0100
Message-ID: <fabb9a1e0910301424t78173e8es118d95714464fbf2@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-3-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300151450.14365@iabervon.org> 
	<fabb9a1e0910300522je3d76aep160d87fe302f8779@mail.gmail.com> 
	<alpine.LNX.2.00.0910301110120.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:25:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3yxy-0007Fi-9g
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbZJ3VYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932893AbZJ3VYw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:24:52 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:60478 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbZJ3VYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:24:51 -0400
Received: by ewy28 with SMTP id 28so3454933ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=G0XP8/XDkS+fBMYeFiGO4StqwiqnaOoHi6l7Aig8UiY=;
        b=ZZHK2adO/wWKUb2anHD0pbMis1+D6gOmH41U1c9rzCFw2ZbiqALqu+6fZudE6WYmt+
         qc9wEjAA3RtgxiivfSY2ZAOh4ZIZdM981Yu/HqUTL1bFtmil+gJXXxLoxcOsGJ8HlxaY
         7YdgAee8rKcgXozKzbqB/zkYvmukJEJ0HBPik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aX8qL2pjOcGjmbq4Q0vKRFrfcxDfUQ/48eJcqmdTp9POxpJC+KcjazyRXtjsc0QN6i
         HtJY/B/kkBPDz4IZIZ9LP5RDP0gqX/Dv02Ggb3aU4bGrcp55QiqmXjZhUb175Ree2FTG
         1FBi/rWl3Lnx/RMYvpAhPJx5ikhK8UZe00G0o=
Received: by 10.216.86.72 with SMTP id v50mr789407wee.184.1256937895109; Fri, 
	30 Oct 2009 14:24:55 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910301110120.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131753>

Heya,

On Fri, Oct 30, 2009 at 16:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Ah, actually, mapped_refs should just be made non-const; unlike "refs",
> it's set from wanted_peer_refs(), which returns a non-const value.

That works too, even better I guess :).

-- 
Cheers,

Sverre Rabbelier
