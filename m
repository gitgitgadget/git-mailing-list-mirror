From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 16:36:45 +0000
Message-ID: <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 
	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com> 
	<4B642696.2070501@web.de> <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com> 
	<4B643DEF.8010809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 30 17:37:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbGK2-0000j8-Pr
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 17:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab0A3QhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 11:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322Ab0A3QhN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 11:37:13 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:42974 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab0A3QhM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 11:37:12 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:63606)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NbGJp-00086r-Tr
	for git@vger.kernel.org; Sat, 30 Jan 2010 11:37:10 -0500
Received: by ewy28 with SMTP id 28so594288ewy.28
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 08:37:05 -0800 (PST)
Received: by 10.216.93.1 with SMTP id k1mr812573wef.151.1264869425130; Sat, 30 
	Jan 2010 08:37:05 -0800 (PST)
In-Reply-To: <4B643DEF.8010809@web.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138480>

On 30 January 2010 14:10, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 30.01.2010 14:23, schrieb Jonathan del Strother:
>> On 30 January 2010 12:31, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> I assume you have one or more submodules, maybe even with untracked
>>> or yet uncommitted modified files in your tree? If so, what does gi=
t
>>> status say in the superproject and in the submodule(s)?
>>
>> Yep, I have 10 submodules. =C2=A0However, they're all completely cle=
an with
>> no tracked or untracked changes shown in git status. =C2=A0Anything =
else I
>> can investigate?
>
> The change in behavior my patch introduced is that "git status" is
> called inside each submodule. So i would expect getting the same
> errors when using this command:
> =C2=A0 git submodule foreach git status -s
>
> It should just show
> =C2=A0 Entering '<submodule 1>'
> =C2=A0 Entering '<submodule 2>'
> =C2=A0 Entering '<submodule 3>'
> =C2=A0 Entering '<submodule 4>'
> =C2=A0 Entering '<submodule 5>'
> =C2=A0 Entering '<submodule 6>'
> =C2=A0 Entering '<submodule 7>'
> =C2=A0 Entering '<submodule 8>'
> =C2=A0 Entering '<submodule 9>'
> =C2=A0 Entering '<submodule 10>'
> when the submodules are not dirty. What do you get?
>

Correct - I just get that output.
