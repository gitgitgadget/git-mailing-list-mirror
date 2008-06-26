From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-diff/git-format-patch safe for GNU (or POSIX) patch?
Date: Thu, 26 Jun 2008 14:49:27 +0200
Message-ID: <20080626124927.GA17731@diana.vm.bytemark.co.uk>
References: <58230.213.203.159.164.1214476059.squirrel@upmail.polettix.it> <20080626103607.GA16525@diana.vm.bytemark.co.uk> <58284.213.203.159.164.1214480989.squirrel@upmail.polettix.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Flavio Poletti <flavio@polettix.it>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:50:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqw2-0006Ip-GK
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761314AbYFZMtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760876AbYFZMtl
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:49:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4569 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761309AbYFZMtj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:49:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KBqul-0004me-00; Thu, 26 Jun 2008 13:49:27 +0100
Content-Disposition: inline
In-Reply-To: <58284.213.203.159.164.1214480989.squirrel@upmail.polettix.it>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86448>

On 2008-06-26 13:49:49 +0200, Flavio Poletti wrote:

> Importing wasn't actually an issue, just a matter of
> init/add/commit. I was more scared about the patch production
> process, i.e. producing a patch that could be perfectly usable by
> the project's maintainers. But given what you kindly said, I think I
> can dismiss this as excess of caution by me.

Yes, patch is one of the most permissive programs around. It will eat
_anything_. (And throw up on the carpet if it was just too wrong.)

There are two things in git patches that patch won't grok: rename/copy
patches, and binary patches. Neither feature is on by default, IIRC --
you have to give command line flags -- precisely so that "git diff"
default output will be patch compatible.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
