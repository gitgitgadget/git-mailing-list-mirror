From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] add -p: warn if only binary changes present
Date: Sun, 26 Oct 2008 11:40:06 +0100
Message-ID: <20081026104006.GA18969@neumann>
References: <1224884916-20369-1-git-send-email-trast@student.ethz.ch>
	<20081026051013.GD21178@coredump.intra.peff.net>
	<200810261128.14735.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 26 11:41:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku33v-00032a-N8
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 11:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbYJZKkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 06:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYJZKkW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 06:40:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:61711 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbYJZKkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 06:40:21 -0400
Received: from [127.0.1.1] (p5B133467.dip0.t-ipconnect.de [91.19.52.103])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1Ku32V2HV5-0000Rm; Sun, 26 Oct 2008 11:40:08 +0100
Content-Disposition: inline
In-Reply-To: <200810261128.14735.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX19v7F1yv8PbOXb+e3oH3tNJvQQf0NRTpuArpnn
 JAXflTc/GXQFT/nb5G1oHxvUZxZAzO1j4tCfvT73r4k0+mm+w/
 KcpgoNtNnx3Bc8uPT+FtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99156>

On Sun, Oct 26, 2008 at 12:28:09PM +0200, Thomas Rast wrote:
> Jeff King wrote:
> > > +			print STDERR "No changes except to binary files.\n";
> >   No changed text files.
> I tried to make a more precise statement.  "No changed text files"
> also holds if no files at all were changed.  A user can only infer
> that there _are_ binary changes if he knows that the message in the
> latter case would have been "No changes".
>=20
> That being said, it is somewhat awkward, I just couldn't come up with
> a better message with this meaning.
What about

   Only binary files changed.

or something of the sort?

G=E1bor
