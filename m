From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/3] Auto-generate man pages for all StGit commands
Date: Thu, 11 Sep 2008 08:58:32 +0200
Message-ID: <20080911065832.GA6409@diana.vm.bytemark.co.uk>
References: <20080908210302.1957.44280.stgit@yoghurt> <20080908210758.1957.664.stgit@yoghurt> <b0943d9e0809101456w3c74b86fm9d311fb2594bcf4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 08:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdfo5-0002hm-Vy
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 08:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYIKGg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2008 02:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYIKGg0
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 02:36:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2841 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYIKGgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 02:36:25 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kdg8O-0001hj-00; Thu, 11 Sep 2008 07:58:32 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809101456w3c74b86fm9d311fb2594bcf4f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95587>

On 2008-09-10 22:56:55 +0100, Catalin Marinas wrote:

> On 08/09/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Auto-generate man pages based on the docs that are in each
> > stgit/commands/<cmd>.py file. That doc format is extended in order
> > to support both brief command help output and manpage text.
>
> Really great stuff. Thanks.

Glad you like it. Now all we have to do is feed the system with
high-quality input ... :-)

> I can see a slight difference in behaviour but I don't have any
> issue with it - previously "stg help <cmd>" showed the full
> description while "stg <cmd> --help" only the short one.

Yes, that's intentional. I tried to say something about it in the
commit message, but I guess I didn't do a very good job about it.

The interactive help now uses only the one-line command description;
the multiline description goes only to the man page/html. There are
two reasons for this:

  1. The interactive help should be short and sweet. If the user wants
     to spend a minute or more learning about a command, she is better
     served by the "real" reference docs.

  2. The multiline descriptions (both for the command itself and for
     its flags) contain, or should contain, asciidoc markup. If we
     wanted to display this text in the interactive help we'd need to
     at least be able to strip the markup out, something which I
     haven't even tried to do.

> An additional point on naming - should we use StGIT or StGit? The
> original name was StGIT since GIT looked like an acronym. It looks
> like now more people name it Git hence our tool moved slowly into
> StGit but not everywhere. I personally like StGIT but the last 3
> letters should really be the same as the official git (Git, GIT).

As you may or may not have noticed, I'm responsible for the vast
majority of "StGit"s. I prefer it because "git" isn't really an
acronym, and I happen to like camel case ... :-)

You're right that we ought to standardize on one of the spellings,
though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
