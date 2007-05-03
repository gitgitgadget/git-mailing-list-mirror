From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Thu, 03 May 2007 12:26:22 -0700
Message-ID: <7vsladzp29.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200705020012.13302.ismail@pardus.org.tr>
	<7v8xc85ill.fsf@assigned-by-dhcp.cox.net>
	<200705032222.37387.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Thu May 03 21:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjgwe-0006At-U3
	for gcvg-git@gmane.org; Thu, 03 May 2007 21:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767769AbXECT00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 15:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767770AbXECT0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 15:26:25 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52960 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767765AbXECT0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 15:26:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503192625.PAAJ22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 3 May 2007 15:26:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ujSP1W00Z1kojtg0000000; Thu, 03 May 2007 15:26:24 -0400
In-Reply-To: <200705032222.37387.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Thu, 3 May 2007 22:22:32 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46099>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

>> But at the same time I wonder why should the callers be feeding
>> an already decoded string to to_utf8().  It might be that some
>> callers needs fixing.
>
> Is the patch OK do you want more investigation? Asking because its st=
ill not=20
> in git.git.

I would say that the patch is an improvement from the current
code so it should hit 'master'; I was a bit busy lately and then
am sick, and also we are post -rc1 freeze now and I was being
cautious, just in case some nacks from more informed parties
arrive late.
