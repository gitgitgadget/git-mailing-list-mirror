From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 16:38:53 +0100
Message-ID: <20130524153853.GE27005@serenity.lan>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <7v4ndtcmh0.fsf@alter.siamese.dyndns.org>
 <CABURp0rBzH9=VdW0Y4Bv1tfbSzZ3dwismwgZ7zCwrXC6nDRSJQ@mail.gmail.com>
 <loom.20130524T173321-264@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Greenleaf <james.a.greenleaf@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 17:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufu5B-0006Ls-JX
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab3EXPjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 11:39:00 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:40966 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab3EXPjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 11:39:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 3B72E1FC87;
	Fri, 24 May 2013 16:38:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0n70J+IFTQ+w; Fri, 24 May 2013 16:38:58 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 0DAB722F23;
	Fri, 24 May 2013 16:38:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <loom.20130524T173321-264@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225364>

On Fri, May 24, 2013 at 03:34:26PM +0000, Jim Greenleaf wrote:
> Phil Hord <phil.hord <at> gmail.com> writes:
> 
> > The wording of --ignore-changes suffers the same lack of clarity that
> > --assume-unchanged does.
> > What's better?  --sequester is probably too obscure.  Maybe --hold.
> > Or --silence.  Or --shut-up.
> 
> How about --freeze?

I wonder if this would be better as a file rather than another option to
git-update-index.  We already have .git/info/exclude so we could add
.git/info/freeze or .git/info/local with the same syntax as the normal
.gitignore file.
