From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 17:06:54 +0200
Message-ID: <5053480E.2010002@viscovery.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov> <50532B35.9050607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 17:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCXUB-0004rO-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 17:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062Ab2INPHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 11:07:04 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:22535 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531Ab2INPHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 11:07:02 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TCXTq-0000Na-SE; Fri, 14 Sep 2012 17:06:55 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 992411660F;
	Fri, 14 Sep 2012 17:06:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <50532B35.9050607@drmicha.warpmail.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205493>

Am 9/14/2012 15:03, schrieb Michael J Gruber:
> "git replaces $Id$... upon checkout.  Any byte sequence that begins
> with $Id: and ends with $ in the worktree file is replaced with $Id$
> upon check-in."
> 
> Now, the there are two problems after you add $Id$ and check-in
> (commit):
> 
> - commit does not check out, i.e. your work-tree copy is not updated 
> with expanded $Id$ - Not even "git checkout thatFile" updates your
> work-tree copy.
> 
> The first one could be considered OK, but at least the second one
> seems to be a bug. Together they create the following problem: Say,
> you've corrected that problem (rm that file and checkout) and then
> update your file, add and commit. It will keeping having the old (now
> wrong) Id expansion.

If EOL conversion or a clean filter was applied during 'git add file', is
the version in the worktree suddenly wrong? Of course, not.

I would place $Id$ treatment in the same ball park and declare it as a
mistake of the editor that it did not remove the now "wrong" SHA1 from $Id:$.

> We should do something about this.

Not necessary, IMHO.

-- Hannes
