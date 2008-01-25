From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: premerge hooks and preventing errors
Date: Fri, 25 Jan 2008 09:43:28 +0100
Message-ID: <20080125084328.GB5804@diana.vm.bytemark.co.uk>
References: <9e4733910801241232j58974193i5ec0a618376c2415@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIKAg-0004O5-Q4
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 09:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764449AbYAYInf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 03:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762398AbYAYIne
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 03:43:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1569 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759425AbYAYInd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 03:43:33 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIK9o-0001ZO-00; Fri, 25 Jan 2008 08:43:28 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801241232j58974193i5ec0a618376c2415@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71690>

On 2008-01-24 15:32:40 -0500, Jon Smirl wrote:

> What's the status of using premerge hooks to stop git merge/pull
> from messing up stgit? I just messed up another stgit tree by doing
> git pull on it. I've learned how to fix this by rolling back the
> head, but this mistake is way too easy to make.

I decided that while such hooks would be useful, it'd be even more
useful to have "stg undo" which could undo every kind of mistake,
including this one -- so I decided to build "stg undo" first. And I
still haven't quite started. :-) I do have the design more or less
finished, though.

> Even though I'm aware that this mistake is possible and I'm still
> making it. When you have a mix of git and stgit trees it is very
> easy to forget which one you are on.

Very true.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
