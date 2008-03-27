From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git add -i doesn't update permissions
Date: Thu, 27 Mar 2008 07:32:13 +0100
Message-ID: <0F970CFF-EA4A-46D8-BB1D-345C3513B124@wincent.com>
References: <20080326102332.GA26842@alea.gnuu.de> <20080327055746.GA8469@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 07:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jelff-00038S-KN
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 07:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbYC0Gc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2008 02:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbYC0Gc0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 02:32:26 -0400
Received: from wincent.com ([72.3.236.74]:47536 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbYC0GcZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 02:32:25 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2R6WEha022930;
	Thu, 27 Mar 2008 01:32:15 -0500
In-Reply-To: <20080327055746.GA8469@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78337>

El 27/3/2008, a las 6:57, Jeff King escribi=F3:

> Now, if you are interested in adding the mode change of a file but =20
> _not_
> its content, I think that is a reasonable thing to ask for. And it's
> something that is not possible with "add -i" right now, I don't think=
=2E
> You seemed to expect that 'p' would present the mode change and say =20
> "do
> you want to stage this?" which I think is a reasonable interface. =20
> Though
> in that case "[p]atch" should perhaps be "[p]artial update".

Or even "[p]ick" (changes to be staged), which is a bit shorter.

But yes, I've always thought that "[p]atch" didn't really describe =20
what that subcommand really does.

Cheers,
Wincent
