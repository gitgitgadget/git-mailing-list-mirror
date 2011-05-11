From: Richard Peterson <richard@rcpeterson.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 14:39:34 -0400
Message-ID: <BANLkTik3i8rcgDSo4A9nQjnvr-gWmnkpmQ@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
	<BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
	<m2d3jr1mev.fsf@Spindle.sehlabs.com>
	<BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
	<BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
	<7vwrhygmrp.fsf@alter.siamese.dyndns.org>
	<BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com>
	<7v39klgng7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 20:39:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKEJz-0005SJ-7p
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 20:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1EKSji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 14:39:38 -0400
Received: from edgy.cirtexhosting.com ([75.126.140.58]:48782 "EHLO
	edgy.cirtexhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab1EKSjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 14:39:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41091)
	by edgy.cirtexhosting.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <richard@rcpeterson.com>)
	id 1QKEK5-0003K2-Ro
	for git@vger.kernel.org; Wed, 11 May 2011 14:39:49 -0400
Received: by ywj3 with SMTP id 3so269258ywj.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 11:39:34 -0700 (PDT)
Received: by 10.236.182.105 with SMTP id n69mr6006720yhm.199.1305139174804;
 Wed, 11 May 2011 11:39:34 -0700 (PDT)
Received: by 10.147.98.11 with HTTP; Wed, 11 May 2011 11:39:34 -0700 (PDT)
In-Reply-To: <7v39klgng7.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - edgy.cirtexhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - rcpeterson.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173420>

On Wed, May 11, 2011 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Richard Peterson <richard@rcpeterson.com> writes:
>
>> On Tue, May 10, 2011 at 7:26 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>
>>> Devils lie in the details. =A0For example, should squash/fixup come=
 before
>>> or after the squashed commit when --reverse is in effect, and why?
>>>
>>> Should "rebase --reverse --continue" work after it gets interrupted=
, if
>>> not why not?
>>
>> Yes, it should work,...
>
[...]
>
> You start 'rebase' (without --reverse); it stops with conflict. =A0No=
w what
> should happen when you say 'rebase --reverse --continue' now? =A0Does=
 it
> error out because you are not allowed to change your mind once you
> started?

It just continues. "--reverse" is noise here. "--reverse" would only ma=
tter
in the display of the initial list. It's just as much noise here as
'--interactive'
would be noise here, like 'rebase --interactive --continue'.

> [...] Why spend extra effort only to introduce something confusing?

Because for some group of people, you are introducing something less
confusing. I have a hunch that some people see the *process* as the pri=
mary
artifact, and thus things make sense just as they are. Others see the *=
tree*
as the primary artifact, and want too see the transformation that will =
be
attempted on the tree - but interactive rebase has the tree upside down=
=2E

I have absolutely no support for this theory other than that I find mys=
elf in
the second group of people however small or large that group may be. I
conceive of a rebase as a transformation of the tree, rather than a set=
 of
discrete steps. Tools that help me work with that abstraction are going=
 to
be easier for me and others like me.

-Richard
