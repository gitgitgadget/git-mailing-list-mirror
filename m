From: John Keeping <john@keeping.me.uk>
Subject: Re: Fwd: Bug: SEGV in git when applying the patches
Date: Mon, 5 Aug 2013 12:09:11 +0100
Message-ID: <20130805110911.GX2337@serenity.lan>
References: <CANmdXCGZKBwjUP2FgcgmBQ12Gv-ttv78y0ZDjfWRAmR69S2mNQ@mail.gmail.com>
 <CANmdXCFFfRJiCMV5U7Ap8wd=ek7Rs92TuaXDk8XNqQ_U7OxSKw@mail.gmail.com>
 <CANmdXCG2sQ9ujL07=S93+g6DgahiEAnMRgwaAmy16qkNw6OeSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Rafal W." <kenorb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 13:09:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6IfC-0002ip-MV
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 13:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab3HELJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 07:09:18 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:41378 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab3HELJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 07:09:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 778C022EC9;
	Mon,  5 Aug 2013 12:09:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z+Kf+8eK7mob; Mon,  5 Aug 2013 12:09:16 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 1B91F23F4C;
	Mon,  5 Aug 2013 12:09:13 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CANmdXCG2sQ9ujL07=S93+g6DgahiEAnMRgwaAmy16qkNw6OeSg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231645>

On Mon, Aug 05, 2013 at 12:01:44PM +0100, Rafal W. wrote:
> Hi,
> When applying patch via git, it is doing sometimes SEGV.
> Please find more details in the attached crash logs.

This looks like the issue fixed by commit 212eb96 (apply: carefully
strdup a possibly-NULL name, 2013-06-21), which is in Git 1.8.3.3 and
later.
