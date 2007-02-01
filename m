From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-blame.el
Date: Thu, 1 Feb 2007 15:26:38 +0100
Message-ID: <20070201142638.GA12980@diana.vm.bytemark.co.uk>
References: <87iren2vqx.fsf@morpheus.local> <20070201131213.GB11611@diana.vm.bytemark.co.uk> <87veimxbc6.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Feb 01 15:27:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCctt-0008BL-Nq
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 15:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbXBAO0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Feb 2007 09:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422914AbXBAO0k
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 09:26:40 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2827 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422917AbXBAO0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 09:26:39 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HCcta-0003SR-00; Thu, 01 Feb 2007 14:26:38 +0000
Content-Disposition: inline
In-Reply-To: <87veimxbc6.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38357>

On 2007-02-01 14:21:29 +0100, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> >   3. Even after I've edited a line, or added a new line, they
> >      continue to be attributed to the same existing commits. They
> >      should either have no attribution, or possibly just "local
> >      edit" or something. I seem to recall this kind of
> >      functionality for git-blame being discussed very recently?
>
> I saw it was discussed, but I don't think it was added. Currently,
> it probably makes most sense to verify that the file hasn't been
> modified, and then switch to read-only mode while viewing the blame.

Hmm, probably, yes. But it'll be kind of limiting to not be able to
run blame on a file that has local modifications. I think I understand
why vc-annotate opens a new buffer ...

> >   6. It would be nice with a keyboard shortcut for displaying (in
> >      a separate buffer) the diff to that file introduced by the
> >      commit under the cursor. This could be combined with (3) by
> >      having commit details followed by diff.
>
> As in "git log -p", you mean?

Yes. I was thinking of exactly what "git log -p $hash^..$hash"
produces. The Emacs windows should be split in two frames, with the
commit details + diff in the lower frame, just like vc-diff.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
