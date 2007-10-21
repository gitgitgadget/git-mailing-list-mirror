From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help option.
Date: Sun, 21 Oct 2007 10:58:56 +0200
Message-ID: <ED3FFB7A-861F-47E4-97EA-D7A05552FC2C@wincent.com>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 11:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjWfE-00054u-HJ
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 11:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXJUI7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2007 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXJUI7x
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 04:59:53 -0400
Received: from wincent.com ([72.3.236.74]:34901 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbXJUI7w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2007 04:59:52 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9L8xiYH003519;
	Sun, 21 Oct 2007 03:59:45 -0500
In-Reply-To: <20071021020653.GA14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61889>

El 21/10/2007, a las 4:06, Shawn O. Pearce escribi=F3:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>> On Sat, 20 Oct 2007, Jari Aalto wrote:
>>>>
>>>>> - commented out call to list_common_cmds_help()
>>
>> Well, I'm almost sure of the opposite.  One of the big results of =20
>> the Git
>> Survey was that git is still not user-friendly enough.  Your patch =20
>> would
>> only make this issue worse.
>
> Actually I think Jari's patch helps for the reason originally
> stated in the message (less output when you make a small typo).
> Though I agree that the commented out code should just be removed.
>
> I actually had to do `git config alias.upsh push` just to keep
> myself from screaming every time I made a small typo and Git gave
> me a screenful of "helpful reminders".

If you want to go really user friendly, how about a check against the =20
list of known commands using a shortest-edit distance algorithm?

   Unknown command: 'upsh': did you mean 'push'?
   Type 'git help' for usage.

Here's just one of many articles introducing the shortest-edit idea, =20
as popularized by Google:

   <http://norvig.com/spell-correct.html>

What do you think?

Cheers,
Wincent
