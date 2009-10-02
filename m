From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Re: Git push over git protocol for corporate environment
Date: Fri, 2 Oct 2009 07:47:27 -0700
Message-ID: <20091002144727.GZ14660@spearce.org>
References: <m3pr989eyt.fsf@localhost.localdomain> <00163623ac5d75929b0474e66b96@google.com> <76c5b8580910020741p2024f6c0w70be53338924e7e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 16:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtjQ0-0000ra-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 16:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbZJBOrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 10:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbZJBOrY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 10:47:24 -0400
Received: from george.spearce.org ([209.20.77.23]:39151 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbZJBOrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 10:47:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0294B381FE; Fri,  2 Oct 2009 14:47:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <76c5b8580910020741p2024f6c0w70be53338924e7e8@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129445>

Eugene Sajine <euguess@gmail.com> wrote:
> Gitorious is even better!! for corporate use, i think, because of its
> team oriented approach, but... man... I would kill for java
> implementation or anything as simple as that!!

If you want a Java based server, look at either:

* SCuMD               http://github.com/gaffo/scumd
* Gerrit Code Review  http://code.google.com/p/gerrit/

I think SCuMD might be easier to install, I don't think it depends
upon a database or a servlet container like Gerrit does.  But both
are a SSH+Git implementation with some access control capabilities,
and are implemented in Java.

I don't think either is (yet) as easy to install as Hudson CI.
Both projects have a much smaller team of developers behind them,
and are still focusing on basic functionality rather than ease of
new system setup.

-- 
Shawn.
