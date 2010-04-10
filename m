From: Eric Raymond <esr@thyrsus.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 15:41:54 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410194154.GB28768@thyrsus.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
 <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
 <m3k4sfgmjc.fsf@localhost.localdomain>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon <turner25@gmail.com>, Eric Raymond <esr@snark.thyrsus.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:42:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gZ7-0001Ha-KL
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab0DJTl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:41:56 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60191
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0DJTlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:41:55 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 10D3920CBBC; Sat, 10 Apr 2010 15:41:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3k4sfgmjc.fsf@localhost.localdomain>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144583>

Jakub Narebski <jnareb@gmail.com>:
> Are out of your f**g mind?  XML, really?  XML might be good choice to
> *define* _document_ formats, but is really poor data exchange /
> serialization format (being overly verbose, among others).  Also, XML
> is not language but meta-language.

Agreed.
 
> I could understand providing JSON format, specified using --json
> option.

You know, that's actually an interesting idea.  I mentioned it
previously as the not-XML if we want to build on a metaprotocol;
I wasn't considering it seriously then.  But I am now, and it is
not without attractions.  JSON would certainly solve all the delimiter
and empty-object edge cases, and it has excellent extensibility.

>    I think there is some GPLv2 compatibile JSON generating code
> in C (MIT licensed code is GPLv2 compatibilie, isn't it?); we can
> always borrow compact JSON generation code from GPSD project (if
> license allows it) from ESR.

My license would allow it, but there's not really a lot of win in 
trying to reuse JSON generator code - writing your own printfs for
it by hand is easy and fast.

Emacs Lisp has a JSON parser, so it would meet my needs.

Alternatively, a cleaned-up --porcelain -Z along the lines
previously suggested would be good.

Supplying both might not be a bad idea.  The volume of code involved
would be low.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
