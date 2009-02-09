From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 12:54:11 -0600
Message-ID: <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbIt-0008Hn-P6
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbZBISyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbZBISyz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:54:55 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48121 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbZBISyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:54:54 -0500
Received: by mail.nrlssc.navy.mil id n19IsBDV002496; Mon, 9 Feb 2009 12:54:12 -0600
In-Reply-To: <499058B4.4070009@beonex.com>
X-OriginalArrivalTime: 09 Feb 2009 18:54:11.0915 (UTC) FILETIME=[CBDDA9B0:01C98AE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109102>


I have an issue with Thunderbird that I'd like to describe while we have
the developers ear.

I was sent a patch which had a sequence of control characters in it.

To save an emailed patch, I normally write click in the message body and
choose 'Save As...'.  Thunderbird populates the 'Name:' field for the
name of the saved file with a name based on the subject, which I like.

But, in this case, Thunderbird corrupted the original message and saved
something that was not equivalent to what was sent.  Naturally, the patch
could not be applied, and after investigating, it was determined that
Thunderbird was responsible.  If I instead choose View -> 'Message Source'
and then in the window that pops up choose File -> 'Save Page As', and then
give it a name, I do indeed get the original uncorrupted message, but it
is _not_ convenient.

This is Thunderbird v2.0.0.19.
Is this a bug? Or is there something I can set or disable so that Thunderbird
saves the original contents when right clicking in the message body and
selecting 'Save As...'?

I will follow up with an example patch which has the control characters in
it.

-brandon
