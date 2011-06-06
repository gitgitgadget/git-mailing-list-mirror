From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 12:40:16 -0400
Message-ID: <1307378417.4321.25.camel@drew-northup.unet.maine.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	 <4DEC8322.6040200@drmicha.warpmail.net>
	 <201106061419.34599.jnareb@gmail.com>
	 <7v8vtf9bds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:41:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcrJ-0004UD-5X
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab1FFQkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:40:51 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:52581 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1FFQku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:40:50 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p56GeLYD009684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Jun 2011 12:40:21 -0400
In-Reply-To: <7v8vtf9bds.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=6 Fuz1=6
	Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p56GeLYD009684
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307983222.2739@ocmmBJTczsLrD8wTaY9unw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175136>


On Mon, 2011-06-06 at 09:23 -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > On Mon, 6 June 2011, Michael J Gruber wrote:
> >
> > So what you suggest would make
> >
> >   $ git diff NEXT WTREE
> >
> > behave differently from
> >
> >   $ git diff
> >
> > and
> >
> >   $ git diff HEAD NEXT
> >
> > behave differently from
> >
> >   $ git diff --cached
> >
> > Do you really think that it is good idea?
> 
> I do not know if Michael is suggesting to make it different, but if the
> difference is an improvement, it may be a good thing. Being different from
> the current behaviour should not be a basis for automatic rejection ---
> otherwise we won't make any progress.
> 
> I just don't know what the plans by advocates of this NEXT/WTREE are for
> conflicted cases [*1*] to tell how they want to make the user experience, so I
> cannot even tell if they want something different, let alone to judge if
> the proposed difference is an improvement.
> 
> [Footnote]
> 
> *1* There may be other equally important corner cases, but let's tackle
> one simple and obvious thing first to see where this goes.

Given the history of the thread including this:
http://article.gmane.org/gmane.comp.version-control.git/172220

I'd prefer not introducing any more global pseudo-refs....

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
