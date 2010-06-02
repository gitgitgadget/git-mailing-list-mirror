From: John Tapsell <johnflux@gmail.com>
Subject: Re: git locate
Date: Wed, 2 Jun 2010 19:02:00 +0900
Message-ID: <AANLkTil38OLw3J6ZPvv2wNu98QuTXJKtNwRZP0NDZPWn@mail.gmail.com>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
	<alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
	<m3zl49bk0o.fsf@localhost.localdomain>
	<alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
	<4B579BA8.8050000@gmail.com>
	<fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
	<AANLkTim6cLkr5BFTRTh2nZGwsfVgHZi3M-b9IER8dHf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 12:02:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkmG-0002DM-Mr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 12:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab0FBKCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 06:02:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:32872 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab0FBKCB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 06:02:01 -0400
Received: by pvg11 with SMTP id 11so2234585pvg.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=HbsZWkGzTvYjvCz2m9lln0d1cl/m7sfJXF4tErYvhSI=;
        b=jxf4cEJ6hm16gR4wu4bS3N8IU0NO1fjYvpR0FxUPyCEM3KOerNXShwedIjhwoc0Ufv
         7lIYUsZvAQpSyqy75q29nb4wkoAFozX7giBycJ3zX13hewDVbOD3w2JfqlORwzWsrkmY
         qcpqYDSpDndmrMSBE+raS+KVIJzDNi/OO9NKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=H7gRjhZzCW4Syo76ZnT+9I4LoL94SdjTpQa6fz6PTX9g14lM+fTAm5etcY+tekkCHI
         RrDi/XH9QCMVH6Yv4v8ThB7rC+JXhnBPh8XiVicxU9VsxxfoDRRJpKbuWOZ60g6X67m8
         FQpZiNJBrhS7Y1S84IkNE1TpajBY2wsMj3TAo=
Received: by 10.115.135.24 with SMTP id m24mr6669221wan.129.1275472920269; 
	Wed, 02 Jun 2010 03:02:00 -0700 (PDT)
Received: by 10.115.79.12 with HTTP; Wed, 2 Jun 2010 03:02:00 -0700 (PDT)
In-Reply-To: <AANLkTim6cLkr5BFTRTh2nZGwsfVgHZi3M-b9IER8dHf3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148240>

On 2 June 2010 14:00, John Tapsell <johnflux@gmail.com> wrote:
> On 15 February 2010 22:20, Sverre Rabbelier <srabbelier@gmail.com> wr=
ote:
>> Heya,
>>
>> On Thu, Jan 21, 2010 at 01:11, SungHyun Nam <goweol@gmail.com> wrote=
:
>>> The alias 'git locate' and the command 'git ls-files' runs
>>> differently if I run them in a subdirectory.
>>> Is it expected?
>>
>> I just ran into this (I wanted to alias 'git find' but to me the 'ru=
n
>> ls-files from cwd' is desirable. Also, I prefer to have a trailing
>> glob as well, so I added one :). An easy solution is to drop
>> 'git-find' in your path somewhere:
>
> I have finally settled on:
>
> [alias]
> =C2=A0 =C2=A0locate =3D !sh -c 'git ls-files | grep --color=3Dauto "$=
1"' -


Actually could someone help me with this.. the trouble is that this
returns paths relative to the root.

Can I get it to find all the files, but relative to where I am now?

John
