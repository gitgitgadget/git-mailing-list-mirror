From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 20:51:03 +0100
Organization: Beonex
Message-ID: <49908927.2030408@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <4990820B.504@beonex.com> <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWcCO-0003wE-Pk
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbZBITvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756070AbZBITvr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:51:47 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:53011 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbZBITvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:51:46 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 62BB5303C560;
	Mon,  9 Feb 2009 20:51:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109114>

On 09.02.2009 20:30, Brandon Casey wrote:
> Did you try it with the message I sent titled
> '[PATCH] example patch corrupted by thunderbird'?

I tried now, and none of the editors/viewers I tried are displaying 
anything that would come close to readable to me, even if you count 
clearly marked hex character codes as readable. I tried less, e3 and 
kwrite. Therefore, a) I can't verify whether the result is correct or 
not b) I declare this an edge case.

> When I save with Thunderbird, part of what was on line 5 is now
> on another line and the control-M is missing.
> Nope, '.eml' extension.
>    

That would be a bug. If you save as .eml, it should save exactly what's 
in your IMAP mailbox or what View as source | File | Save... saves. If 
it doesn't do that, it's a bug.

The View Source workaround may be inconvenient, but is a workaround for 
such a strong edgecase, until this bug is fixed. Don't hope for it, 
though, because TB is working on completely different things, like a 
message database.

You're welcome to file a bug, but please without political statements or 
broad generic demands. TB is geared towards comfortable writing and 
reading of human language text.

---

Apart from that, I can only recommend that you re-consider sending 
patches as inline attachments (Content-Disposition: inline, which is an 
official Internet Standard since many years), which is IMHO correctly 
reflecting reality, and fixing the software which can't deal with 
*that*, including inline display and quoting.

Ben
