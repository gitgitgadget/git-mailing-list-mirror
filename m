From: John Keeping <john@keeping.me.uk>
Subject: Re: Segfault in git merge-tree (1.8.2.2)
Date: Mon, 6 May 2013 14:39:37 +0100
Message-ID: <20130506133937.GB25912@serenity.lan>
References: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Jacobsen <andreas@andreasjacobsen.com>
X-From: git-owner@vger.kernel.org Mon May 06 15:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZLdt-0002rp-C4
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 15:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab3EFNjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 09:39:44 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38712 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3EFNjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 09:39:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3854ECDA629;
	Mon,  6 May 2013 14:39:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9S1V5OYJnaWk; Mon,  6 May 2013 14:39:42 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EA16CCDA633;
	Mon,  6 May 2013 14:39:39 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223449>

On Mon, May 06, 2013 at 03:02:10PM +0200, Andreas Jacobsen wrote:
> I'm getting a segfault in git merge-tree using v1.8.2.2 on MacOS
> 10.8.3. I can't share the repo, but I can build patches and check if
> they fix the problem :)

Can you rebuild with debugging information and try the backtrace again?

Something like:

    make CFLAGS='-O0 -g'

Then use the "git" in bin-wrappers/.
