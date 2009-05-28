From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: display git prompt in case of merge conflict
	during rebase
Date: Thu, 28 May 2009 19:01:47 +0200
Message-ID: <20090528170147.GN6570@neumann>
References: <1243527441-3394-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 28 19:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9izN-0001R6-1A
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759180AbZE1RBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 13:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758400AbZE1RBr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 13:01:47 -0400
Received: from francis.fzi.de ([141.21.7.5]:40560 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756771AbZE1RBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 13:01:46 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 19:01:47 +0200
Content-Disposition: inline
In-Reply-To: <1243527441-3394-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 28 May 2009 17:01:47.0623 (UTC) FILETIME=[FC915F70:01C9DFB5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120199>

On Thu, May 28, 2009 at 06:17:21PM +0200, SZEDER G=E1bor wrote:
> Since e5dd864a (completion: Better __git_ps1 support when not in
> working directory, 2009-02-11) the git prompt becomes empty, if we hi=
t
> a merge conflict during a rebase.
>=20
> e5dd864a added an if statement at the end of __git_ps1 to only displa=
y
> anything in the prompt, if the branch name is not empty.  This caused
> the empty prompt in the "merge conflict during rebase" case, because
> in this case we display neither the branch name nor the abbreviated
> SHA1, the ongoing rebase is identified.
       ^- although...
