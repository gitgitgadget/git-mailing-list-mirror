From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 18:58:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809021856310.23787@xanadu.home>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net>
 <0578A0F2-F90A-4555-9B34-726F26A1CDBB@ai.rug.nl> <g9kdn4$rgs$1@ger.gmane.org>
 <7vabeqi2n3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaeqz-0007QG-GH
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYIBW67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYIBW67
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:58:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61256 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYIBW67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:58:59 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6L001OKBU5F5WA@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 18:58:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vabeqi2n3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94734>

On Tue, 2 Sep 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Perhaps instead of poposed patch we should simply put empty lines
> > to emphasize that we are on no branch:
> >
> >         # Please enter the commit message for your changes. Lines starting
> >         # with '#' will be ignored, and an empty message aborts the commit.
> >         #
> >         # Not currently on any branch.
> >         #
> >         # Untracked files:
> >         #   (use "git add <file>..." to include in what will be committed)
> 
> That sounds sensible, easy and safe enough.

Yep.  And I would go as far as suggesting that the branch information be 
the first line of the lot:

# Not currently on any branch.
#
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
# [...]


Nicolas
