From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Feature request: option to not fetch tags for 'git remote'
 branches
Date: Wed, 24 Mar 2010 22:35:57 +0100
Message-ID: <20100324213557.GA15639@atjola.homenet>
References: <201003242154.29245.elendil@planet.nl>
 <4BAA7F5B.2040400@feurix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: John Feuerstein <john@feurix.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuYFM-0002GG-BJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab0CXVgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 17:36:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:45860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751164Ab0CXVgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:36:06 -0400
Received: (qmail invoked by alias); 24 Mar 2010 21:36:02 -0000
Received: from i59F5783B.versanet.de (EHLO atjola.homenet) [89.245.120.59]
  by mail.gmx.net (mp011) with SMTP; 24 Mar 2010 22:36:02 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+JHIgmCTKJsEziXFusbsTwX7UmyJf/ll6G1tb/f/
	3jiBpHfnPXjK4J
Content-Disposition: inline
In-Reply-To: <4BAA7F5B.2040400@feurix.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143130>

On 2010.03.24 22:08:43 +0100, John Feuerstein wrote:
> Hello Frans,
>=20
> > It would be great to be able to tell 'git remote' to skip tags and =
only=20
> > fetch the requested branch. A --no-tags option maybe?
> >=20
> > AFAIK this is currently not possible, although I'd happy to be prov=
en=20
> > wrong.
>=20
> have a look at -n, --no-tags provided by git-fetch, ie.
>=20
> $ git remote add ... foo ...
> $ git fetch -n foo

And you can set remote.<name>.tagopt to --no-tags to make that the
default.

Bj=F6rn
