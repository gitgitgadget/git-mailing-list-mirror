From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Wed, 25 Dec 2013 06:49:05 +0700
Message-ID: <CACsJy8ApEBq+G+swpBPPJwL1E94x-P+e+V_jYknG+rXybLxPgQ@mail.gmail.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
 <1387789361-29036-1-git-send-email-pclouds@gmail.com> <52B87759.2090901@web.de>
 <CACsJy8A7j_ERqH_TDuKDdssaLFCvM5yVT4eUjTqkN_qW4iXuGA@mail.gmail.com> <52BA0110.4050003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 25 00:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vvbjb-0000fr-8H
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 00:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab3LXXtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Dec 2013 18:49:36 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33733 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab3LXXtg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Dec 2013 18:49:36 -0500
Received: by mail-qc0-f174.google.com with SMTP id n7so6397875qcx.19
        for <git@vger.kernel.org>; Tue, 24 Dec 2013 15:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LhPh+dithb8S5avGhaAciGP6QUxEAxvEAV8xpErVuy4=;
        b=Ez+7JUx21vThPtVB2+njH2q0CoAOL1qRoKSsVDGdc7+VWNVEaKAiiLWoNlorVc0jyC
         EMZosDbXgESr6lt8U0Z073afYX3pMZnWzDyfiMQLpabvmJACGcNGIonS2S6FWOeeSLjf
         gojTs/PSC+tQi5EyyCi80ozpiMzwNujGgV+AA77vAvAZLWuZTwE53bXi+XZ9cyaT6wB7
         ukBvkSde+dkXlPgUsq/Y8AHmEaaCR1qMDiZRElCOA49U3hkr89BaTXQ6LrI4tGagfIGM
         ZqlBlMaoalE6grJDvnTXPvyuu6Az6HV8QXDKDjlgAkj8Y1pzrl0ahJ64qeK7n0129Buk
         C8ng==
X-Received: by 10.224.165.12 with SMTP id g12mr56000869qay.89.1387928975479;
 Tue, 24 Dec 2013 15:49:35 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Tue, 24 Dec 2013 15:49:05 -0800 (PST)
In-Reply-To: <52BA0110.4050003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239671>

On Wed, Dec 25, 2013 at 4:48 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2013-12-24 00.46, Duy Nguyen wrote:
>>
> [snip]
>> We don't complain about adding an empty directory before or after th=
is patch.
> Ok, thanks for the explanation.
>
> I think that
> https://www.kernel.org/pub/software/scm/git/docs/git-add.html
> could deserve an update.
>
> My understanding is that <filepattern> is related to $GIT_DIR,
> but "." is the current directory.
>
> I will be happy to write a patch,
> (or to review one, whatever comes first)
> /Torsten

filepattern is related to current directory too (e.g. "*.sh" from "t"
won't cover git-rebase.sh, ":/*.sh" does). Yes a patch to update
git-add.txt to use the term "pathspec" instead of "filepattern" would
be nice. A pointer to pathspec glossary could help discover
case-insensitive matching, negative matching..
--=20
Duy
