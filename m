From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC 00/20] Refactor rebase
Date: Sat, 27 Nov 2010 02:24:56 +0100
Message-ID: <AANLkTi=UbW5r3zY6j=erA7RzDWLYEe=z84=Qt+QarVCp@mail.gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <alpine.DEB.1.10.1011252120450.17721@debian> <AANLkTikyQTA3b8+subR2FTL9zFBt_dGqNxjsjP+fwE-n@mail.gmail.com>
 <alpine.DEB.1.10.1011261954350.17721@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 02:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM9Xc-0004l9-ID
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 02:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0K0BZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 20:25:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61597 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0K0BZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 20:25:17 -0500
Received: by ywl5 with SMTP id 5so1188394ywl.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 17:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=8E7LBUQNiu9+Z9PpQVqFdLVezblUX6A+2vwk/uqyZNA=;
        b=Tii60Yx+kdjhbktnskWlU5XbRKPJX87MzTYgwZgtwvYVrXtelJpiAq+zK1uv5BC0BI
         /w6pWjAIw/mkUNGnr+o1yMo4UR6O9Zd1JnDUWyY0L6Gj4a0Fe1jVK6NpONHb0N4IM7Vy
         SCLLUUrRqJXX0b23p0cYBsreznvn+TpNykv1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mUhLWaiV2qbgcp4mbpiFndRJr/K897pXI3TWuKjW9oL9BIHiqEw0A+PCHvy7f2qTXV
         lhHGlwwE01hCJnXkaloB9F7T9zZC9EESkFubnT4M/jnaeq46JwPVmiikk4jy8sF5hoAz
         G7TLAy6LG5Q2Q3uSvLiMMZtl7pWgPdc/SLyAo=
Received: by 10.150.196.17 with SMTP id t17mr5902752ybf.302.1290821116843;
 Fri, 26 Nov 2010 17:25:16 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Fri, 26 Nov 2010 17:24:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1011261954350.17721@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162290>

Heya,

On Fri, Nov 26, 2010 at 20:16, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> They touch the same code as 729ec9e (rebase --abort: do not update
> branch ref), 7baf9c4 (rebase: support --verify) and 92c62a3 (Porcelain
> scripts: Rewrite cryptic "needs update" error message). However, it is
> only 7baf9c4 that would have to be more or less redone if I did not
> base the patch set on it. Do I understand correctly that I should
> therefore have based them directly off of 7baf9c4?

Yes, I think that'd be preferable, unless Junio disagrees?

> I suppose it is not worth resending this time. Tell me if you think
> otherwise.

Yeah, you can just wait to rebase with the next iteration.

-- 
Cheers,

Sverre Rabbelier
