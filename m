From: SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 0/2] merge --summary vs. merge.summary
Date: Thu, 3 Apr 2008 13:03:59 +0200
Message-ID: <20080403110359.GE32119@neumann>
References: <1207213396-17370-1-git-send-email-szeder@ira.uka.de> <20080403103056.GD6673@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhNFQ-0000QV-Il
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 13:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbYDCLEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 07:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYDCLED
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 07:04:03 -0400
Received: from francis.fzi.de ([141.21.7.5]:14849 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753893AbYDCLEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 07:04:02 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Apr 2008 13:03:59 +0200
Content-Disposition: inline
In-Reply-To: <20080403103056.GD6673@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-OriginalArrivalTime: 03 Apr 2008 11:03:59.0006 (UTC) FILETIME=[6AC763E0:01C8957A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78745>

Hi Jeff,

On Thu, Apr 03, 2008 at 06:30:56AM -0400, Jeff King wrote:
> On Thu, Apr 03, 2008 at 11:03:14AM +0200, SZEDER G=E1bor wrote:
>=20
> > So the '--summary' option controls the printing of diffstat, while =
the
> > 'merge.summary' config variable controls the behaviour of 'fmt-merg=
e-msg',
>=20
> Think that --diffstat is probably a better name. But your series
> actually _changes_ the meaning of --summary, which is probably a bad
> idea for people who have scripted around these.
>=20
> The problem is that you have two concepts with the same name; giving =
one
> of the concepts the name means that the other concept breaks.
Well, I agree with you, and I had the same concerns you expressed
here.

>   2. merge.summary becomes merge.something_else, along with
>      --something-else support. merge.summary remains as a compatibili=
ty
>      option for merge.something_else.
>
> Though I can't think of a good "something_else".
Me neither.

> Given that there isn't
> even a command-line equivalent to merge.summary now, maybe just leave=
 it
> as merge.summary
I think that the name of the command-line option and the config
variable should be in sync, so having merge.sync and --something-else
is probably not a good idea.  Furthermore, I think it should also be
sync with the options of fmt-merge-msg.


Regards,
G=E1bor
