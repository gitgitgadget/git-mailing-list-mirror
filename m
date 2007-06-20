From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Wed, 20 Jun 2007 13:20:15 -0700
Message-ID: <7vfy4mtm2o.fsf@assigned-by-dhcp.pobox.com>
References: <200705081349.34964.ismail@pardus.org.tr>
	<200705112242.44618.ismail@pardus.org.tr>
	<7vwszf9md5.fsf@assigned-by-dhcp.cox.net>
	<200706202242.13100.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I16f8-0004AS-N2
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbXFTUUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Jun 2007 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbXFTUUT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:20:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53162 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbXFTUUR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2007 16:20:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620202016.GHNH2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 16:20:16 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DwLF1X00K1kojtg0000000; Wed, 20 Jun 2007 16:20:16 -0400
In-Reply-To: <200706202242.13100.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Wed, 20 Jun 2007 22:42:08 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50567>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> On Friday 11 May 2007 22:44:06 Junio C Hamano wrote:
>> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
>> > Most(All?) distros /usr/share/man in MANPATH so I believe this
>> > patch shouldn't break anything but well you have the final
>> > say. I am ok with doing make mandir=3D/usr/share/man install-doc
>>
>> My preference is to do this early after 1.5.2.  I do not want to
>> touch builds with trivial changes before the final.
>
> Still not applied to 1.5.2.2. Patch attached for convenience.

Thanks.

I do not think this patch should happen to 1.5.2.X for any value
of X; but I am willing to apply it to 'master' (hence 1.5.3 and
later).
