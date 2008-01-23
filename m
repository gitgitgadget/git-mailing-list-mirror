From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 11:43:45 +0300
Message-ID: <20080123084345.GN14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbDY-0003Np-7e
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYAWInt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 03:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYAWInt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:43:49 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:64066 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbYAWIns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 03:43:48 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id 08F9DA2D6C5;
	Wed, 23 Jan 2008 11:43:47 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-241.pppoe.mtu-net.ru [85.141.188.241])
	by smtp05.mtu.ru (Postfix) with ESMTP id 3F599A2C4A4;
	Wed, 23 Jan 2008 11:43:45 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHbCz-00077h-T7; Wed, 23 Jan 2008 11:43:45 +0300
Content-Disposition: inline
In-Reply-To: <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71522>

On Wed, Jan 23, 2008 at 03:15:02AM -0500, Kevin Ballard wrote:
>=20
> Entirely possible, though renormalizing file contents seems a bit les=
s =20
> likely. I will point out that the text input system in OS X seems to =
=20
> default to producing NFC (at least, typing `echo 'M=E4rchen' | xxd` i=
n =20
> the Terminal shows that the input string there is NFC).

I wonder what happens if you do this:

touch 'M=E4rchen'
echo M*rchen | xxd -g1

Will that produce NFC or NFD?

Dmitry
