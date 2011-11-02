From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Q: "git diff" using tag names
Date: Wed, 02 Nov 2011 08:35:41 +0100
Message-ID: <4EB100DD020000A100007DE7@gwsmtp1.uni-regensburg.de>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
 <m3aa8l5k1y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 08:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLVMZ-0001Ky-GW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 08:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab1KBHfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 03:35:51 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:48175 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1KBHfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 03:35:51 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 6898F33ED
	for <git@vger.kernel.org>; Wed,  2 Nov 2011 08:35:46 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 01930335F
	for <git@vger.kernel.org>; Wed,  2 Nov 2011 08:35:45 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Wed, 02 Nov 2011 08:35:46 +0100
X-Mailer: Novell GroupWise Internet Agent 2012.0.0 Beta 
In-Reply-To: <m3aa8l5k1y.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184614>

>>> Jakub Narebski <jnareb@gmail.com> schrieb am 28.10.2011 um 15:21 in Nachricht
<m3aa8l5k1y.fsf@localhost.localdomain>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
> 
> > When using a somewhat older git (of SLES11 SP1 SDK),
> 
> Nb. you can check version of git with "git --version".

Hi!

For the records, it's "1.6.0.2"...

> 
> >                                                      I could not
> > find a way to "git diff" between two tag names; I can only diff
> > between two commit numbers. I can display a changeset using "git
> > show", but that's not what I wanted.
> >
> > Is it possible to get the diff I want using older versions, and is
> > such a feature implemented in the current version? If so, since
> > when?
> 
> From the very beginning in Git you can use tag name where you need
> commit identifier; Git would use commit that tag points to (will
> dereference or peel a tag).

As said before, I was confused by the simplicity: I was looking for an option to specify revisions (as opposed to file names), like "-r" for RCS, but found none. To make things complicated, I had mistyped one tag name without noticing, so I failed to diff, making me think that tag names won't work the way they actually do.

Sorry, and thanks to everybody who helped!

Ulrich

> 
> That is not possible in some [censored] version control systems; I am
> looking at you, Subversion!
> 
> 
> So if you can do
> 
>   $ git show v0.9
>   $ git show v1.0
> 
> you can also do
> 
>   $ git diff v0.9 v1.0
> 
> and
> 
>   $ git log v0.9..v1.0



 
