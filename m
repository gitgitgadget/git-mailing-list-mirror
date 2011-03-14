From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] Clarify: rebase abort leaves <branch> checked-out
Date: Mon, 14 Mar 2011 07:40:32 -0400
Message-ID: <1300102832.5129.17.camel@drew-northup.unet.maine.edu>
References: <1300035258.5129.12.camel@drew-northup.unet.maine.edu>
	 <7vtyf6hkpo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"Johannes E. Schindelin" <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 12:41:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz69P-0003ac-Jh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 12:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab1CNLlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 07:41:22 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:38702 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab1CNLlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 07:41:22 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2EBeZm9014475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Mar 2011 07:40:40 -0400
In-Reply-To: <7vtyf6hkpo.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2EBeZm9014475
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300707640.70529@4Q/ryDU0lXqmeyA4dT1moA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168985>


On Sun, 2011-03-13 at 12:41 -0700, Junio C Hamano wrote:
> Drew Northup <drew.northup@maine.edu> writes:
> 
> > -The latter form is just a short-hand of `git checkout topic`
> > -followed by `git rebase master`.
> > +*NOTE:* The latter form is just a short-hand of `git checkout topic`
> > +followed by `git rebase master`. If the rebase is aborted `topic` will 
> > +remain the checked-out branch.
> 
> The behaviour is consistent between the case where "this on that" form
> succeeds and it stops and gets aborted, and I think both are euqally
> noteworthy.  So I'd suggest dropping "if aborted".

So a synthetic look at that might be:

-If the rebase is aborted
+When rebase exits

Comments?

I'll see about re-rolling likewise (and on something with a more recent
runtime!).

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
