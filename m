From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-relink doesn't work on bare repos
Date: Tue, 4 Mar 2008 08:34:13 -0600
Message-ID: <200803040834.14099.jgoerzen@complete.org>
References: <slrnfsp5vi.sa5.jgoerzen@katherina.lan.complete.org> <BAYC1-PASMTP07875E628BE4BA7D43175FAE100@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYEL-0004tZ-RR
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761152AbYCDOeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbYCDOeS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:34:18 -0500
Received: from gatekeeper.excelhustler.com ([69.44.136.67]:38976 "EHLO
	excelhustler.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760948AbYCDOeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:34:16 -0500
Received: from jgoerzen by wile.internal.excelhustler.com with local (Exim 4.68)
	(envelope-from <jgoerzen@complete.org>)
	id 1JWYDe-0005f6-4S; Tue, 04 Mar 2008 08:34:14 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <BAYC1-PASMTP07875E628BE4BA7D43175FAE100@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76089>

On Tue March 4 2008 1:09:59 am Sean wrote:

> It should probably fixed to work as you would expect.   But if your bare

Yep, agreed there.

> repos follow the general naming convention of ending in .git  relink will
> work.  That is, if your bare repos are named  repo.git  rather than just
> repo.

I never do that because I think it's silly to have to type .git everytime ;-)

If I give people a git:// url, they already know it's a Git repo, I figure.

-- John
