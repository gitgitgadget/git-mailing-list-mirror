From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: Anyone know the innards of the gitk program?
Date: Wed, 20 Aug 2014 03:51:56 -0500
Message-ID: <20938-1408524736-805990@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 10:59:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK1jV-0004Z2-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 10:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaHTI7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2014 04:59:00 -0400
Received: from sneak2.sneakemail.com ([38.113.6.65]:52668 "HELO
	sneak2.sneakemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750745AbaHTI67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 04:58:59 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Aug 2014 04:58:59 EDT
Received: (qmail 20661 invoked from network); 20 Aug 2014 08:52:17 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.1)
  by sneak2.sneakemail.com with SMTP; 20 Aug 2014 08:52:17 -0000
Received: from 207.58.245.194 by mail.sneakemail.com with SMTP;
 20 Aug 2014 08:52:17 -0000
Received: (sneakemail censored 20938-1408524736-805990 #1); 20 Aug 2014
 08:52:17 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.24)
 Gecko/20100228 Thunderbird/2.0.0.24 Mnenhy/0.7.5.666
X-Mailer: Perl5 Mail::Internet v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255560>

I knew that gitk is written in a scripting language, so I had high hope=
s of making a=20
little tweak to it.  But, alas, it's 12000 lines of languages I don't k=
now!

The farthest I got was finding =E2=80=9Ctext $cflist \=E2=80=9D on line=
 2381 and the corroborating comment=20
=E2=80=9C# lower right=E2=80=9D just above it.

What I want to accomplish is to highlight specific words in the Patch v=
iew; in particular=20
certain path element names to indicate files I'm specifically intereste=
d in reviewing and=20
those that I'm specifically not at all interested in.

Considering the way it works =E2=80=94 Tk widgets =E2=80=94 that ought =
to be easy.  I've used Perl/Tk in=20
the past and can look up the parameters to different element types.  Bu=
t I have no idea=20
where to put such a change, or the general flow of the program in gener=
al.

Is anyone knowledgeable in the inner workings of this program willing t=
o help me out?

I've tried a few git repository GUI programs (on Windows) and always en=
d up gravitating=20
back to Git Gui and gitk !

=E2=80=94John
