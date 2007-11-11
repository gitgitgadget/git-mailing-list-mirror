From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 13:30:34 +0800
Message-ID: <46dff0320711102130g5171a421r244bdf74a578f68b@mail.gmail.com>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	 <20071110195509.GI2261MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Nov 11 06:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir5PG-0002To-Uq
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbXKKFag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbXKKFag
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:30:36 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:12398 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbXKKFaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 00:30:35 -0500
Received: by py-out-1112.google.com with SMTP id u77so538748pyb
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 21:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=amZhZ3Ub0bhZGYDxbq8Am10PMqAcv07oeHNlWncWiP8=;
        b=BxVZkHK7w/XoFMUj17rLB2hqVt/jox7JA2n+lO6ObNs3NiWy9A+QaE2hfTHMEmkEH6Kyuyvo6G1tG40Xc7Djk/gAHP3JVR2tMr48Y6sJYdBMQPSLyCRueBRgaNkhHFC6WP2SDdSge1mDgXKzNpKewAGB5Ep1+fDYpzgZ5q3dWL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aBjKY6gb6OdrajaQvgtu/KqnjNLBl7YkoFnfTXuISVHTQaHvxJ3qMAMHyOWfg06cAbS//eaE60iJg82mXSX4lw0BqT5Oao00q6vai5JG2KnREpACOXyeD6TJivAvy64SwgM+hwHEWfwzf1PE8sMueKT6UpOb3TYLibTNZdqHq2g=
Received: by 10.35.132.9 with SMTP id j9mr268424pyn.1194759035035;
        Sat, 10 Nov 2007 21:30:35 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 10 Nov 2007 21:30:34 -0800 (PST)
In-Reply-To: <20071110195509.GI2261MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64403>

On Nov 11, 2007 3:55 AM, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sun, Nov 11, 2007 at 03:27:43AM +0800, Ping Yin wrote:
> > This commit teaches git status/commit to also show commits of user-cared
>
> Does it?  It looks like you only changed git-commit.
> Shouldn't this be put in wt_status_print, if anywhere?
>
git-commit and git-status correspond to the same script git-commit.sh
> Also, you have some typos:
>
> > +     test -n "$modules" && echo -e "#\n# submodule modifiled: "$modules"\n#"
> [..]
> > +                             echo "  Warn: $name dosn't contains commit $headone"
>
> skimo
>
Oops, i'll fix it



-- 
Ping Yin
