From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-log segfault on 00 graft
Date: Wed, 5 Mar 2008 06:27:49 +0100
Message-ID: <20080305052749.GA23511@atjola.homenet>
References: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:28:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWmB5-0008Vu-LY
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbYCEF1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 00:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbYCEF1x
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:27:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:44623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750931AbYCEF1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:27:52 -0500
Received: (qmail invoked by alias); 05 Mar 2008 05:27:50 -0000
Received: from i577B99FD.versanet.de (EHLO atjola.local) [87.123.153.253]
  by mail.gmx.net (mp011) with SMTP; 05 Mar 2008 06:27:50 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+MT6F7rceM86CyiW8cJEY8V/ReoU9qWQpU5FvfWM
	ThZ1XO+xHw3LQN
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76171>

On 2008.03.04 19:57:42 +0100, Jan Engelhardt wrote:
> Hi,
>=20
>=20
> I was playing a bit with grafts, and actually did this:
>=20
>   echo '839affa3313011da783b5b8074a5c9805ee8503a=20
> 0000000000000000000000000000000000000000' >.git/info/grafts
>=20
> running `git log --topo-order` causes a segfault. Yes, I probably=20
> "should not be doing that", but I think it at least should not
> segfault.

error: Could not read 0000000000000000000000000000000000000000
fatal: revision walk setup failed

That's what I get with a somewhat up-to-date version from master.

Bj=F6rn
