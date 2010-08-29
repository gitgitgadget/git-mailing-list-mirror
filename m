From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 07/13] transport-helper: change import semantics
Date: Sun, 29 Aug 2010 15:26:11 -0500
Message-ID: <AANLkTi=bLe_3u+-u=+L71JiKQrQwmVz6=x=h7mws8zaC@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-8-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.1008291521350.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpoSa-0000rz-J7
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab0H2U0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 16:26:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38667 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0H2U0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 16:26:31 -0400
Received: by gwj17 with SMTP id 17so1756057gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=T6QLhBJNSf2VVxrcFmpnlCXzuIsk6AdUQoI7V10PTZs=;
        b=tDL/XmYjVTq3xdUBj7lgNo/59x2YTVujqvElc1lEQQIyYTqyFgbhJ4HLGCDGR5wX2/
         m2Tbdex/Lgd5j6R1eL3GkEpKyTBrBXJJ1GI7eh+We+hCjfPGPR2qhGXZoratD3ekW5S0
         Sm7GsGwgqO+Ys/HAMrb+8i/8I5MgbLugtOIjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mSxBLevBt8j2Cz6ja+td+KcH2iSoKS8hKN6GhOohNj7m2n511NyzB/RJ8gUptGVoOY
         rLv6Pbc8IjFEgEany+hRQrMD4W+ys58zDRoX2G5PTFBoTRZ4lUOYlWfDZBaWr0j5QMBU
         ymWx0Nt/aUEXh9D5n42Ad+eoSVR0/UI2EG8Hc=
Received: by 10.151.62.21 with SMTP id p21mr4412543ybk.170.1283113591090; Sun,
 29 Aug 2010 13:26:31 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 13:26:11 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008291521350.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154712>

Heya,

On Sun, Aug 29, 2010 at 14:29, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I think your reasons for this change could be worked around, but the
> protocol is cleaner with your change, which is justification enough, given
> that it shouldn't be too big a deal to change. This also lets the helper
> consider all of the refs it is expected to update before producing the
> stream, which may simplify the stream (particularly if the history has
> merges involving branches that may or may not be imported are aren't
> listed first).

Aye, that was also part of my motivation to do it this way (as opposed
to e.g. running fast-import multiple times).

> I don't think "import" has gotten to the point where people could really
> use it in helpers not packaged with git, anyway, so I agree.

Great :)

-- 
Cheers,

Sverre Rabbelier
