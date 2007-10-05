From: David Brown <git@davidb.org>
Subject: Re: Many gits are offline this week
Date: Fri, 5 Oct 2007 09:20:29 -0700
Message-ID: <20071005162029.GA18522@old.davidb.org>
References: <20071005010448.GQ2137@spearce.org> <863awq5p1y.fsf@blue.stonehenge.com> <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com> <86tzp54sez.fsf@blue.stonehenge.com> <37fcd2780710050741x1760a585yeaa9023a8d8cdccf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idpuv-0002ya-Eo
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763408AbXJEQUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758215AbXJEQUh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:20:37 -0400
Received: from mail.davidb.org ([66.93.32.219]:45058 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760160AbXJEQUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:20:36 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1Idpuf-0006BL-G8; Fri, 05 Oct 2007 09:20:29 -0700
Mail-Followup-To: Dmitry Potapov <dpotapov@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <37fcd2780710050741x1760a585yeaa9023a8d8cdccf@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60104>

On Fri, Oct 05, 2007 at 06:41:43PM +0400, Dmitry Potapov wrote:

>I believe I have found one mistake in your slides. Slide 18 reads:
>"git-commit -a" is like "git-add .; git-commit"
>
>But it is incorrect, because "git-commit -a" does not add new files, so
>it works like "git-add -u .; git-commit".

"git-commit -a" also detects files that have been deleted, whereas
"git-add" does not.  In fact, I haven't found an easy way to detect this
other than "git-commit -a", and it is the only reason I ever run
"git-commit -a"

Dave
