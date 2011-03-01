From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 01 Mar 2011 12:02:45 -0500
Message-ID: <1298998965.5247.46.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	 <20110214231920.GA24814@elie>
	 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	 <20110227084317.GB3356@sigill.intra.peff.net>
	 <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	 <20110228230311.GA7533@sigill.intra.peff.net>
	 <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
	 <vpqaahf9p69.fsf@bauges.imag.fr>
	 <AANLkTi=sXLcVJRVH87jXvVwCth+8vGgc7Ha0=XEG0Kx4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:03:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuSz6-0004nF-NN
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 18:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab1CARDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 12:03:33 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:42310 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776Ab1CARDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 12:03:32 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p21H2ngY013282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Mar 2011 12:02:49 -0500
In-Reply-To: <AANLkTi=sXLcVJRVH87jXvVwCth+8vGgc7Ha0=XEG0Kx4@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=9 Fuz1=9
	Fuz2=9
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p21H2ngY013282
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299603769.9908@i9G/KdNd7cD3Mce3Q/o9aQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168230>


On Tue, 2011-03-01 at 11:32 +0200, Alexei Sholik wrote:

> I guess, people who are friendly with git using the word "index"
> because it's easier to type. But it confuses an unprepared reader. The
> solution of the problem with confusion must be relevant to these
> points:
>  - clarify that "index" means the same thing as the "staging area" (in
> man if it isn't there already?)

Alas, this isn't quite true. Blobs are copied to the .git/objects
directory (which I referred to earlier as an object store without proper
qualification) with each "git add" action AND are noted in the Index at
the same time. Therefore the Index is quite literally containing
information about the blobs to be committed without containing the blobs
themselves. This is why I find any specific equivalence between Index
and "staging area" distasteful--it is misleading. 

(Yes, I made that mistake as well--helped along by a lot of third-party
documentation referring to a specific cache or a specific "staging area"
without noting that those were tools to understand the logical function
of git but did not have anything to do with implementation. When you
claim to be explaining "how something works" you should be doing just
that.)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
