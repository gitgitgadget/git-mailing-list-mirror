From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 16:49:47 +0100
Organization: OPTEYA
Message-ID: <64e67681cf5584b51bc84082fe6304c0@meuh.org>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
 <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 17:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIi7d-00056h-LN
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 17:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736Ab3CUQNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 12:13:16 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:60401 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933681Ab3CUQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 12:00:11 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2013 12:00:10 EDT
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UIhkR-000Dy3-85; Thu, 21 Mar 2013 16:49:47 +0100
In-Reply-To: <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218741>

Le 21.03.2013 16:31, Junio C Hamano a =C3=A9crit=C2=A0:
> Yann Droneaud <ydroneaud@opteya.com> writes:
>
>> The documentation is in AsciiDoc format: it should be written=20
>> somewhere
>> with links to AsciiDoc documentation so that it became easy to find
>> how to write documentation for Git.
>
> Certainly this does not deserve a *new* file to hold it.

That's the first one I look for.

There were no indication about how to write documentation
in SubmittingPatches.

Later, I've found the only useful piece of advice regarding the=20
documentation
in howto/new-command.txt:

"
What every extension command needs
----------------------------------

You must have a man page, written in asciidoc (this is what Git help
followed by your subcommand name will display).  Be aware that there is
a local asciidoc configuration and macros which you should use.  It's
often helpful to start by cloning an existing page and replacing the
text content.
"

And I was grep'ing for ascii[ _-]doc throughout the sources !

> Isn't this inferrable from the top-level INSTALL already?

In short: No.

You want me to look in the INSTALL file to search for the syntax
to write documentation ?

=46or someone who don't follow Git development, it's really not the fil=
e=20
you're looking for.

Regards.

--=20
Yann Droneaud
OPTEYA
