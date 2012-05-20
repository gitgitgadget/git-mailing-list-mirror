From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 20 May 2012 12:58:28 -0500
Message-ID: <20120520175828.GB3000@burratino>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
 <20120519060031.GB23799@burratino>
 <CAMP44s2cGeQq3V=jS1Xjg-S0-rMyKS79XFN9yFm+4KxMo963OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 19:59:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWAPH-0000D1-9H
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 19:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab2ETR6h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 13:58:37 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49596 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2ETR6g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 13:58:36 -0400
Received: by obbtb18 with SMTP id tb18so6944087obb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TVpXAkdrAImbvrWjtzEF/6YIMbepKQLJ/48AYvfB+Qw=;
        b=oZEQSifd1aUDn43oI2LZ3aQI+gklTixQWCRtFgPniWxNKb4lVlKSJRR9nzRfGd4Bze
         7LGByCWiB13m/xHGqIzhFjfSOffRbcs/XhXF7XiT7IaoQO+gxaAiSJTz+K1EW6cIMNlX
         yTsmAJqvl80wqobeg18g/A3MnFM6bOydhq4SjbWloPisMUSA3LucoykxOOrnmyHbtFFR
         BQRGY+BTybNzhItwusTO6Vyp5kUrvoCyW9aLZZn7EYY8t0KyiZxqFcwAWGLihw2osCuK
         lALyM6ZzfXD33FTNRWaipY/ASiYtrlfAW0PBuyYaXy9n32PUhZhdPEeZmhBOq9WL2HVO
         cnhw==
Received: by 10.50.181.232 with SMTP id dz8mr4989637igc.72.1337536716084;
        Sun, 20 May 2012 10:58:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ai6sm9824391igc.0.2012.05.20.10.58.33
        (version=SSLv3 cipher=OTHER);
        Sun, 20 May 2012 10:58:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2cGeQq3V=jS1Xjg-S0-rMyKS79XFN9yFm+4KxMo963OA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198065>

=46elipe Contreras wrote:
> On Sat, May 19, 2012 at 8:00 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0The "index" file (see gitindex(5)) typica=
lly holds a snapshot of
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the content of the working tree, and it i=
s this snapshot that is
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0taken as the content of the next commit. =
=C2=A0Thus after making any
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0changes to the working directory, and bef=
ore running the commit
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0command, you must use the add command to =
add any new or modified
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0files.
>
> I find this paragraph completely unnecessary. This is useless
> distraction; the user wants to know about 'git add', she doesn't need
> to know about the index, and we should hide it from her.

Ok.  Have you seen the current git-add(1) manpage?  Do you have
patches that improve it to avoid such useless background information
in a non-confusing way?

Jonathan
