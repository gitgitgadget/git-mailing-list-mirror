From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU extended regex syntax
Date: Sat, 20 Sep 2008 21:03:24 +0000 (UTC)
Message-ID: <loom.20080920T200157-713@post.gmane.org>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org> <7vy71n482x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 23:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh9dB-0008HK-Kx
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbYITVDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYITVDe
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 17:03:34 -0400
Received: from main.gmane.org ([80.91.229.2]:54221 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbYITVDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 17:03:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kh9c2-0001dY-M2
	for git@vger.kernel.org; Sat, 20 Sep 2008 21:03:31 +0000
Received: from m34095e42.tmodns.net ([66.94.9.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 21:03:30 +0000
Received: from drafnel by m34095e42.tmodns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 21:03:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.94.9.52 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080715 Ubuntu/7.10 (gutsy) Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96366>

Junio C Hamano <gitster <at> pobox.com> writes:

> Here is [1/2] to be applied on top of 45d9414 (diff.*.xfuncname which uses
> "extended" regex's for hunk header selection, 2008-09-18).
> 
> Testing appreciated.

> +	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
> +	  REG_EXTENDED },
> +	{ "tex",
> +	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\{.*)$",

I think you need double backslash '\\' before '{' in the two places in these
patterns where you only have a single backslash.

-brandon
