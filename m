From: Jeff King <peff@peff.net>
Subject: Re: git-svn authors file and =?utf-8?Q?SVN?=
 =?utf-8?B?IHVzZXJzIHdpdGgg4oCYPeKAmQ==?= in the username
Date: Mon, 28 Jul 2014 16:07:44 -0400
Message-ID: <20140728200744.GA18098@peff.net>
References: <dc3fda62c3e94eba9d29fd4b34f2e7cc@EXCHLONDON2013.zoo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Braden <David.Braden@softwire.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:07:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBrD7-0008Bw-OW
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 22:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaG1UHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 16:07:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:41983 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751027AbaG1UHt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 16:07:49 -0400
Received: (qmail 31412 invoked by uid 102); 28 Jul 2014 20:07:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 15:07:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 16:07:44 -0400
Content-Disposition: inline
In-Reply-To: <dc3fda62c3e94eba9d29fd4b34f2e7cc@EXCHLONDON2013.zoo.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254354>

On Mon, Jul 28, 2014 at 11:33:23AM +0000, David Braden wrote:

> I=E2=80=99m creating a git clone of a svn repository and am trying to=
 set up
> an authors file to map between the svn users and our git usernames.
> The svn repository uses the full subject line of a ssl certificate fo=
r
> the user id and so it contains =E2=80=98=3D=E2=80=99 which causes the=
 authors file to be
> parsed incorrectly as it splits on the first equals.
> [...]
> How can I work around this limitation?

I have not tried it, but I suspect --authors-prog might work, as it
passes the name as an argument to the program.

-Peff
