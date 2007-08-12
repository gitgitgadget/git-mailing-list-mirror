From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for git-commit being confused by relative GIT_DIR
Date: Sun, 12 Aug 2007 10:05:23 -0700
Message-ID: <7vir7kk7jg.fsf@assigned-by-dhcp.cox.net>
References: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
	<85tzr5spaj.fsf@lola.goethe.zz>
	<7vvebljz31.fsf@assigned-by-dhcp.cox.net>
	<854pj5s104.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 19:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKGsf-0001VT-Gd
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 19:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761097AbXHLRF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759449AbXHLRF1
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 13:05:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49954 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761097AbXHLRFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 13:05:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812170525.KRHE1335.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 13:05:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b55P1X00T1kojtg0000000; Sun, 12 Aug 2007 13:05:24 -0400
In-Reply-To: <854pj5s104.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	12 Aug 2007 08:47:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55691>

David Kastrup <dak@gnu.org> writes:

>> Also I do not think you would want to say touch $(pwd)/output
>> there inside the here text that begins with <<EOF not <<\EOF.
>
> But I most certainly do!

Then you would need to shell-quote $(pwd) so that you can have
your git.git checked out somewhere under "/My Documents/source"
directory, wouldn't you?
