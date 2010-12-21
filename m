From: Scott Kyle <scott@appden.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 21 Dec 2010 14:56:22 -0800
Message-ID: <AANLkTimCjRq=rJ5FA7QRCyp=7B8q5R7AtuVPiTimwVR8@mail.gmail.com>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
 <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
 <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org> <4CFEA249.907@web.de>
 <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
 <20101207212949.GA25162@burratino> <AANLkTinjzvCDjCFrvujdFPRZKo2vK_9_8j3ybLNAfFmE@mail.gmail.com>
 <20101212063848.GB17185@burratino> <4D06621F.6010101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Kevin Ballard <kevin@sb.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 21 23:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVB8U-00045C-2c
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 23:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0LUW4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 17:56:45 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53214 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0LUW4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 17:56:44 -0500
Received: by wwi17 with SMTP id 17so4495766wwi.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 14:56:43 -0800 (PST)
Received: by 10.216.11.8 with SMTP id 8mr798450wew.0.1292972203183; Tue, 21
 Dec 2010 14:56:43 -0800 (PST)
Received: by 10.216.244.137 with HTTP; Tue, 21 Dec 2010 14:56:22 -0800 (PST)
In-Reply-To: <4D06621F.6010101@web.de>
X-Google-Sender-Auth: CPW-cBBoGZAzrpqv6ZWPGxWuCyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164062>

On Mon, Dec 13, 2010 at 10:12 AM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
> Am 12.12.2010 07:38, schrieb Jonathan Nieder:
>> Scott Kyle wrote:
>>> On Tue, Dec 7, 2010 at 1:29 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>>> Scott Kyle wrote:
>>
>>>>> If I set the "submodule.<name>.ignore" then diffing around inside=
 my
>>>>> history will not show the changes to that particular submodule.
>>>>
>>>> Even if you set it to "dirty"?
>>>
>>> Setting it to "dirty" is far less disruptive, you're right, but tha=
t
>>> wouldn't do me much good since my submodules are often on different
>>> branches while developing.
>>
>> Ah, I see now. =A0How about something like this? =A0Untested, just a
>> vague sketch to show the idea.
>
> Me thinks your proposal of a new "worktree" option makes sense. Let's
> hear what Scott says ...
>

I mostly really like how 'worktree' can let me focus in on only the
submodules I care about.  The drawback is that git status would no
longer list my true status.  I know that may sound hypocritical, but I
intended for this patch to only affect my PS1.  At the same time, I
would like to see the 'worktree' patch taken, regardless of whether
you guys find mine useful.
