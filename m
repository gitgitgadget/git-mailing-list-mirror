From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 18:00:59 +0200
Message-ID: <AANLkTi=cvObd83_5qiUxLKmVxiTMP2kgMfXaRb3uo4YY@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<87k4h34bhj.fsf@catnip.gol.com>
	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>
	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
	<4D58D2DF.1050205@viscovery.net>
	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
	<4D5906FD.7030502@drmicha.warpmail.net>
	<AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
	<4D59316E.5090203@drmicha.warpmail.net>
	<AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
	<4D594911.40409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 17:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp0rM-0001xL-L3
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 17:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab1BNQBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 11:01:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60433 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1BNQBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 11:01:01 -0500
Received: by eye27 with SMTP id 27so2331535eye.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7IctCcLCCMfWK7GkUczj15l3r0CqnBz5ywBvqLAKw/Q=;
        b=KcTSw+Sv1RCsXDRHuFer8F+9kFZtnlmkaAywVDVclYMimDkcNMYCu15hItY9fJ15vg
         JTCjM07aPNBBORbNaBxjkz2YX8Xq3E+/RqJ2yTzhqN4oRTDA9pwXCl9/jGnkpuLPCQal
         /T14Bh+ZwTvPPAr7th2r4jNBHHuGsdcD0e6V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eTMBRgt2xuE1eN5/Ap9OOqIoTYK49shvvYHnAhIBjnXcH6W7h5tLTGMM0D6NJqzxH2
         9wN46dXm42Pt0hEjIvOLURSUYWDvKnxh6xb2UaI5iuFDCyJmL7V/7vkP/BQpdiifxx+S
         byT/NztXqi1I/nZzTjpVPC71GJ2O8sct06wj4=
Received: by 10.223.79.14 with SMTP id n14mr736138fak.19.1297699259701; Mon,
 14 Feb 2011 08:00:59 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 14 Feb 2011 08:00:59 -0800 (PST)
In-Reply-To: <4D594911.40409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166730>

On Mon, Feb 14, 2011 at 5:24 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 14.02.2011 15:17:
>> On Mon, Feb 14, 2011 at 3:43 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>>>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>>>
>>>> Be careful with your fingers. There's a command named "git stage".
>>>
>>> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.
>>
>> I have proposed before to extend 'git stage', so you can do 'git stage
>> diff', or if you alias 'git stage' to 'git s', just 'git s diff'. This
>> would not conflict with the old behavior of 'git stage $file'.

[...]

> In principle I like this a lot: a set of commands operating on/with the
> stage/index/cache consistently. It think it's similar in (good) spirit
> to our earlier attempts at INDEX and WORKTREE pseudo-revs, trying to
> give that somewhat nebulous (for noobs) index a more concrete
> "appearance", not hidden away in options (--index, --cached) and
> defaults (diff against index by default).
>
> In our case, however, I think the design principle deviates from our
> common form:
>
> git foo bar
>
> usually means "do foo" to "bar", as most of our common commands are
> verbs (being applied to the object "bar"). When it comes to subcommands
> we do have inconsistencies already (double-dashed vs. undashed, e.g.),
> but I'd prefer fewer ;)

Except 'git branch', 'git tag', 'git remote', 'git stash', and 'git
submodule'. In fact, every logical object in git seems to have their
own command, except the stage.

-- 
Felipe Contreras
