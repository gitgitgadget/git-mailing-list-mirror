From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add case insensitive support in matching pathspec
Date: Fri, 4 Feb 2011 20:00:17 +0700
Message-ID: <AANLkTi=8-NibvV0NMCpA_KN6+x3GNa0mDr87jtWki_-S@mail.gmail.com>
References: <1296751106-15316-1-git-send-email-pclouds@gmail.com> <201102032117.32745.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Feb 04 14:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlLHT-0000yj-7n
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 14:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab1BDNAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 08:00:50 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46884 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1BDNAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 08:00:49 -0500
Received: by wwa36 with SMTP id 36so2318184wwa.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=97ADZ0fpSsXASY8D3A0XRzMh6iYPAwrozHpH2nb009E=;
        b=Ug+Jo4iZtENHFVObEExl+XXZAfJdilJAFuFpOkB0c6P94bA3sODM3jsEyECBLyGS7B
         +9Lrbj61GOR57OeWqGPQZ8WA5Nivgxbe37CWEJdEL7Ulc6hDk+Kc75glcwS8Ih2LWYdN
         IxeEoC417XQIrVe7afN9MxyqXgXRTnTtwZOY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gx+edQrSnyygq7VM4+VFcUruuO+a+M4RRSN0GF/v/SPPzTLfXAhLlP59HwtQbrHvZ/
         /G9bet+BlMOfKIEIKKmDa7Uutwk3TeGOT6lKvRV/l04PloI2ZNhHo+j0eOLweOgOt6QY
         tIG98jiEdW+9Jo8sGz4Mua5VwD6oCfLOfZATY=
Received: by 10.216.87.130 with SMTP id y2mr11017817wee.58.1296824448077; Fri,
 04 Feb 2011 05:00:48 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Fri, 4 Feb 2011 05:00:17 -0800 (PST)
In-Reply-To: <201102032117.32745.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166040>

2011/2/4 Johannes Sixt <j6t@kdbg.org>:
> On Donnerstag, 3. Februar 2011, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy wrote:
>> Commit 21444f1 (Add case insensitivity support when using git ls-fil=
es
>> - 2010-10-03) teaches match_pathspec() to ignore case when
>> core.ignorecase=3Dtrue.
>>
>> match_pathspec_depth() is developed independently and does not have
>> this feature. Teach it.
>
> Is match_pathspec_depth() used to match names of files on the filesys=
tem, or
> names of files in the index or in the repository?
>
> core.ignorecase should be honored only when files on the filesystem a=
re
> matched, IMO.

Names in index, just as same as match_pathspec().
--=20
Duy
