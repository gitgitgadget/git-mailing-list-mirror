From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Global reflog?
Date: Sun, 14 Feb 2010 23:24:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002142320440.1946@xanadu.home>
References: <2729632a1002141349s6c9a31b7u6784d89d132547ac@mail.gmail.com>
 <alpine.LFD.2.00.1002141655450.1946@xanadu.home>
 <2729632a1002141414l4c4ccd82j32693e6e3bd02bc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_9r96QYz6w1CSD0kFKEju1A)"
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 05:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgsVz-0003v8-2Z
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab0BOEYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 23:24:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23618 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab0BOEYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:24:49 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXV00HUR89DRUY0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 14 Feb 2010 23:24:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <2729632a1002141414l4c4ccd82j32693e6e3bd02bc5@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139966>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_9r96QYz6w1CSD0kFKEju1A)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 14 Feb 2010, skillzero@gmail.com wrote:

> On Sun, Feb 14, 2010 at 1:56 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sun, 14 Feb 2010, skillzero@gmail.com wrote:
> >
> >> Is there a way to have git maintain a single reflog across all
> >> branches (and stashes)? I switch between branches, create and delete
> >> branches, stash save and pop, etc. frequently and it would be great
> >> for me if there was a way to have a global reflog that showed every
> >> operation, independent of a particular branch. Is there some way to
> >> enable this?
> >
> > You have it already.  It is the "HEAD" reflog.
> 
> I don't seem to see any stash activity. For example, I made a test
> change, did git stash, and then git stash pop. When I do git reflog, I
> don't see the stash commit or the delete of the stash. Is there a way
> to enable that?

It is true that stash doesn't touch HEAD.  So logically the stash 
operations should not end up in the HEAD reflog.  But maybe creating a 
reflog only for stashed states could be a good thing.

I personally don't use stash that much since I've grown the habit of 
saving temporary states to a temporary branch before git-stash even 
existed, which in that case is always captured by the HEAD reflog.


Nicolas

--Boundary_(ID_9r96QYz6w1CSD0kFKEju1A)--
