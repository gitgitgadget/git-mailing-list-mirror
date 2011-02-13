From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sun, 13 Feb 2011 01:05:41 +0100
Message-ID: <AANLkTi=3m3pvciKXgUXGffsA9xDddTum5mhWBoaWA3o+@mail.gmail.com>
References: <20110212070538.GA2459@sigill.intra.peff.net> <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
 <20110212080456.GA18380@sigill.intra.peff.net> <7vzkq1y8dv.fsf@alter.siamese.dyndns.org>
 <7voc6hy771.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 01:06:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoPTz-0000yI-45
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 01:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab1BMAGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 19:06:24 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52905 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab1BMAGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 19:06:23 -0500
Received: by yib18 with SMTP id 18so1589987yib.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 16:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6im7OjoYIUC4DUBTWdEU98vVnqbXcVk45oCUXaA3Ubw=;
        b=yH38Q6Z7pxLtMD9COHPX636BHGRj0C2JL5gmi9AkPavjMLOV0R5pF0xnowc+6olXui
         A5DFwLdrfF1eur2+WY8injE1XEemo3++pfaX+8H4zhnW4KFH3CTyBCCxQx2fnMvziAAe
         IddkKe/ORzyMU2LXJ3ZfBblRrAqTPq+xz15lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NAVBh9eoqYF/g7Ia3B0KRTUd0kEKiqteEeA55SC+ABBbha8oJlDjcE37fBfWY42OXo
         a+zJiIVvZ7Bog6dK+CAjFXYA7kgaJiTdKPAj1HuBogeql53GyeGXrw5JqSuMzDNXeLHL
         7bVaXW0mIZCLvlaKUDxVmDiqlYoNOyGUqU1iU=
Received: by 10.150.137.11 with SMTP id k11mr2533625ybd.108.1297555582107;
 Sat, 12 Feb 2011 16:06:22 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Sat, 12 Feb 2011 16:05:41 -0800 (PST)
In-Reply-To: <7voc6hy771.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166633>

Heya,

On Sat, Feb 12, 2011 at 09:42, Junio C Hamano <gitster@pobox.com> wrote:
> That way, the traversal will terminate much sooner than computing the true
> merge base.

Since we want to use this in git-gui, do you intend to expose this as
a command somehow (e.g. 'git rev-parse --reachable HEAD --all' or
somesuch)?

-- 
Cheers,

Sverre Rabbelier
