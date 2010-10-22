From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Fri, 22 Oct 2010 22:16:25 +0200
Message-ID: <1287778585.2025.14.camel@localhost.localdomain>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <vpq8w1v5gce.fsf@bauges.imag.fr> <buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
	 <8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
	 <AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
	 <6FCE62E3-A27E-43D6-9FDF-0133ABD851C2@wincent.com>
	 <AANLkTinGuVm8gib9r7omVV9hHw8B-iBQGgsv+b6wb5=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 22:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9OFq-0002fk-QF
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 22:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab0JVUaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 16:30:15 -0400
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:53381 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab0JVUaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 16:30:14 -0400
X-Greylist: delayed 824 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2010 16:30:14 EDT
Received: from [212.123.169.34] (helo=[192.168.1.99])
	by smtp-out2.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1P9O2P-0006Bo-PT; Fri, 22 Oct 2010 22:16:29 +0200
In-Reply-To: <AANLkTinGuVm8gib9r7omVV9hHw8B-iBQGgsv+b6wb5=Q@mail.gmail.com>
X-Mailer: Evolution 2.91.1 (2.91.1-1.fc15) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159746>

On Tue, 2010-10-19 at 11:09 -0400, Eugene Sajine wrote:
> There should be some different consistent and not inter-crossing
> naming for the origin's master branch (on the remote side), for the
> local origin/master and for local master that is a tracking branch.
> The only way i found so far to explain this is actually via the naming
> syntax where having / in the name of the branch means remote branch. I
> was a bit surprised that i can create a local branch with a slash in
> the name - probably it should be prohibited.

Allowing local branches with a slash in their name is a feature I use
heavily. Ie, in general my local repositories use this scheme:

$ git branch
* master
  $BRANCH_F00
  $USER/$TOPIC_FOO
  $USER/$TOPIC_BAR
  [...]
  $USER/$TOPIC_BAZ

This makes it trivial to quickly distinguish my (local) work from other
people's (remote) work. Does the benefit of naming clarity justify
prohibiting that scheme?


Paul Bolle
