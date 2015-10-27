From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field
 separator
Date: Tue, 27 Oct 2015 10:46:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510271019490.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <cover.1445782122.git.johannes.schindelin@gmx.de> <2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de> <vpqlhaqas8g.fsf@grenoble-inp.fr> <xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
 <xmqqbnblgzrk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:47:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0qd-0000Op-M3
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbbJ0JrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:47:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:61173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990AbbJ0JrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:47:15 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MSHax-1ZwkQU2sRP-00TYQS;
 Tue, 27 Oct 2015 10:46:49 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnblgzrk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:HeGwSGZfV9c3RMDZWF5ZieF68ryYtU5s3Z1hzLhpaGoATFXukRx
 c9n5SAZJMk58aG0jBTDStz9AcDmqBRk9iq8uL8tZDJO+RPkhJQtN7enX6tf2/MZbUAvv0KY
 Wpyyx5HRGsRtzW4eAZtOaOAxIwOBpnmsTd0jJF9y59DgH4vKCKDnKedTKMWZh0m6Vo7i5P1
 JxviAuObGcsEBo02IBcFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bk5RsAsueq0=:ysp0pk5+SX7fT39NBmCGfL
 HfxxqDVDjkYbuTjkGvkdapRR4RN54Z+HiMG/DyDATXdRvhvnL+vwufJLpJMFMeA3UoH53E041
 qek8/XRz6+ixMwCN6fx4Xwof1GgxZoG2mS4K9LowWWMUKe7ZEO+eaZ2f4Lle6NktwtPgcKutV
 QKnBe+i9/JxRS6KQc5SDm2ea7rNe6/enmOHR2wmIwkY4GbBGBODrLWgW3WdOkK9B0mQkNAHw4
 EjhVNmgyAVL0EszVTTtp+N6JlQzqydzVHnqgNTEdePypROlh9/Nm0A1rUZQXkB4fn7Q2Dw6di
 KOazJRN0TJOxuGCUaVfnjrKCEGKC3vSXvPyK+vnf372Cu/jkth8H/DIP89dTRnqATPeU12tzI
 N3MQmfFtrDIFLAk2SIrgyO944hBe2XBoU70si/7CYPGjBWz8QANbGmMoGU/X/LFCoCWB8gHeT
 v20kmp8KpEaRRH5DSAijvtbIGr/lLqqdOvolU9Nx08hHyJ5yJHfjrkfoYrY+Jjjpg9oT6TQMK
 U4kwPO3dqXLjG3+91lNEq+aK6kt3/mZPu6QAM7hh2dEc6I1F1coWrRmE9DlsGi0Ct33z3Xfj2
 SELGB75jrrLHetYr0KNTgs38JZhvWAgN6iyzSyZKDbVeXo2SJGCuUFwrN7bt8QmX1jFI0BBRb
 KdC8C77yNBWqScOQloq2TyWHYpFcf7NOl1Z8HUZciF42RsBffyDEAym2igADROgkntl/Hmdvy
 dFq/Y/4HSIF4A4E2AZFKfAnVsY1iT7FZhg3v0rpkvr3KnjBZh6CCfHJ1nQaxGOUMpb1UelBP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280252>

Hi Junio,

On Mon, 26 Oct 2015, Junio C Hamano wrote:

> Subject: [PATCH] rebase-i: work around Windows CRLF line endings
> 
> Editors on Windows can and do save text files with CRLF line
> endings, which is the convention on the platform.  We are seeing
> reports that the "read" command in a port of bash to the environment
> however does not strip the CRLF at the end, not adjusting for the
> same convention on the platform.
> 
> This breaks the recently added sanity checks for the insn sheet fed
> to "rebase -i"; instead of an empty line (hence nothing in $command),
> the script was getting a lone CR in there.
> 
> Special case a lone CR and treat it the same way as an empty line to
> work this around.

You do not need me to tell you that it is likely that the same issue will
arise in other places, but if you are content with this work-around, so be
it.


> The test was stolen from Dscho.

There was no need to steal this, as I made a specific effort to introduce
the test in a separate commit. There was also no need to remove the
attribution for finding the bug.

Let's not do that.

I will submit v3 in a second, including your work-around in favor of the
patch you hate so much.

Ciao,
Johannes
