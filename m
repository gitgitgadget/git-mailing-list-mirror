From: Junio C Hamano <junkio@cox.net>
Subject: Re: .git/info/refs
Date: Thu, 25 Jan 2007 13:28:30 -0800
Message-ID: <7vireuaj9d.fsf@assigned-by-dhcp.cox.net>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
	<45B7818F.6020805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 22:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAC95-0001hi-QO
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbXAYV2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbXAYV2c
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:28:32 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62870 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030580AbXAYV2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:28:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125212831.QPUM19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 16:28:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FZTa1W00D1kojtg0000000; Thu, 25 Jan 2007 16:27:34 -0500
In-Reply-To: <45B7818F.6020805@zytor.com> (H. Peter Anvin's message of "Wed,
	24 Jan 2007 07:55:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37759>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Jakub Narebski wrote:
>> H. Peter Anvin wrote:
>>
>>> Would it be an incompatible change to add the commit date (and
>>> perhaps the author date) to .git/info/refs?  I believe that would
>>> make it possible to dramatically (orders of magnitude) speed up the
>>> generation of the gitweb index page, which is easily the most
>>> expensive gitweb page to generate.
>>
>> With new gitweb and new git it is not that expensive. It is now one call
>> to git-for-each-ref per repository.
>
> That IS hugely expensive.  On kernel.org, that is 24175 calls to git.

Do you mean you have 24k _REPOSITORIES_ served by gitweb on
kernel.org?
