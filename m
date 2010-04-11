From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.1.rc1
Date: Sun, 11 Apr 2010 17:14:30 +0000
Message-ID: <s2s51dd1af81004111014za26552e9vba2dd629675d1c1d@mail.gmail.com>
References: <7vmxxar5h7.fsf@alter.siamese.dyndns.org>
	 <y2i51dd1af81004110908mcf6ce8cahf04225d7c261a85b@mail.gmail.com>
	 <m2pr26c4jt.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O10k3-0003Rs-DA
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab0DKROd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 13:14:33 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45664 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab0DKROd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:14:33 -0400
Received: by bwz19 with SMTP id 19so12210bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fptrJRmFXUcRJTMSsBQ1b0YVFwZ89zKszp9Y3fzA/kA=;
        b=TQqlqaCagVtAucX2FPj27zm8OOKdsvSnPsBnS5pSaxgbDAFWlxvuaPwBYft6gedAN3
         utTh8bRmIy2o2WI/L+P8Sul26H7rRwBisc0gHKSTos0fGeSjsm0T7uRTTA6A/qa9Ya0g
         OaJ7JNwllZdfxMZ5I3+5UsCjF1AyggLq2gPMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TAaOSG1MNRn5ICV+2EziRL8BPhkkyD8rcnjsNXBi5kzvBHdZ1aTctDPC5uejUqLuxI
         6tCLSqMcuADFQhOAogZDQw6VKrm+h9JAVG2usATaShmm2qLaU5DnCPlRnV6ITe3IgEEP
         amiW/nHUofUpqo/Ju2wxgA3bzxFwUFtV0S/Dk=
Received: by 10.204.121.195 with HTTP; Sun, 11 Apr 2010 10:14:30 -0700 (PDT)
In-Reply-To: <m2pr26c4jt.fsf@igel.home>
Received: by 10.204.4.211 with SMTP id 19mr3273193bks.166.1271006070791; Sun, 
	11 Apr 2010 10:14:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144660>

On Sun, Apr 11, 2010 at 16:55, Andreas Schwab <schwab@linux-m68k.org> w=
rote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Apr 11, 2010 at 04:13, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> A release candidate Git 1.7.1.rc1 is available at the usual places
>>> for testing:
>>
>> This is a minor nit but when I generate the info docs from master I
>> get this at the top of user-manual.texi:
>>
>> =C2=A0 =C2=A0 @menu
>> =C2=A0 =C2=A0 * : id2860714.
>> =C2=A0 =C2=A0 * Repositories and Branches::
>> =C2=A0 =C2=A0 * Exploring git history::
>> =C2=A0 =C2=A0 * Developing with git::
>>
>> I can't find what produces that token but here are all occurrences o=
f it:
>
> That appears to be because the first title is empty:
>
> $ head -n 9 user-manual.xml
> <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> <!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://ww=
w.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
>
> <book lang=3D"en">
> <bookinfo>
> =C2=A0 =C2=A0<title>Git User&#8217;s Manual (for version 1.5.3 or new=
er)</title>
> </bookinfo>
> <preface>
> <title></title>

The original error is going to be in user-manual.txt. That's where I
couldn't track down the error. The XML and TexInfo files are
automatically generated from the .txt source.
