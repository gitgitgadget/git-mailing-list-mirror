From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 08 Feb 2007 00:50:34 -0800
Message-ID: <7vveidyqw5.fsf@assigned-by-dhcp.cox.net>
References: <20070208075851.GB3950@spearce.org>
	<20070208082850.GA4334@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 09:50:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4zM-0001hM-6G
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423037AbXBHIuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 03:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423040AbXBHIuh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:50:37 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54991 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423037AbXBHIuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 03:50:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208085035.CHDX1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 03:50:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Lwqb1W0071kojtg0000000; Thu, 08 Feb 2007 03:50:36 -0500
In-Reply-To: <20070208082850.GA4334@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Thu, 8 Feb 2007 09:28:50
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39050>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Shawn O. Pearce wrote:
>> Minor documentation improvements, as suggested on the Git mailing
>> list by Horst H. von Brand and Karl Hasselstr~A(P)m.
> you have an encoding problem here     ---------^
>
> That "o umlaut" seems to be UTF-8 encoded, but the headers of you mai=
l
> claim iso-8859-1.

I noticed it, too.  This seems to be purely between the
format-patch output and the mailing list.  In Shawn's tree, the
corresponding commit f842fdb0 does not have the encoding
problem.

As Shawn's tree currently has only these two commits on top of
what my tree already has, I do not mind pulling from it.  It
would make life easier for people who are following his tree.
