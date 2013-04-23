From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage:
 invalid argument --norc)
Date: Tue, 23 Apr 2013 17:06:57 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130423210657.GA32382@thyrsus.com>
References: <323381594.20130414121834@gmail.com>
 <673219382.20130414124800@gmail.com>
 <20130414113351.GA1299@thyrsus.com>
 <1762779000.20130415215818@gmail.com>
 <20130418094326.GB11038@thyrsus.com>
 <214169596.20130420142251@gmail.com>
 <20130423175000.GA25994@thyrsus.com>
 <538486753.20130423223007@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 23:07:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUkQx-0001j7-E0
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 23:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268Ab3DWVHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 17:07:18 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42120
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab3DWVHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 17:07:15 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 4DB0940624; Tue, 23 Apr 2013 17:06:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <538486753.20130423223007@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222212>

Ilya Basin <basinilya@gmail.com>:
> For new branches the 'from' command can refer the common ancestor in
> an existing branch. For example:
> 
>          /----------E thebranch
>         /
>     A---B---C---D master
> 
> Commit E is newer than D; we already imported D; thebranch is new.
> Instead of:
>     from refs/heads/thebranch^0
> refer the parent as:
>     from refs/heads/master^2

Understood.  Do you actually need this much generality in practice, 
or is it a theoretical case?

> OK, something's wrong with the man page: starting with '-A' the
> description is unstructured:

Interesting.  The aciidoc parser got a little confused, but inserting
some blank lines fixed it. 
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
