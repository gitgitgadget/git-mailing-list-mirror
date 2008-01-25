From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: managing signed-off-by lines
Date: Fri, 25 Jan 2008 09:38:53 +0100
Message-ID: <20080125083853.GA5804@diana.vm.bytemark.co.uk>
References: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIK6h-0003FH-1T
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 09:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763001AbYAYIjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 03:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762392AbYAYIjA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 03:39:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3430 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbYAYIi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 03:38:58 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIK5N-0001Yi-00; Fri, 25 Jan 2008 08:38:53 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71688>

On 2008-01-24 15:27:17 -0500, Jon Smirl wrote:

> If I import a series of patches from one of my trees into another,
> stgit preserves the signed-off-by lines like you would expect it to.
> When I export these patches it adds a signed-off-by line for myself
> again like you would expect it to. But adding this line on export
> needs to checks and make sure that my name isn't already in the
> signed-off-by list, without this check I have to manually remove my
> name when it gets duplicated.

What command are you using to export patches?

IIRC, all commands that have --sign and --ack flags already to check
for duplicates. But if you do something like have your sign-off line
in the template the export command uses, that would lead to
duplicates.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
