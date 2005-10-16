From: Junio C Hamano <junkio@cox.net>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 09:56:49 -0700
Message-ID: <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	<434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com>
	<Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
	<435264B1.2010204@de.bosch.com>
	<Pine.LNX.4.63.0510161122570.23242@iabervon.org>
	<20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 16 18:58:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERBp3-0007mu-Dn
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVJPQ4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 12:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVJPQ4v
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 12:56:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37827 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751205AbVJPQ4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 12:56:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016165637.OIWX9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Oct 2005 12:56:37 -0400
To: git@vger.kernel.org
In-Reply-To: <43527E86.8000907@didntduck.org> (Brian Gerst's message of "Sun,
	16 Oct 2005 12:23:34 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10162>

Brian Gerst <bgerst@didntduck.org> writes:

>> Is it possible to determine the object locations inside the remote
>> pack
>> file?  If so, it would be possible to use Range: headers to download
>> selected objects from a pack.

That's what the .idx file is for, except that after you fetch
the range, you may find you would need something else that the
object is delta against.
