From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sun, 5 Feb 2012 00:19:53 +0200
Message-ID: <CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
	<20120204201218.GF22928@burratino>
	<CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
	<20120204211544.GC3278@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 23:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtnxg-0004Th-2i
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 23:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891Ab2BDWTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 17:19:55 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56504 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663Ab2BDWTy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 17:19:54 -0500
Received: by lagu2 with SMTP id u2so2409487lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=q4N/dFOilcmftrU+waKlVaYFu6GX4HqFnqVAceAvW9U=;
        b=g4lU1iIa/qXXMOO5TdOUQLN/dWOdaU4YzDz0yQrvumWCoyORqVMP98lqRMk4EQcxpx
         qiVdX7+VkPhq5UNnCKLn7iA3yrwVLeMq1TBKkp+IR+tefdvjztXMMLTFojcK77SV1fJp
         80vffrJFacTr4lRsq8G2QQodUwNNScDkGCVGk=
Received: by 10.152.125.20 with SMTP id mm20mr1805475lab.6.1328393993324; Sat,
 04 Feb 2012 14:19:53 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 14:19:53 -0800 (PST)
In-Reply-To: <20120204211544.GC3278@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189917>

On Sat, Feb 4, 2012 at 11:15 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> Title: mailmap: add simple name translation test
>
> Thanks. =C2=A0I guess you think I'm stupid. =C2=A0I have no idea how =
I can
> correct that assumption and help you to actually work with me to make
> the code better. :/

You mean the commit message, you haven't made any comment about the cod=
e.

If you want to know why I had to modify those test assertions, you
really need to look at the code. In essence; all of them use the same
repo, and obviously adding a new commit message changes the output of
the commands.

--=20
=46elipe Contreras
