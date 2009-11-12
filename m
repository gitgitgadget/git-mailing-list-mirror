From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: Idea for git-touch
Date: Thu, 12 Nov 2009 18:18:01 +0100
Message-ID: <200911121818.02502.barra_cuda@katamail.com>
References: <4AFC348B.4000202@ualg.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?q?Lu=EDs_Sousa?= <llsousa@ualg.pt>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8dFe-0002ur-1N
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZKLROT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 12:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbZKLROT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:14:19 -0500
Received: from smtp1-pc.aruba.it ([62.149.157.181]:59242 "HELO
	smtp1-pc.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752955AbZKLROS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 12:14:18 -0500
Received: (qmail 13791 invoked by uid 89); 12 Nov 2009 17:14:18 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00 autolearn=ham
	version=3.2.3
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.113.211)
  by smtp1-pc with SMTP; 12 Nov 2009 17:14:18 -0000
User-Agent: KMail/1.11.4 (Linux/2.6.31.5-smp; KDE/4.2.4; i686; ; )
In-Reply-To: <4AFC348B.4000202@ualg.pt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132788>

On Thursday 12 November 2009, Lu=EDs Sousa wrote:
> I normally do commits when something works or on the end of the day,=20
> just to record what have doing. On other day, when I consider that is=
=20
> done/working I do a rebase -i squashing everything on one commit. The=
=20
> date of that commit will be preserved and is the date of the first=20
> commit. Then I do a git-reset HEAD~1, git-add . and git-commit with t=
he=20
> same message to have the current date.

git rebase -i <...>
git rebase --ignore-date <...>

should do what you need.
