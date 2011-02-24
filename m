From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: complete "git diff ...branc<TAB>"
Date: Thu, 24 Feb 2011 14:58:21 +0100
Message-ID: <20110224135821.GA14720@neumann>
References: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
	<4D664E19.5080804@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 14:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsbiD-0006NJ-0V
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 14:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217Ab1BXN6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 08:58:30 -0500
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:13709 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab1BXN62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 08:58:28 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 24 Feb
 2011 14:58:20 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 24 Feb
 2011 14:58:21 +0100
Content-Disposition: inline
In-Reply-To: <4D664E19.5080804@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167805>

On Thu, Feb 24, 2011 at 01:24:57PM +0100, Michael J Gruber wrote:
> Reminds me fo the following: Typing
>=20
> git log origin/next@{1}..o<TAB>
>=20
> gives
>=20
> git log origin/next{1}..o
>=20
> WTF? Completion eats at babies!

Interesting, I can't seem to be able to reproduce.

  git log origin/next@{1}..o<TAB>

gives me

  git log origin/next@{1}..origin/

and a TAB after that gives me all the remote branches from origin, as
it is supposed to, leaving the @{1} intact.

Which git, bash, and bash completion versions are you using?


Best,
G=E1bor
