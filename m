From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Thu, 12 Jul 2007 01:34:03 -0700
Message-ID: <7vodiivx50.fsf@assigned-by-dhcp.cox.net>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
	<Pine.LNX.4.64.0707111807470.4516@racer.site>
	<86sl7u12m3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 10:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8u7n-0003Ql-0h
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 10:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXGLIeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 04:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXGLIeG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 04:34:06 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58557 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXGLIeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 04:34:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712083404.RZXG1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Jul 2007 04:34:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NYa31X00B1kojtg0000000; Thu, 12 Jul 2007 04:34:04 -0400
In-Reply-To: <86sl7u12m3.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Thu, 12 Jul 2007 09:51:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52259>

David Kastrup <dak@gnu.org> writes:

> Don't educate people.  Just don't trigger their problems.  Of course,
> there are millions of ways of shooting oneself in the foot, but in
> this case the same foot has been hit several times already.

Yup.  We do exactly that in git-clone, git-sh-setup and
t/test-lib to avoid getting bugged by this stupidity.
