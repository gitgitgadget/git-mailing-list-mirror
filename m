From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: dangling commits and blobs: is this normal?
Date: Thu, 23 Apr 2009 20:17:44 +0200
Message-ID: <op.usuqfufi1e62zd@balu.cs.uni-paderborn.de>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221548310.6741@xanadu.home> <20090422200502.GA14304@coredump.intra.peff.net> <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com> <20090423175612.GV23604@spearce.org> <0F4B0DFB-A0A3-45FA-9BB7-801FFD2E8862@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"John Dlugosz" <JDlugosz@tradestation.com>, git@vger.kernel.org
To: "Geert Bosch" <bosch@adacore.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3WZ-0004Th-62
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886AbZDWSRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbZDWSRt
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:17:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:39241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751212AbZDWSRs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:17:48 -0400
Received: (qmail invoked by alias); 23 Apr 2009 18:17:47 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp019) with SMTP; 23 Apr 2009 20:17:47 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18lk7EVZjslgxBM97nJUgBvbs+1ovtYGpvdKqzoam
	uKuzkDUWue3IBU
In-Reply-To: <0F4B0DFB-A0A3-45FA-9BB7-801FFD2E8862@adacore.com>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117356>

Am 23.04.2009, 20:10 Uhr, schrieb Geert Bosch <bosch@adacore.com>:

>
> On Apr 23, 2009, at 13:56, Shawn O. Pearce wrote:
>
>> If your favorite import tool (*cough* git-svn *cough*) can't use
>> fast-import, and you are importing a large enough repository that
>> this matters to you, use another importer that can use fast-import.
>
> How did you guess? :) You're right of course, except that I can't
> use fast-import AFAIK. The issue is also more general, as the
> same scenario of adding new objects and repacking occurs
> outside the context of git-svn.

If you can't use fast-import for lack of access to the SVN repo, svnsync  
may help with that part. Or easier: ask the admin to upload a dump or  
provide one for download... :-)

-- 
Matthias Andree
