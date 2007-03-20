From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 01:49:51 -0700
Message-ID: <7vbqio7100.fsf@assigned-by-dhcp.cox.net>
References: <1174361424.3143.42.camel@dv> <1174367312.3143.75.camel@dv>
	<Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
	<200703200843.51473.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pavel Roskin <proski@gnu.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 09:50:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTa2n-0001Xn-6q
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 09:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbXCTItw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbXCTItw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 04:49:52 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40880 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbXCTItw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 04:49:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320084951.MPFK748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 04:49:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cwpr1W0021kojtg0000000; Tue, 20 Mar 2007 04:49:51 -0400
In-Reply-To: <200703200843.51473.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Mar 2007 08:43:50 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42730>

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2007 March 20 05:41, Linus Torvalds wrote:
>
>> 	[core]
>> 		legacyheaders = false
>> noticed, because almost nobody uses it.
>
> I'm not sure that's going to be true for long - the 1.5.0 release notes 
> recommended setting it (assuming you didn't need backward compatibility) - 
> which is exactly what I (and I'm sure others) did.

Well, it is fixed in 'master' to be in -rc2, and that validation
does not exist in 'maint', so no harm is done.
