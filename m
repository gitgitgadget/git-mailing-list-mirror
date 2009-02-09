From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 20:09:41 +0100
Organization: Beonex
Message-ID: <49907F75.2050100@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbXr-0005qY-Qw
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZBITK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZBITKZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:10:25 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:55990 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZBITKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:10:24 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 0C997303C560;
	Mon,  9 Feb 2009 20:10:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109105>

On 09.02.2009 19:54, Brandon Casey wrote:
> I will follow up with an example patch which has the control characters in
> it.
>    

I can only advise against sending patches in the bodies, sorry. Bodies 
are for human-language text. Attachments are for files like diffs, and 
are preserved. Attachments with "Content-Disposition: inline" are for 
attachments which are supposed to be read directly in the email reader, 
like is the case here.

I guess that other, console-based email software won't deal with inline 
attachments as nicely, but the major email clients do. Instead of trying 
to do something that's going to be fruitless - email bodies are never 
going to be character-to-character identical, because there are many 
demands on formatting (up to graphical smiles) and from many different 
languages (charsets, like seems to be the problem here) on it by users 
-, I think your better route for success would be to use inline 
attachments and fix the software which can't deal with *that* properly, 
including display and quoting.

Sorry to brush you off, but I this is a battle we can't win, either way. 
Too many demands from too many sides.

Ben
