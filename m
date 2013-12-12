From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 13:35:33 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212183533.GC16960@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
 <CACPiFC+CAhh1S6Wt0bO2pDrXWgBW7AEFahGJjq0W7rG9LfTb8A@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 19:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrB6o-00021Z-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 19:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab3LLSfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 13:35:34 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41006
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3LLSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 13:35:34 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 7AF1C380445; Thu, 12 Dec 2013 13:35:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFC+CAhh1S6Wt0bO2pDrXWgBW7AEFahGJjq0W7rG9LfTb8A@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239234>

Martin Langhoff <martin.langhoff@gmail.com>:
> In my prior work, the "better" CVS importers would not have stable
> output, so were not appropriate for incremental imports.

That is disturbing.  I would consider lack of stability a severe and
unacceptable failure mode in such a tool, if only because of the
difficulties it creates for proper regression testing.

If cvs-fast-export does not already have this property I will fix it 
so it does.  And document that fact.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
