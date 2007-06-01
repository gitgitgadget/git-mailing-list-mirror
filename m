From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 01 Jun 2007 18:51:27 +0200
Message-ID: <87ejkvty7k.fsf@wine.dyndns.org>
References: <200704241705.19661.ismail@pardus.org.tr>
	<7vsladzp29.fsf@assigned-by-dhcp.cox.net>
	<87zm3ju6tg.fsf@wine.dyndns.org>
	<200706011650.10650.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuAM2-00056D-Pe
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 18:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760758AbXFAQvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Jun 2007 12:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761395AbXFAQvc
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 12:51:32 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:42488 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758323AbXFAQvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2007 12:51:31 -0400
Received: from adsl-84-226-54-218.adslplus.ch ([84.226.54.218] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HuALa-0006LS-7D; Fri, 01 Jun 2007 11:51:30 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id C1ACF4F68A; Fri,  1 Jun 2007 18:51:27 +0200 (CEST)
In-Reply-To: <200706011650.10650.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?= message of "Fri\, 1 Jun 2007 16\:50\:09 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48872>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> Sorry but thats too old. Of course I am not the maintainer of GIT so =
its not=20
> for me to decide but well as David Woodhouse puts it, please join us =
in 21st=20
> century and start using UTF-8.

That's not very helpful. There can be many valid reasons for not using
utf-8, in our case compatibility with Windows tools is the main
reason. And even if we were to convert all our files today, it
wouldn't help when browsing older versions.

I'm not asking gitweb to magically guess the encoding of the files,
I'm happy with it replacing invalid sequences with some substitution
char, like it did before 1.5.2. But now it is deleting whole lines
from the diff, without any indication that something went wrong.
That's not an improvement IMNSHO.

--=20
Alexandre Julliard
julliard@winehq.org
