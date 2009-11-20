From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 03:35:40 +0100
Message-ID: <20091120023540.GA17796@atjola.homenet>
References: <005a01ca684e$71a1d710$54e58530$@com>
 <20091118142512.1313744e@perceptron>
 <008401ca6880$33d7e550$9b87aff0$@com>
 <m37htnd3kb.fsf@localhost.localdomain>
 <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com>
 <009401ca68bc$7e4b12b0$7ae13810$@com>
 <20091120014843.GB22556@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Dennie <gdennie@pospeople.com>,
	'Jason Sewall' <jasonsewall@gmail.com>,
	'Jakub Narebski' <jnareb@gmail.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 03:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBJLl-0004Jk-LW
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 03:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207AbZKTCfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 21:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758179AbZKTCfk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 21:35:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:51891 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758175AbZKTCfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 21:35:39 -0500
Received: (qmail invoked by alias); 20 Nov 2009 02:35:44 -0000
Received: from i59F57935.versanet.de (EHLO atjola.homenet) [89.245.121.53]
  by mail.gmx.net (mp008) with SMTP; 20 Nov 2009 03:35:44 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18gfVoLX4IgWWg9TAVd/LwSRe6Hzap561WifsuHAJ
	MNERuHwPzw7k+p
Content-Disposition: inline
In-Reply-To: <20091120014843.GB22556@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133298>

On 2009.11.20 04:48:44 +0300, Dmitry Potapov wrote:
> On Wed, Nov 18, 2009 at 09:03:31PM -0500, George Dennie wrote:
> >=20
> > For example, the functional notion of the repository seems well
> > defined: a growing web of immutable commits each created as either =
an
> > isolated commit or more typically an update and/or merger of one or
> > more pre-existing commits.=20
>=20
> In Git, commits are not immutable.

Commit _are_ immutable. Like all git objects (blob, tree, commits, tag)=
=2E
"Rewriting" history actually means creating a new history (adding
objects), and then changing a ref (most often a branch head) to
reference the new instead of the old history.

Bj=F6rn
