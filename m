From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: svn clone Checksum mismatch question
Date: Thu, 26 Mar 2009 14:54:50 +0100
Message-ID: <fabb9a1e0903260654n5e682c49hbad3d2ece093af3f@mail.gmail.com>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet> 
	<D92CD911394B11428C65AFB4222835AE01255586@mercury.totalrepair.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Gilbert Liddell <gliddell@totalrepair.co.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:57:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmq4X-0005Qd-Cj
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 14:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbZCZNzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 09:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbZCZNzK
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 09:55:10 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54703 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbZCZNzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 09:55:08 -0400
Received: by fxm2 with SMTP id 2so563280fxm.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dE41KOARQQAj/MLuDlapjDJfyKsfSNRvu/vAgRDBKuY=;
        b=WpreNauVT4FjLKO7nYgpZRXrKyQKLo82kAfAbe6/NPKLOdmai6MB6skAoo/YYzuDCR
         byjG813EOpARK+l9IuB9SgeSzUVUmwn/6vgfZUn4mJ3x8E6QJemVZvN7YBnI0e8q+pkS
         CIgllkz7ytcGPiAe/G49XEvG6w88Wpd7kwlU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IR7edU1ZHQLZLcMrfFN8n0nFCZfTejxSNAHUiL37J6zmLBX0VZavVJZAxoDfYiuMp2
         MzZS6Tf5+c7PVRWx/8/KL2wryVdYnu3vLTpJOXXn8AkzhihrYtPFHjbpYxO3Z+yOiD7T
         85ews9gUCQkbpJEhPJkVkgRHSbzpnaqKNk9+Q=
In-Reply-To: <D92CD911394B11428C65AFB4222835AE01255586@mercury.totalrepair.co.uk>
Received: by 10.103.160.10 with SMTP id m10mr416438muo.50.1238075705397; Thu, 
	26 Mar 2009 06:55:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114779>

Heya,

[We do not top post on this list, instead it is customary to reply
inline, as I and Bj=F6rn have done]

2009/3/26 Gilbert Liddell <gliddell@totalrepair.co.uk>:
>2009/3/26 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> On 2009.03.26 03:31:53 -0700, Gilbert Liddell wrote:
>>> This morning i decided to test the clone with the full project i'm =
working
>>> on (11,000 files) and I get the error message Checksum mismatch: vn=
2.sln
>>> 0f7a82f1d38b819 expected: fde799e5ba0d1d07e6b539016bea3260
>>> got: e71db1010a0da06ea76d4163c452df72
>>>
>>> Can someone help with why this error is happening? Is there an issu=
e with
>>> the GIT clone and large repositories?
>>
>> Which git version is that? There was some bug in git-svn that caused=
 it
>> to fill the disk with temporary files, without noticing that those f=
iles
>> get truncated when the disk is full. That was fixed in some 1.6.0.x
>> release IIRC.
>
> Thanks for the reply, i'm using git version 1.6.2.msysgit.0.186.gf751=
2

Seems like it could be one of the known bugs of git-svn on windows?
(ccing Dscho and J6t)

--=20
Cheers,

Sverre Rabbelier
