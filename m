From: Paul Ebermann <Paul.Ebermann@esperanto.de>
Subject: Re: git  --  how to revert build to as-originally-cloned?
Date: Fri, 20 May 2011 21:34:43 +0200
Message-ID: <4DD6C253.2040309@esperanto.de>
References: <20110520162502.7854.qmail@science.horizon.com> <4DD6BE8D.4080708@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Lumby <johnlumby@hotmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 21:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNVYz-0005OL-A8
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 21:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066Ab1ETTkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 15:40:36 -0400
Received: from njoerd.mathematik.hu-berlin.de ([141.20.53.126]:32927 "EHLO
	njoerd.mathematik.hu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757170Ab1ETTkf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 15:40:35 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 May 2011 15:40:35 EDT
Received: from localhost (localhost [127.0.0.1])
	by njoerd.mathematik.hu-berlin.de (Postfix) with ESMTP id 33F6D36A866;
	Fri, 20 May 2011 21:34:51 +0200 (CEST)
Received: from njoerd.mathematik.hu-berlin.de ([127.0.0.1])
 by localhost (njoerd.mathematik.hu-berlin.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25640-03; Fri, 20 May 2011 21:34:46 +0200 (CEST)
Received: from [141.20.50.149] (stilgar.mathematik.hu-berlin.de [141.20.50.149])
	by njoerd.mathematik.hu-berlin.de (Postfix) with ESMTP id 829C536A839;
	Fri, 20 May 2011 21:34:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.19) Gecko/20110420 SUSE/2.0.14-0.2.1 SeaMonkey/2.0.14
In-Reply-To: <4DD6BE8D.4080708@hotmail.com>
X-Virus-Scanned: amavisd-new at mathematik.hu-berlin.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174077>

John Lumby schrieb:
> On 05/20/11 12:25, George Spelvin wrote:
>> Er, no.  One "git merge" command produces (at most) one commit.
>> It may be that the head of the branch you merged in was already
>> a merge commit, but tha
>>
>> You may find "gitk" useful for for visualizing all of this.
>=20
> I have tried gitk.    Can you or someone tell me what the colours of =
the
> nodes in the top left signifies?
> Specifically, a commit of mine (done since all the merging I've been=20
> asking about) shows as yellow, whereas all the ones prior to that
> show as blue. (I have not altered or changed the colour scheme so=20
> it's whatever the default is)

=46or the nodes:
Yellow is the current HEAD. Red is your worktree, if differing
from the index, green is the index, if differing from HEAD.
Everything else (in blue) are other commits in the repository.

The color of the lines is not significant, I think (or at least
I didn't recognize any regularity here).

(This is for my version of gitk, whichever this might be. I didn't
find a way to find out. It says "(c) 2005-2010" in the "about" dialog
and "(c) 2005-2009" in the start of the source code.


Pa=C5=ADlo
