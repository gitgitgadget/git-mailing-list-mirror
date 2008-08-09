From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Sat, 9 Aug 2008 11:56:05 +0200
Message-ID: <20080809095605.GA10804@diana.vm.bytemark.co.uk>
References: <20080808204348.7744.46006.stgit@yoghurt> <20080808204829.7744.11661.stgit@yoghurt> <7vk5erb3ru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 11:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRkqs-0008MD-K1
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 11:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbYHIJeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 05:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYHIJeH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 05:34:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3857 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbYHIJeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 05:34:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KRlB7-00037f-00; Sat, 09 Aug 2008 10:56:05 +0100
Content-Disposition: inline
In-Reply-To: <7vk5erb3ru.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91758>

On 2008-08-08 14:22:45 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > In addition to accepting lines with one or more commits, it now
> > accepts lines with precisely two trees.
>
> Hmm, slightly dissapointed (I actually was hoping you would also
> handle more than two trees and run -m or -c or --cc on them).

I decided to not attempt that -- I'm unsure enough of my git
programming skills that I decided the smaller jump would provide
sufficient material for constructive criticism. And, perhaps more
importantly, I personally don't have a need for anything beyond what I
implemented. (And, I'm not burning any bridges -- the multiple-tree
forms can be added in the future. Along with handling them on the
command line too, hopefully.)

> But the following two sentences are a bit confusing, especially it
> is unclear what "This" refers to in the last sentence.
>
> > When diffing trees, the -m, -s, -v, --pretty, --abbrev-commit,
> > --encoding, --no-commit-id, -c, --cc, and --always options are
> > ignored, since they do not apply to trees. This is the same
> > behavior you get when specifying two trees on the command line
> > instead of with --stdin.
>
> Perhaps swap the sentences in the log message like this?
>
>   When feeding trees on the command line, you can give exactly two
>   trees, not three nor one; --stdin now supports this "two tree"
>   form on its input, in addition to accepting lines with one or more
>   commits.
>
>   When diffing trees (either specified on the command line or from
>   the standard input), the -m, -s, -v, --pretty, --abbrev-commit,
>   --encoding, --no-commit-id, -c, --cc, and --always options are
>   ignored, since they do not apply to trees.

Will do. Thanks.

> Thanks, now we can update that documentation change.

I think your doc patch is obsoleted by my patch. I'll make sure it's
all taken care of in the resend.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
