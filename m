From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 18:04:14 +0100
Message-ID: <20071213170414.GA32171@diana.vm.bytemark.co.uk>
References: <20071213133653.13925.89254.stgit@krank> <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com> <20071213160432.GA30693@diana.vm.bytemark.co.uk> <b0943d9e0712130810p35b33e6aj7756b1af1922992b@mail.gmail.com> <878x3yr1ka.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Dec 13 18:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2rUM-0003KN-5Q
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 18:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764195AbXLMREV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 12:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764117AbXLMREU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 12:04:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1115 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764008AbXLMRET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 12:04:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J2rTq-0008Oa-00; Thu, 13 Dec 2007 17:04:14 +0000
Content-Disposition: inline
In-Reply-To: <878x3yr1ka.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68177>

On 2007-12-13 17:39:49 +0100, David K=E5gedal wrote:

> I'd be much more interested in a flag that prevents me from running
> "git rebase" on a stg-controlled branch by mistake...

In the long run, we probably want to figure out a good set of hooks in
git that would let us know when interesting stuff happens. And then
add them. The challenge will be to keep the number of hooks down.

In the short run, we need a general "undo" command. (I've got one on
the drawing board. Just need to set aside some time ...)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
