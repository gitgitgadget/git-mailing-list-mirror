From: Theodore Tso <tytso@mit.edu>
Subject: Re: git diff, git mergetool and CRLF conversion
Date: Wed, 21 Jan 2009 16:03:48 -0500
Message-ID: <20090121210348.GD9088@mit.edu>
References: <83k58ofvjt.fsf@kalahari.s2.org> <20090121172351.GB21727@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlFi-0001Ao-RD
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbZAUWHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbZAUWHX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:07:23 -0500
Received: from thunk.org ([69.25.196.29]:39497 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbZAUWHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:07:22 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LPlEE-0001Pb-9S; Wed, 21 Jan 2009 17:07:18 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LPkEm-0003GF-Fu; Wed, 21 Jan 2009 16:03:48 -0500
Content-Disposition: inline
In-Reply-To: <20090121172351.GB21727@hashpling.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106686>

On Wed, Jan 21, 2009 at 05:23:51PM +0000, Charles Bailey wrote:
> > Is this intended behaviour?  I'm using 1.6.1 on Cygwin.
> 
> Speaking for mergetool, I believe that it's simply because mergetool
> uses git cat-file which just outputs the raw contents of a blob and
> doesn't do any line ending conversion.
> 
> IMHO, I think that it should probably perform the 'convert to working
> tree format' change when preparing the temporary files. I'm not sure
> how best to do that, but perhaps it should be using git checkout-index
> with the --temp option instead of cat-file.

Yes, I agree, that would probably be better.

						- Ted
