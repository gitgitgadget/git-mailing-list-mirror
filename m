From: Jeff King <peff@peff.net>
Subject: Re: working prototype of orphan parent commits as datastores (was:
 Storing additional information in commit headers)
Date: Tue, 2 Aug 2011 12:57:08 -0600
Message-ID: <20110802185708.GB2499@sigill.intra.peff.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802150321.GA1390@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoK9U-0002Dl-QZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab1HBS5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 14:57:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51714
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab1HBS5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 14:57:11 -0400
Received: (qmail 32137 invoked by uid 107); 2 Aug 2011 18:57:44 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Aug 2011 14:57:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Aug 2011 12:57:08 -0600
Content-Disposition: inline
In-Reply-To: <20110802150321.GA1390@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178499>

On Tue, Aug 02, 2011 at 05:03:21PM +0200, martin f krafft wrote:

>   tig output now:
>     2011-08-02 16:52 martin f. krafft   M=E2=94=80=E2=94=90 [master] =
two
>     2011-08-02 16:54 TopGit             =E2=94=82 I TopGit data node
>     2011-08-02 16:52 martin f. krafft   I one
>     2011-08-02 16:50 martin f. krafft   M=E2=94=80=E2=94=90 [origin/m=
aster] import first prototype
>     2011-08-02 16:50 TopGit             =E2=94=82 I TopGit data node
>     2011-08-02 16:48 martin f. krafft   I Initial (empty) root commit

Look at "git show origin/master" here. It ends up as a combined diff.
Which is kind of ugly.

-Peff
