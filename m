From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: checkout on an empty directory fails
Date: Thu, 5 Jan 2012 18:06:45 +0700
Message-ID: <CACsJy8A42n4t+WqGaTx7vDQ3jP_YkD1bB0WL9amrrg1B4eOx7w@mail.gmail.com>
References: <4F0576D9.4030207@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgRG/Dnw==?= <doss@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 05 12:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RilAK-0002bv-Oh
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 12:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab2AELHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 06:07:18 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57466 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab2AELHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 06:07:17 -0500
Received: by eaad14 with SMTP id d14so249626eaa.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 03:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=x3nrkp677+Snz2eHJd3P/N+/Pmot7Hx9f3qpwLobDQw=;
        b=kfBpg9cxoL/svGksSY9JOFqSk3yLGJqZb4PgbE44WJRAMMI/K47MDdhGibubKDIHUb
         lP9qRb0wMsvQhF7mzGdeGp999lKN4Z/eN6jyN0QAZRLOXkQXBCD4ZEz8OyCbsB+G5Dmj
         aB4PZvbTOa4LPlNSXEVfmW7pXhUk+Yp0BOUPQ=
Received: by 10.204.129.213 with SMTP id p21mr616588bks.8.1325761636351; Thu,
 05 Jan 2012 03:07:16 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Thu, 5 Jan 2012 03:06:45 -0800 (PST)
In-Reply-To: <4F0576D9.4030207@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187969>

On Thu, Jan 5, 2012 at 5:09 PM, Ren=C3=A9 Do=C3=9F <doss@gmx.de> wrote:
> I have a clean derectory ang the git database. Now I want check out t=
he
> master.
> The master is the last commit. The files name =C2=A0are displayed but=
 not stored
> out in directory.
>
> Why can not I =C2=A0check out?

try "git checkout ." but be careful because this command overwrites
any changes you have in the directory.

>
> red@linux-nrd1:~/iso/a> ls -a
> . =C2=A0.. =C2=A0.git
> red@linux-nrd1:~/iso/a> git checkout master
> D =C2=A0 =C2=A0 =C2=A0 SP601_RevC_annotated_master_ucf_8-28-09.ucf
> D =C2=A0 =C2=A0 =C2=A0 rtl/ether_speed.vhd
> D =C2=A0 =C2=A0 =C2=A0 rtl/ether_top.vhd
> D =C2=A0 =C2=A0 =C2=A0 rtl/ether_tx.vhd
> D =C2=A0 =C2=A0 =C2=A0 rtl/takt.vhd
> D =C2=A0 =C2=A0 =C2=A0 sim/makefile
> D =C2=A0 =C2=A0 =C2=A0 sim/tb_ether_top.vhd
> Already on 'master'
> red@linux-nrd1:~/iso/a> ls
> red@linux-nrd1:~/iso/a>
--=20
Duy
