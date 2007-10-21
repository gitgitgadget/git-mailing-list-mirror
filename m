From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help
 option.
Date: Sun, 21 Oct 2007 14:42:25 +0200
Message-ID: <471B4931.5040102@op5.se>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org> <ED3FFB7A-861F-47E4-97EA-D7A05552FC2C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 14:42:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ija8g-00066p-IB
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 14:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbXJUMma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2007 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbXJUMma
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 08:42:30 -0400
Received: from mail.op5.se ([193.201.96.20]:59487 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbXJUMm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 08:42:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EE5721730578;
	Sun, 21 Oct 2007 14:42:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3EJ6p+DPOYO; Sun, 21 Oct 2007 14:42:26 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 5648F173056F;
	Sun, 21 Oct 2007 14:42:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <ED3FFB7A-861F-47E4-97EA-D7A05552FC2C@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61900>

Wincent Colaiuta wrote:
> El 21/10/2007, a las 4:06, Shawn O. Pearce escribi=F3:
>=20
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>>> On Sat, 20 Oct 2007, Jari Aalto wrote:
>>>>>
>>>>>> - commented out call to list_common_cmds_help()
>>>
>>> Well, I'm almost sure of the opposite.  One of the big results of t=
he=20
>>> Git
>>> Survey was that git is still not user-friendly enough.  Your patch =
would
>>> only make this issue worse.
>>
>> Actually I think Jari's patch helps for the reason originally
>> stated in the message (less output when you make a small typo).
>> Though I agree that the commented out code should just be removed.
>>
>> I actually had to do `git config alias.upsh push` just to keep
>> myself from screaming every time I made a small typo and Git gave
>> me a screenful of "helpful reminders".
>=20
> If you want to go really user friendly, how about a check against the=
=20
> list of known commands using a shortest-edit distance algorithm?
>=20

http://en.wikipedia.org/wiki/Levenshtein_distance

Implementing the algorithm doesn't seem terribly difficult.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
