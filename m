From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] commit: do not switch branch during a rebase unless -f is given
Date: Tue, 28 Sep 2010 13:24:59 +0200
Message-ID: <AANLkTi=upKKahxpu5918yxW+J6nHWMvPfonJNB=yuCTy@mail.gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 13:25:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YJL-0008U1-C0
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab0I1LZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 07:25:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58145 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab0I1LZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 07:25:20 -0400
Received: by ywh1 with SMTP id 1so1861741ywh.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=asgf4bbuMq6a0nuGUTsb0XkZyVhgJdks9YudVMciOXc=;
        b=Gz+dXo4AmDeFEfhAGmzkbSViGVqvLOEfKf8on7HOfS9ghbTlTA9HdB2295YzFwc2T3
         Lcm0tt/WsgMOL1WrBQevNHrQDu3LGNEfdWBy2IldrfDgKaeyBulDRrsq5kaK3t1T993L
         Hffj669ODxL86VLjBX5ViR23TtRIO0GH+EhCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kPzAHKwpQcTpQ0hTq8W6gjOscpim4tj1udcI7yJvloUbDfZrHQd15LeAXZgA9xDrGI
         eINrC1ZpCzPCC+ErzC7NVmPtMlfharbBGXLPmI1M/y5DbOhZ72iL4EtFTPeEzuMraqgO
         7oDJ+o45vhAzd+V1eFVdRHOpsPGc8ZUe/qyRs=
Received: by 10.150.177.17 with SMTP id z17mr10519342ybe.122.1285673120138;
 Tue, 28 Sep 2010 04:25:20 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Tue, 28 Sep 2010 04:24:59 -0700 (PDT)
In-Reply-To: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157407>

Heya,

2010/9/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("You should no=
t switch branch during a rebase. Use '-f' if you really want to.");

On top of Junio's comments, I think it makes sense here to add "or use
'git rebase --abort' to abort the rebase that is in progress".

--=20
Cheers,

Sverre Rabbelier
