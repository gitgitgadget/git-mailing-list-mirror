From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git remote vs. submodules
Date: Thu, 11 Nov 2010 12:34:44 +0100
Message-ID: <4CDBD4D4.1080607@dbservice.com>
References: <AANLkTinev0W7-mm9wXmnZwY6DxN0Y2X0hJdpBOgM_4q=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 12:35:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGVQo-0001Mh-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 12:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab0KKLew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 06:34:52 -0500
Received: from office.neopsis.com ([78.46.209.98]:43269 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab0KKLev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 06:34:51 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: -0.014,BAYES_00: -1.665,TOTAL_SCORE: -1.679,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.2.175.86])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 11 Nov 2010 12:34:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinev0W7-mm9wXmnZwY6DxN0Y2X0hJdpBOgM_4q=@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161227>

On 11/11/10 2:45 AM, Patrick Doyle wrote:
> Hello All,
> I was just reading about git remote and I started thinking to myself,
> "Gee, nothing I've read says that the remotes have to share a common
> ancestor.  I wonder what would happen if I added two independent
> repositories as remotes to a superproject?"
> 
> So I tried it in a very trivial case.  The first thing I learned was
> that I need to make the subprojects subdirectories of a top level
> .git-housing directory.  Or else, when I merge them in, everything in
> the top level of subproject1 gets mixed in with everything in the top
> level of subproject2.  So this doesn't seem to be a good solution for
> marrying arbitrary subprojects together.  But if I set up a library of
> subprojects properly, it seems like I could do this.
> 
> So now I'm wondering... has anybody else ever had thoughts along these
> lines?  Has anybody tried this?  Has anybody seen it work (or fail
> miserably)?
> 
> Why would I want to do this instead of using submodules?  I dunno.  It
> just came to mind when I started trying to understand what's really
> going on with remotes.  And I vaguely (and perhaps even correctly)
> recall there being some controversy regarding submodules when they
> were first introduced.

Are you maybe looking for a subtree merge?
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

tom
