From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to repair a shallow clone (?)
Date: Sun, 7 Dec 2014 18:44:09 +0700
Message-ID: <CACsJy8DshPJreCDOUYWO90E9jsDVe8XO_jVjMCcC=DV8EK6N5Q@mail.gmail.com>
References: <5482F55F.1060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 12:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxaJz-00046S-UZ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 12:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbaLGLol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 06:44:41 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:49346 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbaLGLok convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 06:44:40 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so1503511igd.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2014 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xupC01nv+NsjRdkN0lAo8uwmWGJacUmmPQIwdX/s89I=;
        b=hPmbOuwfa+dymrKrhpHzt/v1jPk3c7JskYlblwtJn6oy/IGhEXCfqyjHe59OfuOqOI
         2bIuHpipRlimEM8GOyvAsRiZOCH5zpkaNVhSbzybH86pKaKVlH15eRauz5rofPRKa2Ix
         Z35In3UJ5hcJwR+ih66i80Eqj5QdiimTjqJzDbYrtMFk+7LcE/TIt3cvUvWGeGYKCz12
         zxTbMMc9Pb7oQv5iZ86okQ3fhQAedKrZ2QIo2E0wrt7RBMaGm/xE4TS0mISt3yz+lXVy
         cWC9OPaUClycDqOlUaVyxpMYdwGtcrVX3AEsgUCwgQvOPjfFXbsyxyKxbAmDqTeNIkZI
         pMCg==
X-Received: by 10.107.135.34 with SMTP id j34mr6282096iod.84.1417952679545;
 Sun, 07 Dec 2014 03:44:39 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Sun, 7 Dec 2014 03:44:09 -0800 (PST)
In-Reply-To: <5482F55F.1060008@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260988>

On Sat, Dec 6, 2014 at 7:23 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> I share a bare repo with Sparkleshare which does an auto-synch.
> Now the synch had stopped, and trying to push to the central repo
> by hand gives this:
>
>
>
> git push  origin master
> fatal: protocol error: expected old/new/ref, got 'shallow 72fb4080921=
221293e28a97a0e8c78d6100c5186'
> fatal: The remote end hung up unexpectedly
> Counting objects: 4, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (4/4), done.
> error: pack-objects died of signal 13
> error: failed to push some refs to xxxxx
>
> Both machines have Git >2.0.0

Please try again with $GIT_TRACE_PACKET=3D/some-log-file. receive-pack
>2.0 should recognize this shallow line.

> Is this a known issue/problem ?

No.
--=20
Duy
