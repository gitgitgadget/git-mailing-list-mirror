From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Is rebase always destructive?
Date: Mon, 1 Dec 2008 21:19:03 +0100
Message-ID: <200812012119.03372.robin.rosenberg.lists@dewire.com>
References: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu> <20081201121140.GB32415@mail.local.tull.net> <slrngj8884.2srb.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Mon Dec 01 21:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7FFt-0006wk-N5
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 21:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYLAUTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2008 15:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYLAUTM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 15:19:12 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:56197 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751566AbYLAUTL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 15:19:11 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A9795004F6C056; Mon, 1 Dec 2008 21:19:04 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <slrngj8884.2srb.csaba-ml@beastie.creo.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102080>

m=E5ndag 01 december 2008 18:37:43 skrev Csaba Henk:
> On 2008-12-01, Nick Andrew <nick@nick-andrew.net> wrote:
> > On Mon, Dec 01, 2008 at 11:41:39AM +0000, Csaba Henk wrote:
> >> I can't see any option for rebase which would yield this cp-like
> >> behaviour. Am I missing something?
> >
> > How about this:
> >
> > git checkout topic
> > git branch keepme
> > git rebase master
>=20
> OK, thanks guys, now I'm enlightened (a little bit more than before).

And if you forgot to create the keepme branch you can access the previo=
us
version using the topic@{1} or topic@{'1 hour ago'} etc. This uses the =
reflog
that tracks all "versions" of your branch. Keeping gitk running is nice=
 way
to see previous versions (press F5 after rebase).

-- robin
