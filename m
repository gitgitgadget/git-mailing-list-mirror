From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Usability question
Date: Thu, 17 Sep 2009 14:13:28 +0200
Message-ID: <20090917121328.GA21837@neumann>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
	<vpqy6odhn0d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rob Barrett <barrettboy@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 14:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoG6j-0008GO-6R
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 14:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbZIQM2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 08:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbZIQM2j
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 08:28:39 -0400
Received: from francis.fzi.de ([141.21.7.5]:44854 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754191AbZIQM2j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 08:28:39 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2009 08:28:39 EDT
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 17 Sep 2009 14:13:28 +0200
Content-Disposition: inline
In-Reply-To: <vpqy6odhn0d.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 17 Sep 2009 12:13:28.0214 (UTC) FILETIME=[43950B60:01CA3790]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128748>

Hi,


On Thu, Sep 17, 2009 at 12:41:06PM +0200, Matthieu Moy wrote:
> Rob Barrett <barrettboy@gmail.com> writes:
> > 1. What is the distinction that makes the 10% special enough to get
> > non-prefixed options?
>=20
> Prefixed and non-prefixed is what people usually call respectively
> "options" and "subcommands". To me, the distinction is needed:
>=20
> Options are flags that modify the behavior of a git command. For
> example, "git reset" and "git reset --hard" do something similar, but
> "git svn rebase" and "git svn dcommit" do something really, totally
> different. It's not about doing the same thing in a different way,
> it's really about different actions.

I tend to aggree, but what about 'git rebase --abort' vs. 'git rebase
--continue'?  IMHO they are also doing something totally different.


Best,
G=E1bor
