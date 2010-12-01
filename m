From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: msysgit clone/pull/fetch broken
Date: Wed, 1 Dec 2010 14:37:56 +0100
Message-ID: <AANLkTinaxO1FVb-MvY91mscUcpNtbxQH0vTvE4YJrJtB@mail.gmail.com>
References: <loom.20101201T141924-761@post.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?B?Wm9sdOFuRvx6ZXNp?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Wed Dec 01 14:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmt5-00078X-3x
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 14:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab0LANiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 08:38:18 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56690 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0LANiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 08:38:17 -0500
Received: by fxm20 with SMTP id 20so56047fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=3zcRHpggQnJNJlcxm6M60AFcrsUAKCtTD/ZAJZE3Aq8=;
        b=W4Wa8iJgWP34AOOxJO9tU4nSeQxtTLqnvduM2pwedCAElxJePgyXSwqw3ruG4yyOqU
         lPcGJtDXoxRkklnJoUPzCeuoZwgTTrSN75QN+tOQtOrKBLoeuc97Beve8dlrdT5cof9a
         Gs6AfO2qbqHyRwUX9d9krSpVmHw1vmaIIn1rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=OT3/N8ngumwObXmO92ZHeUGWW2uiJbA1kUfBF8xMF23++aMtyD9LKuKEXjziNugJwY
         GSmh7Kh9qYr56vCwxr4S9+06PiQn9f08absHSKRwuvwxE4JIq8w4rp6SAhUrNBv7gxoD
         W2RexyQs0koIRQEFGYmE/F0tSbzCCopDtVVhI=
Received: by 10.223.71.205 with SMTP id i13mr4129172faj.102.1291210696221;
 Wed, 01 Dec 2010 05:38:16 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 1 Dec 2010 05:37:56 -0800 (PST)
In-Reply-To: <loom.20101201T141924-761@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162516>

On Wed, Dec 1, 2010 at 2:31 PM, Zolt=E1nF=FCzesi <zfuzesi@eaglet.hu> wr=
ote:
> Hi, I can't clone/pull/fetch from any of my repositories with the lat=
est stable
> version (1.7.3.2.430.g208247) on Windows.
>
> $ git clone --recursive git://server/user/project.git
> Cloning into project...
> fatal: failed to read object <sha1>: No error
>
> After reverting commit 3ba7a065527a27f45659398e882feaa1165cbb4c ("A l=
oose object
> is not corrupt if it cannot be read due to EMFILE") it works.
>
> On Linux everything is fine.

I've already submitted a patch-series that address this issue:
<1290533444-3404-1-git-send-email-kusmabite@gmail.com>
