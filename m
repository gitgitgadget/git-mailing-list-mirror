From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Thu, 6 Nov 2008 13:26:58 +0100
Message-ID: <20081106122658.GB4192@atjola.homenet>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106032437.GA27237@euler> <20081106095122.GA2656@atjola.homenet> <buozlkd6oh1.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 13:28:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky3yE-0007zO-J4
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 13:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbYKFM1E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 07:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbYKFM1D
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 07:27:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:57696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753366AbYKFM1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 07:27:01 -0500
Received: (qmail invoked by alias); 06 Nov 2008 12:26:59 -0000
Received: from i577BA50B.versanet.de (EHLO atjola.local) [87.123.165.11]
  by mail.gmx.net (mp005) with SMTP; 06 Nov 2008 13:26:59 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+JtV9szk2JUUnfcu8gopdLSvfwWKCnNJDXXTOVc3
	J7JGBL5ZOn28IK
Content-Disposition: inline
In-Reply-To: <buozlkd6oh1.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100233>

On 2008.11.06 21:14:18 +0900, Miles Bader wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> > git reset --hard C
> > git rebase --onto ORIG_HEAD A^
>=20
> Is that safe...?  Doesn't git-rebase also set ORIG_HEAD?

One of the first things rebase does is validating and resolving its
arguments. And that's happening before any actions that would touch
ORIG_HEAD. Though I'm not sure if it's always been like that.

Bj=F6rn
