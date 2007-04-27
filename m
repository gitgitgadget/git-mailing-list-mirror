From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 27 Apr 2007 12:29:03 -0700
Message-ID: <7vhcr1obuo.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200704271155.24304.ismail@pardus.org.tr>
	<7v1wi6p4lt.fsf@assigned-by-dhcp.cox.net>
	<200704271223.03468.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri Apr 27 21:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhW81-0006qN-4Q
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbXD0T3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Apr 2007 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757154AbXD0T3H
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 15:29:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42679 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158AbXD0T3F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 15:29:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427192905.XZDD1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 15:29:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sKV41W0031kojtg0000000; Fri, 27 Apr 2007 15:29:04 -0400
In-Reply-To: <200704271223.03468.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Fri, 27 Apr 2007 12:22:58 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45744>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

>> Which means that there is something else going on.  Your change
>> may fix what you observed (I do not doubt that it fixed what you
>> observed for you), but without understanding what really is
>> going on (iow, why it is a fix, when the documentation clearly
>> indicates they should be equivalent and it should not fix
>> anything), we cannot tell what *ELSE* we are breaking with this
>> change.
>
> That might be a bug in Encode itself indeed, I will dig a bit more. T=
hanks.

Thanks.
