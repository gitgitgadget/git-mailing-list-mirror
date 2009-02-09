From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
   for git-format-patch.
Date: Mon, 09 Feb 2009 14:25:48 +0100
Message-ID: <49902EDC.6020901@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org, mozeditor@floppymoose.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:35:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWWI2-0006mf-9k
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 14:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbZBINdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 08:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbZBINdq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 08:33:46 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:50468 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbZBINdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 08:33:45 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2009 08:33:45 EST
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id AA826303C561;
	Mon,  9 Feb 2009 14:26:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <499022D3.3000200@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109068>

On 09.02.2009 13:34, Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 08.02.2009 18:28:
>    
>> On Sun, 8 Feb 2009, Jeremy White wrote
>>> Essentially, the problem is well understood - Thunderbird uses
>>> format=flowed by default, which is what mangles the patches.
>>>        
>> I guess I'll start discouraging use of Thunderbird from now on.

Or you could just publish:
1. Prefs | Advanced | General | Config Editor...
2. "mailnews.send_plaintext_flowed" = false

The defaults should be best for the average user, not the rare 
programmer, who has no problem changing prefs.

f=f helps the normal user (and more importantly his recipient) by 
properly flowing text, which allows me to read with line lengths which 
are comfortable to read for me. It harms only in rare cases where 
line-endings are very important, *but* are not explicitly marked so. I 
think you can switch to "preformat" in the HTML editor and it would 
work, because we then know it's not flowing text, but I haven't tried 
it, because I attach such documents as txt / diff files.

As inline attachments, they'll show up inline in the msg viewer as well 
(which means I can read and copy&paste them), but are clearly separated 
from the body (which is assumed to be human-created natural language 
text), avoiding the problem mentioned here, and can easily be saved as 
file, opened in an external app etc.. I don't know why you didn't choose 
that way, but I assume you had your reasons. Just as we had our reasons 
for choosing f=f.

> I found git-send-email the more reliable and practical solution for 
> sending out patches. Put yourself in bcc and you'll have a copy in 
> TB's inbox or another folder (use filters).

Yup, I think that's the best way - git is using email only as protocol, 
so it's good to have special clients to that, as it's a really special use.

> <sarcasm style="reality: exaggerated;">
> Isn't that some Linux guy? How would he matter for Mozilla? Does he even
> know how to send HTML mail...
> </sarcasm>
>    
I don't think it's a matter of clue, it's a matter of background and 
attitude.

Ben
