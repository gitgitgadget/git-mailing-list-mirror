From: Drew Northup <drew.northup@maine.edu>
Subject: Git Attribute: File Text Encoding {WAS: Re: [RFC] Print diffs of
	UTF-16 to console / patches to email as UTF-8...?}
Date: Fri, 22 Oct 2010 16:18:15 -0400
Message-ID: <1287778695.819.17.camel@drew-northup.unet.maine.edu>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	 <20101022161851.GH9224@burratino>
	 <E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
	 <20101022195331.GA12014@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Joshua Juran <jjuran@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 22:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9O89-0000eK-3A
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 22:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab0JVUWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 16:22:15 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:50989 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab0JVUWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 16:22:15 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MKIL98022756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 16:18:21 -0400
In-Reply-To: <20101022195331.GA12014@burratino>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MKIL98022756
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288383507.5989@ps5o5wBiGoDwOLgnAg/L1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159744>


On Fri, 2010-10-22 at 14:53 -0500, Jonathan Nieder wrote:
> Joshua Juran wrote:

> >                                                      But a more
> > complete and robust solution would be to store the encoding
> > somewhere, possibly in the blob itself, or in the tree storing the
> > filename.
> 
> How about Jakub's idea of keeping it in .gitattributes (or some
> similarly visible key/value store)?  Two reasons:
> 
>  1. When asked to declare encoding, half the time people will be
>     wrong.  So it seems worthwhile to make the declared encoding
>     visible enough to fix.
> 
>  2. Two ASCII files identical except that one is declared as
>     latin1 and the other utf8 should be considered identical.
> 
> Thanks for some food for thought.

I think that's a fine place to start. Shall I start a branch for it when
I get home (where the code I'm working on is located)? It would be good
practice if nothing else...

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
