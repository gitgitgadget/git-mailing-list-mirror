From: Sylvia Liu <sylviaonlyone@gmail.com>
Subject: Re: HELP: cannot clone a repository via http_proxy on FC13
Date: Wed, 2 Jun 2010 09:18:48 +0800
Message-ID: <AANLkTimF_RslttIFQ0rE-Muvy41vQsniZ5fHxJhx8-md@mail.gmail.com>
References: <AANLkTimefBKp5So03RKaZRqQXePO1KY6EgMRxN0zsf8M@mail.gmail.com>
	<AANLkTinyKoH4QiTnIbBQ60sMNZHKqtYejk-t2ygj9naK@mail.gmail.com>
	<AANLkTinSTJiUdtWbidlnUkJ2Gh6KczaSu56p3cwSgv5k@mail.gmail.com>
	<AANLkTimXYT71cjmLBmF0GWFQeb4pBmNDtfLpAmC4REE0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 03:18:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcbf-0007ts-81
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab0FBBSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:18:49 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:33938 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab0FBBSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 21:18:48 -0400
Received: by pzk15 with SMTP id 15so1878987pzk.15
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4Q767uNbqqQHBnAcpSKa4G4JygBaOExuu4IVT4de+CE=;
        b=fR9a73CGEl2V/Uynlxlc5ZVXjea4ROdQnWfvzRsKnICjgiuUYc9O3CLxtSiXeiyxjw
         uNzMtSp+iMyiiOunpewVpC/dXIMWzmfKiI8eIFj6iPCaszF6RDlTtTArZg8/TU14vrSg
         DmbqUT5OM9tnisGcN1aLqQpf+mdJ53gP2BA80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PLExyTMxxyTLnz6qRKL53vga4LhZo7lXf+j3p6Y1SXrFvzOSdk2QzpYK7vIDNSJhOj
         f+sSF5meb/Eams8veHWDvORqy1J65odM7p21dhfaiW6XV2/M11jYD1Gqb3YVllxe2muk
         8wfs6ioRXD56/Ovowkz1+EpaPiSLYpcJ0OZ9c=
Received: by 10.141.105.3 with SMTP id h3mr5560212rvm.196.1275441528097; Tue, 
	01 Jun 2010 18:18:48 -0700 (PDT)
Received: by 10.143.40.20 with HTTP; Tue, 1 Jun 2010 18:18:48 -0700 (PDT)
In-Reply-To: <AANLkTimXYT71cjmLBmF0GWFQeb4pBmNDtfLpAmC4REE0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148189>

Hi,

My sudoers file seems quite simple.
I haven't modified it except for adding my own user name in it.

-------------------------
=46C13 sudoers:
"
Defaults    requiretty

Defaults    env_reset
Defaults    env_keep =3D  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC
KDEDIR LS_COLORS"
Defaults    env_keep +=3D "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS =
LC_CTYPE"
Defaults    env_keep +=3D "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT
LC_MESSAGES"
Defaults    env_keep +=3D "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_T=
ELEPHONE"
Defaults    env_keep +=3D "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET
XAUTHORITY"

Defaults    secure_path =3D /sbin:/bin:/usr/sbin:/usr/bin

root	ALL=3D(ALL) 	ALL
sylvia	ALL=3D(ALL) 	ALL
"

----------------------
ubuntu sudoers:
"
Defaults        env_reset

root    ALL=3D(ALL) ALL
sylvia ALL=3D(ALL) ALL

%admin ALL=3D(ALL) ALL
"

On Tue, Jun 1, 2010 at 9:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jun 1, 2010 at 04:30, Sylvia Liu <sylviaonlyone@gmail.com> wr=
ote:
>> But on Ubuntu, I use sudo all the times, and it still works. Isn't i=
t strange?
>> And as I remembered, while I using FC12 before, it didn't work
>> neither; even without a sudo....
>
> What is your Ubuntu's and FC13 /etc/sudoers file like?
>
