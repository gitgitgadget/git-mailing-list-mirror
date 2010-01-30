From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 13:23:45 +0000
Message-ID: <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 
	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com> 
	<4B642696.2070501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 30 14:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbDJS-0006xB-Jz
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 14:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab0A3NYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809Ab0A3NYO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 08:24:14 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:33882 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab0A3NYO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 08:24:14 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:60995)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NbDJ4-0005UJ-4j
	for git@vger.kernel.org; Sat, 30 Jan 2010 08:24:10 -0500
Received: by ewy28 with SMTP id 28so421545ewy.28
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 05:24:05 -0800 (PST)
Received: by 10.216.88.78 with SMTP id z56mr1320370wee.37.1264857845162; Sat, 
	30 Jan 2010 05:24:05 -0800 (PST)
In-Reply-To: <4B642696.2070501@web.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138474>

On 30 January 2010 12:31, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 30.01.2010 01:46, schrieb Jonathan del Strother:
>> On 29 January 2010 17:44, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jonathan del Strother <maillist@steelskies.com> writes:
>>>
>>>> Heya,
>>>>
>>>> git-stash in v1.7.0-rc0 gives me several hundred lines of :
>>>> The previous build I was using -
>>>> 5b15950ac414a8a2d4f5eb480712abcc9fe176d2 from Jan 19th - didn't sh=
ow
>>>> this problem. =C2=A0Want me to try and bisect further?
>>>
>>> Yes, please.
>>>
>>
>> ee6fc514f2df821c2719cc49499a56ef2fb136b0 (Show submodules as modifie=
d
>> when they contain a dirty work tree) seems to be the first bad commi=
t.
>
> Thanks for pinning that down.
>
> I assume you have one or more submodules, maybe even with untracked
> or yet uncommitted modified files in your tree? If so, what does git
> status say in the superproject and in the submodule(s)?
>

Yep, I have 10 submodules.  However, they're all completely clean with
no tracked or untracked changes shown in git status.  Anything else I
can investigate?
