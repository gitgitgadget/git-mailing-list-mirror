From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 13:30:56 -0600
Message-ID: <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <4990820B.504@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:33:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbsr-0005ax-6d
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZBITbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756869AbZBITbd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:31:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34429 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbZBITbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:31:33 -0500
Received: by mail.nrlssc.navy.mil id n19JUvrF019099; Mon, 9 Feb 2009 13:30:57 -0600
In-Reply-To: <4990820B.504@beonex.com>
X-OriginalArrivalTime: 09 Feb 2009 19:30:57.0296 (UTC) FILETIME=[EE601900:01C98AEC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109112>

Ben Bucksch wrote:
> On 09.02.2009 20:14, Johannes Schindelin wrote:
>> On 09.02.2009 19:54, Brandon Casey wrote:
>>>> I will follow up with an example patch which has the control
>>>> characters in it.
>>>>        
> 
>> Especially the "Save" command will save the byte-identical body of the
>> mail.
>>    
> 
> I think Thunderbird will also save a byte-identical copy of the mail, if
> you use File | Save... and use ".eml" (for email = RFC822) file extension.

Did you try it with the message I sent titled
'[PATCH] example patch corrupted by thunderbird'?

The body of the patch has 1 hunk which adds 6 lines.

When I save with Thunderbird, part of what was on line 5 is now
on another line and the control-M is missing.  At least that is
what is apparent to me.

> The dialog is sensitive to the file extension and determines the format
> based on that, but is unfortunately not communicative about it.

I did not modify the suggested file name.  The saved file has a '.eml'
extension.

> If you save as HTML (.html) or plaintext (.txt), it runs it through the
> MIME converters and reformats it for display / human reading.

Nope, '.eml' extension.

-brandon
