From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Patch which adds syslog support to git-shell
Date: Thu, 24 Dec 2009 14:03:32 +0100
Message-ID: <40aa078e0912240503u3d6ffd26n90aa0e3e30220c93@mail.gmail.com>
References: <200912231832.03541.gerhard.gappmeier@ascolab.com>
	 <40aa078e0912240338g7765d17cyf948650deab2aa01@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 14:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNnLv-0008Nq-Hd
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 14:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZLXNDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbZLXNDe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 08:03:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:39773 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZLXNDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 08:03:33 -0500
Received: by ey-out-2122.google.com with SMTP id 25so718820eya.19
        for <git@vger.kernel.org>; Thu, 24 Dec 2009 05:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=p3AVHGNKNQa45QLVXFZTKnl2uF1roSUSjMGTzeXRfsA=;
        b=u23AjaRdqCoCK0uOg52ELNEbeIC6Ij19r3H/i+djPkJN84ZhPtgxer8UxJZhXUWrdx
         HKl8EBkSmJ7Zlozr/qQJ8pxU7JTC0NyojocfWqC5UrC3BPfQOlBWax/z0x2zFnEPb72o
         kSZ6XCy57yI1Z3rsTnRx9W57eO/gaprV3ZEmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=moaX8RrcFM/tUoDDugFbfWE5HQNE4hi/pFuimd0Kb5w0Va1v3FXCRhuav/YXAhrox+
         TqbjD/uzuta3joTpGQf7pDXpYPxVlbeBHbv+sKkLuLjNWYkJBmiSrDsUAUl5e32rBPGL
         zl9CJIDbkO6ca5WQdye798efPxLitN5HioGkY=
Received: by 10.216.89.206 with SMTP id c56mr752526wef.123.1261659812448; Thu, 
	24 Dec 2009 05:03:32 -0800 (PST)
In-Reply-To: <40aa078e0912240338g7765d17cyf948650deab2aa01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135653>

On Thu, Dec 24, 2009 at 12:38 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> Anyway, this is all I bother to point out before I see an inlined,
> white-space fixed patch.
>

Actually, I'll add one thing: using syslog in git-shell breaks the
Windows builds. I don't know about other platforms.

Currently, git-daemon is the only git-program that depends on syslog,
and it's excluded from Windows builds (but this is something that
might change soon).

-- 
Erik "kusma" Faye-Lund
