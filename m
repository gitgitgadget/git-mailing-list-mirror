From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during tests
Date: Wed, 13 May 2009 10:41:09 -0700
Message-ID: <7vzldg6gui.fsf@alter.siamese.dyndns.org>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
	<loom.20090511T195910-370@post.gmane.org>
	<7viqk57vh8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <ebb9@byu.net>, git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Wed May 13 19:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ISE-0001p9-HQ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760015AbZEMRlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758753AbZEMRlK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:41:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56069 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759966AbZEMRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 13:41:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513174109.NWBC18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 May 2009 13:41:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id r5h91b00U4aMwMQ035hAyV; Wed, 13 May 2009 13:41:10 -0400
X-Authority-Analysis: v=1.0 c=1 a=6FHiilcIfxYA:10 a=s4hJD8TZ4iwA:10
 a=ybZZDoGAAAAA:8 a=9vXuR5GGAAAA:8 a=lCxZRAyeWInJc6Q2G8UA:9
 a=KYhC8DXh_EPFgGtx0HzdIE0cFXEA:4 a=qIVjreYYsbEA:10 a=eDFNAWYWrCwA:10
 a=I6cG22Rk__k9wQ77:21 a=pKilypYNRInS2pAu:21
X-CM-Score: 0.00
In-Reply-To: <7viqk57vh8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 12 May 2009 16\:27\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119076>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Blake <ebb9@byu.net> writes:
> ...
>> I help maintain the cygwin packaging of git, and I don't particularly like 
>> patch 1/6.  Cygwin very much recommends that users stick with binary mounts, 
>> where cr's are not inserted/stripped by default, and enabling autocrlf in that 
>> situation is asking for problems...
>
> Ok, thanks for the comments; I won't touch this for now myself, with
> objections and concerns from people working on windows (you on Cygwin
> side, and Dscho on msysgit side).

Just to make sure I do not cause misunderstanding, I did not mean I won't
touch this ever; I obviously meant "...until the concerns raised by windows
people are addressed to their satisfaction, as they are much better judge
than I am on this topic."
