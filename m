From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 04/10] Migrate git-clone to use git-rev-parse --parseopt
Date: Tue, 06 Nov 2007 14:44:15 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711061443030.21255@xanadu.home>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
 <1194172262-1563-4-git-send-email-madcoder@debian.org>
 <1194172262-1563-5-git-send-email-madcoder@debian.org>
 <alpine.LFD.0.9999.0711061355330.21255@xanadu.home>
 <7vr6j3gof2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpULg-0007eQ-Tq
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbXKFToR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbXKFToQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:44:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43734 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbXKFToQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:44:16 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR300ARMO5RGEO0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Nov 2007 14:44:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vr6j3gof2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63709>

On Tue, 6 Nov 2007, Junio C Hamano wrote:

> Gaah.
> 
> I'd blame Linus for suggesting to make parseopt part of
> rev-parse, the latter of which makes sense only inside git while
> the former of which makes sense outside git.
> 
> Would something like this help?
> 
> ---
>  builtin-rev-parse.c |    4 ++--
>  git.c               |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

That does help indeed.


Nicolas
