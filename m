From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Tue, 13 Feb 2007 10:07:57 -0800
Message-ID: <7vtzxqvsle.fsf@assigned-by-dhcp.cox.net>
References: <200702131512.45412.andyparkins@gmail.com>
	<7v7iumymvq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702131253010.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH24W-00015q-8j
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbXBMSH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbXBMSH7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:07:59 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56137 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbXBMSH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:07:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213180759.KXOA22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 13:07:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P67x1W0221kojtg0000000; Tue, 13 Feb 2007 13:07:58 -0500
In-Reply-To: <Pine.LNX.4.64.0702131253010.1757@xanadu.home> (Nicolas Pitre's
	message of "Tue, 13 Feb 2007 12:54:39 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39566>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 13 Feb 2007, Junio C Hamano wrote:
>
>> As a principle, I am in favor of this.  Perhaps post 1.5.0 after
>> hearing what real cvsserver users have to say on the list.
>
> Andy looks to me like a real cvsserver user though.

I know.  If he were the only real cvsserver user, then the patch
is fine as there is no risk breaking somebody else's setup.
