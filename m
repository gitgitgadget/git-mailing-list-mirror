From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Fri, 9 Oct 2009 07:46:06 -0700
Message-ID: <20091009144606.GT9261@spearce.org>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru> <20091008150206.GD9261@spearce.org> <20091009090958.GA4758@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Oct 09 16:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGo8-0005T0-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760961AbZJIOqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760955AbZJIOqn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:46:43 -0400
Received: from george.spearce.org ([209.20.77.23]:60754 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760950AbZJIOqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:46:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 208C9381FE; Fri,  9 Oct 2009 14:46:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091009090958.GA4758@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129807>

Kirill Smelkov <kirr@mns.spb.ru> wrote:
> On Thu, Oct 08, 2009 at 08:02:06AM -0700, Shawn O. Pearce wrote:
> > We probably should place a quick comment here to remind folks that
> > they need to build the script in order to test it properly.
> 
> I've added some sort of protection, so that git-completion.bash.in can't
> be sourced at all. Is it ok?

Yes, looks fine.

> Subject: [PATCH 2/2] bash: make git-completion.bash.generate bash agnostic

Squash this into the first patch and add the egrep change made by
Stephen Boyd "[PATCH 1/2] completion: fix completion of git <TAB><TAB>".
 
-- 
Shawn.
