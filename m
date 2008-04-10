From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: git annoyances
Date: Thu, 10 Apr 2008 08:08:47 +0200
Message-ID: <47FDAEEF.3090004@eclis.ch>
References: <20080409101428.GA2637@elte.hu> <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 08:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqVT-0000ZU-Hf
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYDJGmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 02:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYDJGmu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:42:50 -0400
Received: from static-217-162-2-166.swisslink.ch ([217.162.2.166]:48060 "EHLO
	mail.eclis.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbYDJGmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:42:50 -0400
X-Greylist: delayed 2035 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Apr 2008 02:42:49 EDT
Received: from [10.192.57.55] (pub1.heig-vd.ch [193.134.216.2])
	by mail.eclis.ch (Postfix) with ESMTP id BFE3458186;
	Thu, 10 Apr 2008 08:07:16 +0200 (CEST)
User-Agent: IceDove 1.5.0.14pre (X11/20080304)
In-Reply-To: <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79170>

Junio C Hamano a =E9crit :
> That made us allowing the users to type "git pull" and "git fetch" wi=
thout
> parameters.  This is generally a good thing: shorter to type for doin=
g
> common things is always good, as long as the user knows what he is do=
ing.
>=20
> But at the same time, this allowed docs and cheat-sheets that mention=
 only
> the form without parameters and not the normative "repository refspec=
"
> form.  This dumbed down the users not understand that in that context
> fetch (and pull, which is a fetch followed by a merge) is always happ=
ening
> against a single branch of single remote repository, the way to name
> remote repository and its branch(es) is to give them as separate
> parameters, and their not typing the pair explicitly is a mere conven=
ience
> feature.  This particular aspect of the shorthand is actually very ba=
d.
> It makes the mental model fuzzy, and hiding important rules of how th=
e
> world works from new people would lead them to unnecessary confusion.=
  In
> short, we made it harder for the new people to "get" it.

A possible way it to, by default, make git print the full form of the=20
command when a short form is used. So the user see the concept without=20
having to read the documentation and learn it gradually. I personally=20
like tools that act this way. It permit to make a basic and easy=20
tutorial with short commands that let know the general concept and show=
=20
the full potential of the tool.

A "short form" flag in a user (not repository) configuration file shoul=
d=20
allow to suppress the long form printout for the comfort of the users=20
that don't want it.

--
Jean-Christian de Rivaz
