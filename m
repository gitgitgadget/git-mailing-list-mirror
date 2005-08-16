From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Submitting patches w/ Thunderbird [was: Re: [PATCH] Add SubmittingPatches]
Date: Tue, 16 Aug 2005 11:22:11 -0400
Message-ID: <430204A3.2050201@gmail.com>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org> <Pine.LNX.4.63.0508160252310.26927@wgmdd8.biozentrum.uni-wuerzburg.de> <7vk6imr7x0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508160335420.1574@wgmdd8.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 17:24:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E53Gu-0003Vj-MN
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 17:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbVHPPWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbVHPPWY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 11:22:24 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:61274 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965266AbVHPPWX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 11:22:23 -0400
Received: by wproxy.gmail.com with SMTP id i2so1214203wra
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 08:22:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X/szceSIOvAt+GrQD3dWlF9vKhkNWhIIN7MITTTtSE7gdTSQe7g9S0DXew4kCZ1kxNJ18/F9dLIrnucoGbNw+mNWKaZ5/mlsvd2MyRLsMv5F+afwQ146P98WuDTifSAjkmZK/yEzYwWcsmrwJBmYaLVN4yXFRMeJLTFlqPGMH/M=
Received: by 10.54.132.14 with SMTP id f14mr4366470wrd;
        Tue, 16 Aug 2005 08:22:20 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g9sm195498wra.2005.08.16.08.22.19;
        Tue, 16 Aug 2005 08:22:20 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508160335420.1574@wgmdd8.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 15 Aug 2005, Junio C Hamano wrote:
> 
>>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>Maybe we should enhance git-applymbox to detect whitespace corruption in 
>>>particular, and output the User-Agent header (or if that does not 
>>>exist, the Message-ID header; thanks, pine) on error.
> 
> Alternatively, SubmittingPatches could include a big fat CAVEAT, and a 
> note that the submitter might want to send a single SP to herself, save 
> the received mail and check that all is well, prior to sending the first 
> patch. I mean, well, erm, it is sort of, uh, annoying, to send out a 
> corrupt patch *speaksofyourstruly*.

Here are some hints on how to successfully submit patches inline using
Thunderbird.

This recipe appears to work with the current [*1*] Thunderbird from Suse.

The following Thunderbird extensions are needed:
	AboutConfig 0.5
		http://aboutconfig.mozdev.org/
	External Editor 0.5.4
		http://extensionroom.mozdev.org/more-info/exteditor

1) Prepare the patch as a text file using your method of choice.

2) Before opening a compose window, use Edit->Account Settings to
uncheck the "Compose messages in HTML format" setting in the
"Composition & Addressing" panel of the account to be used to send the
patch. [*2*]

3) In the main Thunderbird window, _before_ you open the compose window
for the patch, use Tools->about:config to set the following to the
indicated values:
	mailnews.send_plaintext_flowed	=> false
	mailnews.wraplength		=> 999

4) Open a compose window and click the external editor icon.

5) In the external editor window, read in the patch file and exit the
editor normally.

6) Back in the compose window: Add whatever other text you wish to the
message, complete the addressing and subject fields, and press send.

7) Optionally, undo the about:config/account settings changes made in
steps 2 & 3.


[Footnotes]
*1* Version 1.0 (20041207) from the MozillaThunderbird-1.0-5 rpm of Suse
9.3 professional updates.

*2* It may be possible to do this with about:config and the following
settings but I haven't tried, yet.
	mail.html_compose			=> false
	mail.identity.default.compose_html	=> false
	mail.identity.id?.compose_html		=> false
