From: Jason Spiro <jasonspiro4@gmail.com>
Subject: Re: Improving CRLF error message; also, enabling autocrlf =?utf-8?b?YW5kCXNhZmVjcmxm?= by default
Date: Mon, 16 Feb 2009 03:29:23 +0000 (UTC)
Message-ID: <loom.20090216T032551-612@post.gmane.org>
References: <loom.20090216T022524-78@post.gmane.org> <20090216030446.GC18780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 04:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuCE-0007fi-2i
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbZBPD3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755729AbZBPD3e
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:29:34 -0500
Received: from main.gmane.org ([80.91.229.2]:40978 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbZBPD3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:29:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYuAn-0000yB-Aq
	for git@vger.kernel.org; Mon, 16 Feb 2009 03:29:33 +0000
Received: from CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com ([99.226.154.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 03:29:33 +0000
Received: from jasonspiro4 by CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 03:29:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.226.154.227 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110125>

Jeff King <peff <at> peff.net> writes:
> 
> On Mon, Feb 16, 2009 at 02:45:43AM +0000, Jason Spiro wrote:
> 
> > One of the pre-commit hooks detects trailing whitespace:
> > 
> > if (/\s$/) {
> > bad_line("trailing whitespace", $_);
> > }
> 
> Not since 03e2b63 (Update sample pre-commit hook to use "diff --check",
> 2008-06-26), when that line was removed.
> 
> I'm happy you want to improve git; but please, if you want to report
> problems, check what the status is in a more recent version (or at least
> tell us your version, which can help).

Sorry.  Will do.

...
> > 2.  In addition, could you please enable the core.autocrlf and 
core.safecrlf 
> > options by default in the next version of Git?
> 
> I think that is up to your platform packaging, I think. I think msysgit
> is shipping with core.autocrlf on by default these days. But again, I
> don't know very much about that area.

Are you saying that only my platform's packager can decide what options are 
enabled by default, and that you upstream folks have no influence at all?  :)
