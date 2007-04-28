From: Junio C Hamano <junkio@cox.net>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 17:56:46 -0700
Message-ID: <7vps5pl3jl.fsf@assigned-by-dhcp.cox.net>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
	<87y7kdo6pn.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 02:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhbF5-0000Xx-Sq
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 02:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980AbXD1A4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 20:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757981AbXD1A4s
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 20:56:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33452 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980AbXD1A4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 20:56:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428005647.DKDV1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 20:56:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sQwl1W00Q1kojtg0000000; Fri, 27 Apr 2007 20:56:46 -0400
In-Reply-To: <87y7kdo6pn.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	27 Apr 2007 14:20:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45765>

Carl Worth <cworth@cworth.org> writes:

>> In the community git originates from, even --inline attachments
>> are frowned upon, let alone --attach multiparts (yes, I am
>> talking about the kernel list and this list).  Nobody who sends
>> patches over e-mail in communities that have a tradition against
>> unreadable patches would be using --inline nor --attach anyway,
>> so making --attach to do base64 would not hurt there.
>
> I know I'm not within the kernel or git party line by saying this, but
> I don't have a problem with (non base64) mime-attached patches. My MUA
> displays them fine and quotes them when I reply so I can easily review
> them.

You strayed into tangent here.  You said you do not have a
problem with non base64 attachments.  I would like to know if
you have or do not have problem with base64 ones, as that is
what indicates your opinion on making --attach unconditionally
do base64 which was the suggestion made in the thread.
