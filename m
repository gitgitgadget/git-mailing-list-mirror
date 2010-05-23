From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: gitignore - how to ignore only in current directory
Date: Sun, 23 May 2010 22:36:51 +0200
Message-ID: <20100523203651.GA13942@atjola.homenet>
References: <AANLkTilGH-Z4IpgosqYPFCl3G2XsKDfAT3pH6vi-wuN8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Sun May 23 22:37:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGHuw-0006hW-Jj
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 22:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab0EWUg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 16:36:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:60117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754154Ab0EWUg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 16:36:56 -0400
Received: (qmail invoked by alias); 23 May 2010 20:36:55 -0000
Received: from i59F570AF.versanet.de (EHLO atjola.homenet) [89.245.112.175]
  by mail.gmx.net (mp058) with SMTP; 23 May 2010 22:36:55 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19orxQ2MvRoY5B9TfftFfr27H2p4KYwezdTa0gTYb
	t59VCQj+Oitdf4
Content-Disposition: inline
In-Reply-To: <AANLkTilGH-Z4IpgosqYPFCl3G2XsKDfAT3pH6vi-wuN8@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147584>

On 2010.05.23 21:28:39 +0100, Howard Miller wrote:
> I want to ignore a particular file name in a particular directory.
> However, the same filename may appear in subdirectories and in those
> cases I do *not* want it ignored.

If the pattern contains a non-trailing slash, then the pattern is
matched against the whole path (relative to the directory the .gitignor=
e
file is in), not just against the filename relative to its parent
directory. So if you want to ignore "foo" only in the directory the
=2Egitignore file is in use "/foo" (without the quotes).

Bj=F6rn
