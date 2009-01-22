From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Added basic bash completion script for StGit.
Date: Thu, 22 Jan 2009 17:18:23 +0100
Message-ID: <20090122161823.GB15074@diana.vm.bytemark.co.uk>
References: <1232405879-6188-1-git-send-email-ted@tedpavlic.com> <497509A2.5020101@tedpavlic.com> <49750E4B.3000203@tedpavlic.com> <20090122160350.GA15074@diana.vm.bytemark.co.uk> <49789A1F.8010203@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "catalin.marinas" <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2HZ-0004Vl-AS
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZAVQS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 11:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbZAVQS2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:18:28 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1334 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZAVQS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:18:28 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LQ2G7-0004Eg-00; Thu, 22 Jan 2009 16:18:23 +0000
Content-Disposition: inline
In-Reply-To: <49789A1F.8010203@tedpavlic.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106759>

On 2009-01-22 11:09:03 -0500, Ted Pavlic wrote:

> The only downside is that it's a little harder to keep track of when
> the completion script changes (e.g., when you have made your own
> local changes).

It's a generated file -- you're not supposed to edit it! Wouldn't it
be a better idea to edit the program that generates it instead?

> However, the method you use provides very *fast* completion (as
> opposed to git and hg completion, which generate their keywords on
> the fly and thus run relatively slowly).

Yes, I was always irritated by how slow the StGit completion was
compared to git's. Python sucks in this respect.

> HOWEVER, please see the threads (which modify the Python that
> generates the script):

Yes, I'll take a look.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
