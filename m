From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] format-patch: add --prefix to prepend a prefix to output 
	file names
Date: Wed, 10 Jun 2009 09:18:00 +1000
Message-ID: <fcaeb9bf0906091618l406116d8k307f6661b451d030@mail.gmail.com>
References: <1244547227-6466-1-git-send-email-pclouds@gmail.com> 
	<4A2E6407.1010402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEAaM-0005nD-2Z
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 01:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbZFIXSV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 19:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbZFIXSU
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 19:18:20 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:24743 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZFIXSU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 19:18:20 -0400
Received: by an-out-0708.google.com with SMTP id d40so459077and.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JQOfMkRgLMgnhHox7C0QMvWmV3PnpqGgpcSS5xYhP/4=;
        b=XGQyTRe3gueb7Ztd3fLvBW75PD3DaEjxlPjc+i5VOG8SgkwxPm18yWAo+ldZ4vk7gD
         eJaznHJlA7dbZSYAw/cIzbQRVR2Hg7lWLeImb2RVt4Gr10soUPB/XXcBA8zqe83+c1YC
         4nrlNH8iUGCvoqYkVNLaOpm5P4oN1/vS0d2Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T2JRR7udtDU+PcmDPhzJpFAExqXus6iOolSkSdqInlpSr0i3pH0i89xh2nu14M1CMe
         oj6mbQn70h6UjB0aih0E8gGoNGTkCMNZTPkAiU+y/4li5lDbd971teGNx9HkITXdvBgZ
         NBgs7jR7qYkkTPSVjqviGgmHSTonjzvjBHNRs=
Received: by 10.100.120.9 with SMTP id s9mr685065anc.158.1244589501983; Tue, 
	09 Jun 2009 16:18:21 -0700 (PDT)
In-Reply-To: <4A2E6407.1010402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121236>

2009/6/9 Johannes Sixt <j.sixt@viscovery.net>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>> I use git to manages patches in my Gentoo development. In Gentoo,
>> all ebuilds (another form of RPM spec) corresponding to different
>> versions of the same package are grouped into one directory. So patc=
hes
>> for each versions usually have a prefix to separate them from the on=
es
>> for other versions. With --prefix it comes handy to produce such pat=
ches,
>> for example:
>>
>> git format-patch --prefix dbus-1.2.3- HEAD~5
>>
>> will generate patches for dbus-1.2.3 for me, all starting with "dbus=
-1.2.3-".
>
> Can't you use --output-directory/-o? It is not the same, but almost.

-o seems to put slash at the end (in reopen_stdout()) but I don't want
to create another directory.
--=20
Duy
