From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 3/3] git-apply: add tests for stripping of leading and
	trailing whitespace
Date: Mon, 17 Sep 2007 20:53:49 -0400
Message-ID: <20070918005349.GB2443@fieldses.org>
References: <11899829424040-git-send-email-bfields@citi.umich.edu> <11899829424173-git-send-email-bfields@citi.umich.edu> <1189982942187-git-send-email-bfields@citi.umich.edu> <11899829421064-git-send-email-bfields@citi.umich.edu> <m3myvlv0m0.fsf@maximus.localdomain> <20070917150213.GB4957@fieldses.org> <m31wcwsvpt.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRLl-0003qJ-4V
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbXIRAx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 20:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbXIRAx5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:53:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52647 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbXIRAx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:53:56 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IXRLZ-0001Z6-Gh; Mon, 17 Sep 2007 20:53:49 -0400
Content-Disposition: inline
In-Reply-To: <m31wcwsvpt.fsf@maximus.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58515>

On Tue, Sep 18, 2007 at 01:44:46AM +0200, Krzysztof Halasa wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> >> It may be valid, some projects use tabs for indentation and spaces
> >> for alignment, e.g.:
> >
> > Yeah, I know.  I was hoping that the stripspace behavior was already
> > specific enough to the linux-kernel style that we could just assume that 
> > it was only used by developers on projects with the same style.
> 
> Actually I would consider linux kernel an example of such project
> with spaces for alignment. Except that current tools are not to
> the task. Someday...

I guess I haven't followed previous arguments on the subject, but based
on checkpatch.pl I was assuming the tabs-whenever-possible policy had
won out.

Anyway, I can only care about whitespace for so long....

--b.
