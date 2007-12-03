From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Mon, 3 Dec 2007 07:55:35 +0100
Message-ID: <200712030755.37038.robin.rosenberg@dewire.com>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <7v4pf0sdp7.fsf@gitster.siamese.dyndns.org> <20071203024916.GA11003@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz5CD-0005hU-9R
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXLCGyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 01:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbXLCGyE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:54:04 -0500
Received: from [83.140.172.130] ([83.140.172.130]:25249 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXLCGyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:54:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 060AA802E29;
	Mon,  3 Dec 2007 07:44:40 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13117-07; Mon,  3 Dec 2007 07:44:39 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A4A81802ABA;
	Mon,  3 Dec 2007 07:44:39 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071203024916.GA11003@coredump.intra.peff.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66879>

m=E5ndag 03 december 2007 skrev Jeff King:
> On Sun, Dec 02, 2007 at 06:40:36PM -0800, Junio C Hamano wrote:
>=20
> > > Even more useful would be to convert
> > > /path/to/repo/file to 'file' internally.
> >=20
> > ... that might help "cut & paste from file manager" people, and I t=
hink
> > we had comment session for such a patch recently on the list.
> >=20
> > Sorry, but I lost track of that the current status of that patch.  =
Did
> > it die?
>=20
> I didn't pay attention to it originally, but I assume you mean the
> recent patch from Robin Rosenberg (cc'd). Looking it over, I see one
> obvious omission: there is no canonicalization of the paths. IOW, I
> think it will break in the presence of symlinks (if I specify
> /path/to/repo/file, /path/to is a symlink to /other/path, I think the
> worktree will end up as /other/path/repo, and fail a string compariso=
n
> with /path/to/repo).

No it didn't die, it's just not worked on too often. I notes, among, ot=
her things
that it's test cases were not correct, besides needing more tests.

Symlinks were not covered.

-- robin
