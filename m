From: Eric Raymond <esr@thyrsus.com>
Subject: Re: More git status --porcelain lossage
Date: Fri, 9 Apr 2010 15:50:29 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100409195029.GA15810@thyrsus.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
 <m3ochsh1oc.fsf@localhost.localdomain>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 21:51:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0KEN-00051C-Oq
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab0DITuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 15:50:35 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:38280
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab0DITua (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 15:50:30 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 03347475FEF; Fri,  9 Apr 2010 15:50:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3ochsh1oc.fsf@localhost.localdomain>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144465>

Jakub Narebski <jnareb@gmail.com>:
> > Conclusion: As it is presently, git status --porcelain format is
> > irretrievably botched.  You need a field separator that's musch less
> > likely to land in a filename, like '|' - and to warn in the documentation
> > that careful front ends must check for and ignore '\|'. 
> 
> Or follow what other porcelain does, like git-diff-tree raw output
> format, where all fields except final filename are space separated,
> filename is separated by tab character (or NUL when '-z' options is
> used).  If there are two names (in the case of copy or renames),
> they are separated by a tab (or NUL).  Record ends with LF (or NUL).
> 
> When '-z' option is not used, TAB, LF, " and backslash characters
> are represented by '\t', '\n', '\"' and \\, and the filename is
> enclosed in '"' doublequotes.

That would be a bit trickier to parse, but acceptable.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
