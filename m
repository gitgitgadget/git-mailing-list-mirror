From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 01:54:05 +0100
Message-ID: <D32FF2AF-EA90-4737-8320-836B52AF4612@wincent.com>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org> <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> <85zlv5nvge.fsf@lola.goethe.zz> <B2E52451-5153-4EFD-ADBE-AACDCEF6169E@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:54:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJ1v-0002se-EG
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbYAQAyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 19:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYAQAyW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:54:22 -0500
Received: from wincent.com ([72.3.236.74]:34411 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbYAQAyW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 19:54:22 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0H0s6Bd004466;
	Wed, 16 Jan 2008 18:54:08 -0600
In-Reply-To: <B2E52451-5153-4EFD-ADBE-AACDCEF6169E@simplicidade.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70792>

El 17/1/2008, a las 1:40, Pedro Melo escribi=F3:

> That's the point I'm making. The fact that I need to set LANG across =
=20
> all users of a project is insane...

I don't think I'd call that "insane" (in fact, I think these =20
discussions would be much less irritating for all involved if we =20
didn't use that word so often, even when it's not called for). It's =20
not that different than the whole LF/CRLF line-ending thing.

The real problem is that setting LANG won't help you on Mac OS X; set =20
LANG to whatever you want and there is *nothing* that you can do to =20
stop your filenames being normalized into decomposed UTF-8, short of =20
dropping HFS+. You can use an alternative filesystem, but support for =20
basically everything except HFS+ is suboptimal in Mac OS X at the =20
moment.

Cheers,
Wincent
