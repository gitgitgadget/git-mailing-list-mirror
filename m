From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 2/2] git-rebase.txt: clarify that --abort checks out
	<branch>
Date: Wed, 06 Jul 2011 09:25:07 -0400
Message-ID: <1309958707.10212.6.camel@drew-northup.unet.maine.edu>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
	 <1309902196.31762.30.camel@drew-northup.unet.maine.edu>
	 <alpine.DEB.2.00.1107052148370.7799@debian>  <20110706025228.GB10015@elie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 15:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeS6W-0006Do-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 15:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab1GFNZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 09:25:17 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:44213 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab1GFNZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 09:25:16 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p66DPCxR001971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Jul 2011 09:25:12 -0400
In-Reply-To: <20110706025228.GB10015@elie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p66DPCxR001971
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1310563513.50484@PYIK1vDKPKaaQ5HmYRiA8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176701>


On Tue, 2011-07-05 at 21:52 -0500, Jonathan Nieder wrote:
> Martin von Zweigbergk wrote:
> 
> > That reminds me that <branch> may not have been specified. How about
> > saying things more explicitly like this?
> >
> >   Abort the rebase operation and reset HEAD to the original branch. If
> >   <branch> was provided when the rebase operation was started, then
> >   HEAD will be reset to <branch>. Otherwise HEAD will be reset to
> >   where it was when the rebase operation was started.
> 
> Sounds great to me for what it's worth.  (With the caveat that "git
> rebase --abort" reattaches HEAD in addition to what "git reset --hard"
> would do, but I think it's fine to just leave that implied.)

Agreed, that is better.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
