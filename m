From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Wed, 02 Mar 2011 14:12:38 +0100
Message-ID: <4D6E4246.5080407@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net> <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com> <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 14:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuluW-00006I-AF
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 14:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab1CBNQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 08:16:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37338 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690Ab1CBNQF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 08:16:05 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D56F5209BD;
	Wed,  2 Mar 2011 08:16:03 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 02 Mar 2011 08:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1oKq2X2VpM5ghIjRKxDHbctGo+8=; b=jAOCtuPPbeQUZLupfH70baCEKqvbw9QK3VRsHKWp/z8HI/ooSCLEvy8cR9fDYqENQqr9F1QwEntL34cAAOblutRDO1SBXNLZQ27AE4RPVZzXqo+erbt8oxeNIdhHdfH2RKrLj1yo9G//ZI3aa00bEmV0WVruw3KizFkLxTGUN0M=
X-Sasl-enc: Btvgj504nbbS4UA+DMhoxoQbiY1gyWnaqXlXgMtCtkYo 1299071763
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29E4F446C57;
	Wed,  2 Mar 2011 08:16:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168309>

Nguyen Thai Ngoc Duy venit, vidit, dixit 02.03.2011 13:57:
> On Wed, Mar 2, 2011 at 7:34 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Heya,
>>
>> On Tue, Mar 1, 2011 at 16:01, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>>> I have to say I'm really excited about how transparently this works
>>> across all kinds of commands, and how suggestive this is with rev:path
>>> in mind.
>>
>> I like it, especially considering how small the impact on the codebase
>> is. The downside is (once again) backwards compatibility though, I
>> haven't heard much on how to address that, other than "just quote it"
>> (which _I_ think is fine, people with filenames that start with fancy
>> characters are probably used to quoting them anyway)
> 
> Yeah. And if this is accepted, the "git add -u (without dot)" issue
> may cool down. I personally don't mind typing "git add -u :" (or "git
> add -u :/").

Why not even ":)"

Seriously, I'm glad this is gaining support. As for the notation, I
tried to take several things into account, which is only possible by
compromising somewhat on some:

- usability (as short as possible - 1 char optimum, 2 at most)

- suggestiveness, e.g. ":path" like in "rev:path" in line with git
usage, or "/path" in line with unix usage (although this has the wrong
connotation of being anchored at root)

- backward compatibility (new code does not misinterpret old notation)

- msysgit compatibility (I think "/" has issues)

- disambiguation from other notation (notably rev:path)

I ended up compromising slightly on the last one. Note that this does
not introduce additional ambiguities for existing use cases[*], only for
the new notation, i.e. commands expecting "treeish pathspec" need a
helping double dash when they are feed the new :pathspec without a treeish.

Michael

[*] I keep forgetting that some people may have files whose names begin
with ":". They are ambiguous now already with "treeish pathspec"
commands, but not with "pathspec" commands. The latter would change.
