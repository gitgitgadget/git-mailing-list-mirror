From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Git abuses qt4-ssh-askpass
Date: Sat, 10 May 2014 03:54:48 -0500
Message-ID: <536de9584815a_239010732fc43@nysa.notmuch>
References: <CAMw+j7L1YkwjYZibOpuJDnC3FjaRZgBCKBMQcUyT9uRis3heFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Q2hyaXMg4oCcS3dwb2xza2HigJ0gV2Fycmljaw==?= 
	<kwpolska@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 10:55:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj33d-0008Eq-Qu
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 10:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbaEJIy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2014 04:54:57 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:43825 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbaEJIyz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 04:54:55 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so2079796igb.6
        for <git@vger.kernel.org>; Sat, 10 May 2014 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=fmq6V5bNxN1rklqoFwDfyofulBeEIvO8/x0qMWVdWdw=;
        b=SBzDFUpT2afZuA7wAkmJhNH0hDXedlRA5Ms5JzcjJd5kw26WBiR6N1DPxqRj8vs6Nf
         mVtiJHiztv32TG5CvkjkN1287BiDhrY0Ec8AnPsg3nWBHuNppd2DCyP5/uzYFpxxdCYa
         K/y2M19Hx0X2kRSrR3u1s26RU+j4muiesdz409N0eMjS/n61T7OmOsE3KWw/eDRnVjmn
         x21h45M3zLcIlz8b5NRyriNUTTvJ1SGuxkdq53YapDVvc6uO2eAj5JUXs3U/uh33iiRC
         PtxomeYRPwK3xtAnmov6EK/frPeUT494tCx6sdy5aUFyPUI8TmBgVDy6FalIjXQBSsyW
         iNtw==
X-Received: by 10.50.25.136 with SMTP id c8mr19390821igg.26.1399712095312;
        Sat, 10 May 2014 01:54:55 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e6sm5285523igq.6.2014.05.10.01.54.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 May 2014 01:54:53 -0700 (PDT)
In-Reply-To: <CAMw+j7L1YkwjYZibOpuJDnC3FjaRZgBCKBMQcUyT9uRis3heFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248655>

Chris =E2=80=9CKwpolska=E2=80=9D Warrick wrote:
> when I=E2=80=99m using the HTTPS protocol to access repositories, a w=
indow
> from /usr/bin/qt4-ssh-askpass comes up.  It asks for my =E2=80=9CSSH =
pass
> phrase=E2=80=9D, twice.  Sadly, it=E2=80=99s wrong.  The actual thing=
s it wants is the
> username in the first case, and the password used to access the remot=
e
> repository (eg. my GitHub password) in the second question.  This is =
a
> bug, and very misleading behavior.

Same in seahorse (two password prompts).

--=20
=46elipe Contreras