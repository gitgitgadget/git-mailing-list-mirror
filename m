From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Thu, 24 Nov 2011 12:39:49 +0700
Message-ID: <CACsJy8Dj3MmVFZpPXB9pYKyKbp=jifFr64Ckv38Y1c-JbuVXHg@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do> <7vk46th5bz.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7HVe8kLR5j9Ej0tJhpkxigCXRqpg9DvE9qJsfengi1Q@mail.gmail.com>
 <7vy5v6bvy4.fsf@alter.siamese.dyndns.org> <CACsJy8BYN-nu6a92dk-qpF5_jR_frKwg+DD1EThr2kMPGHV5kQ@mail.gmail.com>
 <7vlir69k0s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 06:40:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTS39-00082h-6i
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 06:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab1KXFkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Nov 2011 00:40:22 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46160 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1KXFkW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2011 00:40:22 -0500
Received: by bke11 with SMTP id 11so2500655bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 21:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ut0ra6SX0d+g13ffcZ7utljbFlDOZNDpQZk/9YWd4To=;
        b=hqpuGT9IhcTtXe7gj7GYvkzdS4+mO71fpnxK9/NrQ2q214DHs+CMUYiI3Zf7V/DxuV
         ysdV+5bvATbYkjqEJSWF8D7m4lxu/ahMVclkcVIkORxghmdh7YOUKXh/QC/cDyKBblVo
         3UQIf1Fe5OROcsjWUsn3ZpgnVIzzJxOAbGG/U=
Received: by 10.204.10.81 with SMTP id o17mr27501891bko.65.1322113220186; Wed,
 23 Nov 2011 21:40:20 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 23 Nov 2011 21:39:49 -0800 (PST)
In-Reply-To: <7vlir69k0s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185890>

On Thu, Nov 24, 2011 at 12:17 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> ...
>>>> I think we should do this regardless precious being added or not.
>>>
>>> Because (see below)?
>>
>> Because it may potentially lose user's changes. Assume file "A" is
>> tracked and also ignored. Users may make some changes in A, then mov=
e
>> HEAD away without touching worktree, now HEAD does not see "A" as
>> tracked any more.
>
> Huh? "A" is initially tracked and the user modifies it. Moving HEAD a=
way
> how? =C2=A0"git checkout" would refuse to check out a branch that has=
 different
> contents at "A", or is missing "A". So how can "now HEAD does not see=
 'A'
> as tracked any more" happen?

git reset <somewhere else>
--=20
Duy
