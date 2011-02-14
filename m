From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 11:42:05 +0100
Message-ID: <4D5906FD.7030502@drmicha.warpmail.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org> <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com> <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 11:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Povvi-0002G0-Di
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 11:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab1BNKpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 05:45:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47544 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab1BNKpL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 05:45:11 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E375F206A4;
	Mon, 14 Feb 2011 05:45:10 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 14 Feb 2011 05:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LlZSpTX/YtxxpZ5AQIWIEOXC43w=; b=A/GCOp6WwlsDj+ioiDQKoJk8c8r+mRwgLQ/FOzOrbZaAPIz68rb50lLlt1v/q2l4JsGFMv5RrQ14j4HGhtu44JVt3IWZ+TpV1j++9wXTXC2PXQtKu9ngikm3VA5IsNXC/FvEuBMTYIbSvDgu93rFg8DjkuaesRtObzmGt+vxVv8=
X-Sasl-enc: HsGgWCQqtu8TmbeEVfo7ALEDSR8OiQuNGjs9QuCq3WAx 1297680310
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A7E7340D10B;
	Mon, 14 Feb 2011 05:45:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166702>

Miles Bader venit, vidit, dixit 14.02.2011 08:07:
> On Mon, Feb 14, 2011 at 6:59 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 2/14/2011 7:27, schrieb Miles Bader:
>>> "git diff -s"  ? ... since --staged is an alias for --cached :)
>>
>> git config --global alias.diffc "diff --cached"
> 
> "Git should be convenient by default (for commonly used operations)"
> 
> -miles
> 

git diff --ca<TAB>

;)

At least if "by default" includes using the default bash completion by
default.

Short options should really not be "wasted" easily. "-s" named after "to
stage" is really problematic, as outlined in this thread. It's mainly
used (and has been introduced, I think) by "the other git community", so
to say. I feel that sticking to established terminology (esp. that used
in man pages and command messages) is more helpful for newbies. That
does not exclude using new terms for explaining that terminology, of course.

The term "stage" is in git's documentation all over the place - and
denotes the different versions of a blob involved in a merge.
Admittedly, that's something recorded in the index.

Full disclaimer: I have an alias "staged" for "diff --cached" myself...

Michael
