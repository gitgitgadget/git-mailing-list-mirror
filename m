From: Mark Jason Dominus <mjd@plover.com>
Subject: Re: git-push sent too many objects
Date: Wed, 18 Apr 2012 10:22:26 -0400
Organization: P.D.Q. Bernoulli Institute of Lower Mathematics
Message-ID: <15053.1334758946@plover.com>
References: <CAJo=hJuGHymJtZL14mAq0gBZE+za5URoon=rMzPA=tTQC14ftQ@mail.gmail.com>
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 16:22:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKVmU-0000an-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 16:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab2DROWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 10:22:46 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:35537 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2DROWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 10:22:45 -0400
Received: from plover.com ([unknown] [72.92.0.213]) by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M2O00KCRILFF103@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 18 Apr 2012 09:22:28 -0500 (CDT)
Received: (qmail 15055 invoked by uid 1000); Wed, 18 Apr 2012 14:22:26 +0000
Received: from localhost (HELO plover.com) (sendmail-bs@127.0.0.1)
 by localhost with SMTP; Wed, 18 Apr 2012 14:22:26 +0000
In-reply-to: Your message of "Wed, 18 Apr 2012 00:59:14 PDT."
 <CAJo=hJuGHymJtZL14mAq0gBZE+za5URoon=rMzPA=tTQC14ftQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195871>

Shawn Pearce:
> On Tue, Apr 17, 2012 at 09:53, Mark Jason Dominus <mjd@plover.com> wrote:
> > What happened here? =A0Why did git-push send 1,315 objects instead of 5?
> 
> Is it possible someone else modified the repository at the same time?

It is extremely unlikely. This repository is controlled by gitolite
and I am the only person who has push access to it. Also, although my
paste doesn't show it, the repository's master reference had not
moved.

I should have mentioned my git version in my original message: it is
1.7.10.rc0.1.g6fd18 .
