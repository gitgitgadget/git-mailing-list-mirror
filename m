From: David Kastrup <dak@gnu.org>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 13:50:38 +0100
Message-ID: <85odbaoyqp.fsf@lola.goethe.zz>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	<E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	<20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	<alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	<20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
	<7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801241722130.22568@xanadu.home>
	<7vy7ae7dcb.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801251137030.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 13:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIO1Z-0007Uz-Ka
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbYAYMuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 07:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbYAYMuk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:50:40 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:54488 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754802AbYAYMui convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 07:50:38 -0500
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id B7F5924B0B9;
	Fri, 25 Jan 2008 13:50:36 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id A323328EDBE;
	Fri, 25 Jan 2008 13:50:36 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-040-038.pools.arcor-ip.net [84.61.40.38])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 681C536E877;
	Fri, 25 Jan 2008 13:50:36 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E372E1C29911; Fri, 25 Jan 2008 13:50:38 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0801251137030.5731@racer.site> (Johannes
	Schindelin's message of "Fri, 25 Jan 2008 12:25:22 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5550/Fri Jan 25 08:02:45 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71703>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> it seems that for some strange reason, "git add M=E4rchen" puts the
> mangled filename into the index, even if "echo M=E4rchen" shows the
> unmangled filename.

echo is likely a shell builtin.  So "git add M=E4rchen" goes through ex=
ec
while echo doesn't.

What does /bin/echo M=E4rchen yield?

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
