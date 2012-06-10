From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Sun, 10 Jun 2012 17:24:31 +1000
Message-ID: <20120610072431.GA20320@bloggs.ozlabs.ibm.com>
References: <1339122742-28677-1-git-send-email-martin@laptop.org>
 <4FD31476.90104@in.waw.pl>
 <7v8vfvbrjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdcW8-0008Lv-F2
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 09:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab2FJHYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 03:24:51 -0400
Received: from ozlabs.org ([203.10.76.45]:43528 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab2FJHYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 03:24:51 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 54660B6FD3; Sun, 10 Jun 2012 17:24:49 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <7v8vfvbrjt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199572>

On Sat, Jun 09, 2012 at 11:37:58PM -0700, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
> > On 06/08/2012 04:32 AM, Martin Langhoff wrote:
> >> git log -G'regex' is a very usable alternative to the classic
> >> pickaxe. Minimal patch to make it usable from gitk.
> >
> >>      set gm [makedroplist .tf.lbar.gdttype gdttype \
> >>  		[mc "containing:"] \
> >>  		[mc "touching paths:"] \
> >> -		[mc "adding/removing string:"]]
> >> +		[mc "adding/removing string:"] \
> >> +		[mc "changes match regex:"]]
> >
> > Hi,
> >
> > this feature is definitely useful. One nitpick: the string that you=
 add
> > becomes part of a sentence in the GUI: "prev/next commit changes ma=
tch
> > regex", which is in different grammatical form then the existing
> > snippets. Should be something with '-ing'.
>=20
> "prev/next commit with changes matching regex" perhaps?

There is already the drop-down list to select exact, case-ignoring or
regexp matching.  I would think that "adding/removing string" combined
with "Regexp" matching should select this.

What exactly does git log -G do?

Paul.
