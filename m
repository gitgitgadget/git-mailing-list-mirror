From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull updates for Git 1.8.3 l10n round 2
Date: Wed, 8 May 2013 08:21:19 +0800
Message-ID: <CANYiYbFcJgiBXUSQWUtvPmGOT3qmrVeuB4xaEtYOymLOEqmYzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>,
	Harring Figueiredo <harringf@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 02:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZs8L-0006Jh-PT
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 02:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab3EHAVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 20:21:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58141 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3EHAVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 20:21:21 -0400
Received: by mail-we0-f174.google.com with SMTP id x53so1188574wes.19
        for <git@vger.kernel.org>; Tue, 07 May 2013 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=cyD8AxWR6GSBh56rYva1q3JtjkfjhSFQw/fBdRmqKyc=;
        b=ULNV12JVugdB7l13VP8dO0aEGU407AJfTZrO/ktgQOSxpa/8MtUQ1YLjVrdauDthne
         9Q4si73Rf5YTT0lsgvbrhbZSQ/GMkfGIOhVWJ/9wNyn38AKV5V2oc15uTpyCB3x5KfEr
         wXZcnKL4JL23LnYl8kRwmUyt6uRdzj67dmTRwFMyZa8JCBLN1SQKh5LPEO4RLQntxM/v
         xCG1M/rMTGVTg1Tb8d2DvDQZiKLNpX9Kz8bv/cSH+MzmnOR3ITFbSeq8434ejTlbjs4u
         HGlOMdiKQnTtNbgGwWPa3P7KZZpanJc2QysAd+g7zl5KBatBCRM6opRNGZIo5c7QQIQb
         G9vg==
X-Received: by 10.194.59.132 with SMTP id z4mr6691528wjq.57.1367972479610;
 Tue, 07 May 2013 17:21:19 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Tue, 7 May 2013 17:21:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223632>

Hi Junio,

The following changes since commit 7e6a0cc47da79dd22c0338aee8750fda92ced5d9:

  git-completion.bash: add remote.pushdefault to config list
(2013-04-29 09:57:47 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 4dcdc3d8ccfb7e6ae3a2d151b5df59785548a040:

  l10n: zh_CN.po: translate 44 messages (2080t0f0u) (2013-05-08 08:13:32 +0800)

----------------------------------------------------------------
Jiang Xin (3):
      l10n: git.pot: v1.8.3 round 2 (44 new, 12 removed)
      Merge remote-tracking branch 'vi-vnwildman/master'
      l10n: zh_CN.po: translate 44 messages (2080t0f0u)

Peter Krefting (1):
      l10n: Update Swedish translation (2080t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 44 new messages

Tran Ngoc Quan (1):
      l10n: Update Vietnamese translation (2080t0f0u)

 po/de.po    | 1328 ++++++++++++++++++++++++++++++++++-------------------------
 po/git.pot  | 1175 +++++++++++++++++++++++++++++-----------------------
 po/sv.po    | 1268 ++++++++++++++++++++++++++++++++------------------------
 po/vi.po    | 1290 +++++++++++++++++++++++++++++++++------------------------
 po/zh_CN.po | 1258 +++++++++++++++++++++++++++++++------------------------
 5 files changed, 3650 insertions(+), 2669 deletions(-)

--
Jiang Xin
