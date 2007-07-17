From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Tue, 17 Jul 2007 11:37:03 -0700
Message-ID: <7vhco2ancg.fsf@assigned-by-dhcp.cox.net>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
	<7vejje3a4k.fsf@assigned-by-dhcp.cox.net>
	<20070717114024.GA12215@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IArv4-0006LB-Us
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 20:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662AbXGQShH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758533AbXGQShH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 14:37:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62851 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbXGQShF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 14:37:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070717183705.GHOA1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 14:37:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Qid41X00B1kojtg0000000; Tue, 17 Jul 2007 14:37:04 -0400
In-Reply-To: <20070717114024.GA12215@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Tue, 17 Jul 2007 13:40:24
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52788>

Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de> writes:

> Junio C Hamano wrote:
>> We could write it as "$(TAR) Ccf blt - ." if we can rely on the
>> 'C' option, but I suspect it is a GNU extension.  Does anybody
>> have POSIX.1 handy?
> I don't have POSIX.1 handy, but on Solaris 10, you need to say:
>
> 	tar cf - -C blt .
>
> (That is, Solaris' tar has the 'C' option, which is quite a good
> indication, that it's included in POSIX :-)

Oh, I cannot resist ;-)

Solaris has unlink(2) capable of removing a directory, but I do
not think it is included in POSIX.
