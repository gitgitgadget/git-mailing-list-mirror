From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase -i onto HEAD~n
Date: Tue, 3 Feb 2009 18:04:57 +0100
Message-ID: <20090203170457.GB6859@atjola.homenet>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com> <20090203154457.GA6859@atjola.homenet> <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCA0@ELON17P32001A.csfb.cs-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Bisani, Alok" <alok.bisani@credit-suisse.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:07:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOjX-0003WT-6t
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbZBCRFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 12:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbZBCRFE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:05:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:55151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754343AbZBCRFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:05:03 -0500
Received: (qmail invoked by alias); 03 Feb 2009 17:04:59 -0000
Received: from i577B9B17.versanet.de (EHLO atjola.local) [87.123.155.23]
  by mail.gmx.net (mp057) with SMTP; 03 Feb 2009 18:04:59 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19YZ9wqljJYj9W397GbWoRSC/b1apXUdeiTHLJQP3
	evRMa4Nhe4lsSX
Content-Disposition: inline
In-Reply-To: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCA0@ELON17P32001A.csfb.cs-group.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108217>

On 2009.02.03 16:22:22 -0000, Bisani, Alok wrote:
> >And in the editor:
> >pick HEAD~2
> >squash HEAD
>=20
>     # Leave editor for ~/gittest/.git/rebase-merge/git-rebase-todo wi=
th
>     squash 8df4c33 two
>     # deleted line with discard
>     squash 91f8267 three

Notice the difference? You're trying to squash 8df4cee into nothing. An=
d
_if_ that would work, it would still squash 8df4c33 into the previous
commit, which is not what you wanted anyway.

Bj=F6rn
