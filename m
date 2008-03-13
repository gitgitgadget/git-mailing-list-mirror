From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Thu, 13 Mar 2008 13:00:16 -0400
Message-ID: <20080313170016.GA3439@sigill.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZqna-0001K6-1V
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbYCMRAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 13:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYCMRAT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:00:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2614 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbYCMRAS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:00:18 -0400
Received: (qmail 15561 invoked by uid 111); 13 Mar 2008 17:00:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 13 Mar 2008 13:00:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 13:00:16 -0400
Content-Disposition: inline
In-Reply-To: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77104>

On Thu, Mar 13, 2008 at 05:40:19PM +0100, Samuel Tardieu wrote:

> Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
> messages generated with git-format-patch. Without it, messages genera=
ted
> without using --attach or --inline didn't have any content type infor=
mation.
>=20
> I got hit with this problem yesterday when sending a patch to linux-k=
ernel
> with a commit message containing the name "P=C3=A1draig" in it. Moreo=
ver,
> the mailing-list software added an incorrect ISO-8859-1 encoding info=
rmation
> which mangled P=C3=A1draig's name.

It's supposed to handle this automatically if the commit message
contains non-ascii characters. What version of git were you using?

-Peff
