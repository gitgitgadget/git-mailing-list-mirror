From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
   for git-format-patch.
Date: Mon, 09 Feb 2009 14:50:09 +0100
Message-ID: <49903491.7000509@drmicha.warpmail.net>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Bucksch <ben.bucksch.news@beonex.com>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWWY4-0003yf-Tg
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 14:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbZBINuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 08:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbZBINuR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 08:50:17 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49018 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755473AbZBINuP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2009 08:50:15 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4AA2A2901BE;
	Mon,  9 Feb 2009 08:50:14 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 09 Feb 2009 08:50:14 -0500
X-Sasl-enc: gEAEDQx/oAFpTbxz11TfbI8mJzUCbYKpsDzzIgqmcHgN 1234187413
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 49C303A93;
	Mon,  9 Feb 2009 08:50:13 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109070>

Johannes Schindelin venit, vidit, dixit 09.02.2009 14:36:
> Hi,
> 
> On Mon, 9 Feb 2009, Ben Bucksch wrote:
> 
>> On 09.02.2009 13:34, Michael J Gruber wrote:
>>> Johannes Schindelin venit, vidit, dixit 08.02.2009 18:28:
>>>    
>>>> On Sun, 8 Feb 2009, Jeremy White wrote
>>>>> Essentially, the problem is well understood - Thunderbird uses
>>>>> format=flowed by default, which is what mangles the patches.
>>>>>        
>>>> I guess I'll start discouraging use of Thunderbird from now on.
>> Or you could just publish:
>> 1. Prefs | Advanced | General | Config Editor...
>> 2. "mailnews.send_plaintext_flowed" = false
> 
> Ah.  Mhm...
> 
>> As inline attachments, they'll show up inline in the msg viewer as well 
> 
> ... which is a moot point, as the responder has to do extra work to quote 
> the stuff.  Definitely not my type of friendliness.
> 
>>> I found git-send-email the more reliable and practical solution for 
>>> sending out patches. Put yourself in bcc and you'll have a copy in 
>>> TB's inbox or another folder (use filters).
>> Yup, I think that's the best way - git is using email only as protocol, so
>> it's good to have special clients to that, as it's a really special use.
> 
> Aha.  And putting extra comments in (manually) does not count.  'cause I 
> do not see send-email allowing that.

There is this useful thingy called "vim" which lets you edit the 00*
files... Come on, Dscho ;)

>>> <sarcasm style="reality: exaggerated;">
>>> Isn't that some Linux guy? How would he matter for Mozilla? Does he even
>>> know how to send HTML mail...
>>> </sarcasm>
>>>    
>> I don't think it's a matter of clue, it's a matter of background and 
>> attitude.
> 
> Yeah, I think my background dictates that I stay by my word and recommend 
> other mailers than Thunderbird.
> 
> It is one thing to be nice to the "average" user, but another one to be 
> unfriendly to the people making the internet revolution possible.

I think Ben made it clear why "format flowed" is the default, and there
are numerous posts in the TB/moz community which make it clear why they
spell it "format flawed".  The default will not change.

I thought about writing an extension which let's you change the config
on a per message basis. (You can already do it per folder using mnenhy,
I suppose.) But then I still have to navigate from TB to my repo and
include the output of git-format-patch, or dump it to an mbox (or upload
to an imap drafts folder).

So, even with f-f issues out of the way I would find git-send-email
(+vim) to be the right tool for the job. Which is why I use it, for
sending patches by e-mail, not for corresponding by e-mail.

So, let's be peaceful, and talk about Mozilla's choice of hg instead ;)
[No, please don't!]

Michael
