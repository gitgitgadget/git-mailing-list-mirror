From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Some ideas for StGIT
Date: Mon, 6 Aug 2007 11:56:23 +0200
Message-ID: <20070806095623.GA23349@diana.vm.bytemark.co.uk>
References: <1186163410.26110.55.camel@dv> <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:57:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHzKt-0006W0-0q
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760752AbXHFJ5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 05:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755701AbXHFJ5K
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:57:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2501 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbXHFJ5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:57:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IHzK3-0006UM-00; Mon, 06 Aug 2007 10:56:23 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55133>

On 2007-08-06 10:36:25 +0100, Catalin Marinas wrote:

> On 03/08/2007, Pavel Roskin <proski@gnu.org> wrote:
>
> > Another approach would be to reexamine the patch after "stg
> > refresh -es" and to apply it instead of the original patch. If the
> > patch doesn't apply, the options would be to discard the edits or
> > to re-launch the editor.
>
> That's an interesting idea but maybe we should have a separate
> command like --edit-full to edit the full patch + log (part of the
> functionality already available in import).

I never really understood why commit message editing had to be part of
the "refresh" command. If it were a separate command and not tied to
refresh, we could allow editing the message (and author, committer,
date, ...) of any commit in the stack -- since the tree objects would
be unchanged, we could just reuse the same tree objects when rewriting
the commit objects on top of it.

That's obviously not going to work if we allow editing of the patch.
But patch editing isn't a good fit as a refresh switch either, since
it's not at all related to replacing the tree of the current patch
with the working tree.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
