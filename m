From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 15
Date: Wed, 11 May 2016 17:12:47 +0200
Message-ID: <CAP8UFD0dkhiER5wnvykbLKftX=_g_iDghrW5Xuf96ESTu5FUpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <nick@durdn.com>,
	David Turner <dturner@twopensource.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Sytse 'Sid' Sijbrandij" <sytse@gitlab.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Spencer Krum <nibz@spencerkrum.com>,
	Roberto Tyley <robertotyley@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 17:12:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Voj-0006OV-LM
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 17:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbcEKPMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 11:12:49 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35577 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbcEKPMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 11:12:48 -0400
Received: by mail-wm0-f44.google.com with SMTP id e201so223293661wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=OyUN9czx9kpM1Ljsu6eUDKwQ1JOnIL+aB8GsgCewQrY=;
        b=iqHxmTvyYfGt0YTpRJoCqby6bHBp8eaAYGrjLGk09HwQwmEYk+V9Um3GvQ0UNhpuJM
         jl5cfy2kBj4bepqyoRwf6nTNYPBY56fHdKApvQosIWuSzqaMVz58cpoax7Ra7rHhdKst
         F4tE4dD/fKlixEblmLsRuorkKfpAKUI5wEm/TCTH9d2Kxh6FuHJDh6A97TdHi9qz6jmC
         2R6D3TmgY/ftNw7dVR6eEf00ttc8cEvp37D18vdUm60vHLDASsvN+YWg5+VMsDAkYim3
         5T1t51oZ6enLs3MpK2F5numLLs6FahpfKXFAp8fj6c/AiEOwQHpcAkEUjOG/SnGDfmGN
         UxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=OyUN9czx9kpM1Ljsu6eUDKwQ1JOnIL+aB8GsgCewQrY=;
        b=Lvn7hHTWMhl0V+zOCNvfkfJMUnnqu1IlKfcziQ2q1MPALkMvV+KMuj2aWjS9CrmEVN
         1Nox3Th6Lnak4Hf40GubarCvMNbtAPiYUZn1tuiuMOoOabIDU4vkiY0aZgbPDSFTJzSS
         6tFpb0x8Nhq2sd20GBo2USAVbQ/TniuipO/rSL5YuLzzg8XP4gkqxdEoVAP5729+neCW
         mmGrZYpzsVlpFj2v6M7eaJHp12elSrkt+bFbD9feeOscqFW+tdmK1jl+PY7jojtClHPy
         0D91pl0IriwwSy3xrCNomT5qMt51WiTDV1Hrx/SNwGUK9kZvCO2gQmK1uMgO+XsN9uNZ
         Gc0Q==
X-Gm-Message-State: AOPr4FW+NmnKXX6nin7NxUHzsAk6nLTq7dJHkmUurjKiPhpQ6Vj0b/xDOI6IzlNiZ1Tt/BuLIrlct2uCS49MZA==
X-Received: by 10.194.117.70 with SMTP id kc6mr4773913wjb.94.1462979567286;
 Wed, 11 May 2016 08:12:47 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 11 May 2016 08:12:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294350>

Hi everyone,

I'm happy announce that the 15th edition of Git Rev News is now published:

http://git.github.io/rev_news/2016/05/11/edition-15/

Thanks a lot to all the contributors and helpers, especially David Turner!

Enjoy,
Christian, Thomas and Nicola.
