From: Per Cederqvist <cederp@opera.com>
Subject: "git submodule sync --recursive" documentation omission
Date: Wed, 2 Dec 2015 14:01:21 +0100
Message-ID: <CAP=KgsR+YuWFi=bK6HWdYPAEfppR4gYMeUd5ox9VO7jjdRmmGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 14:01:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a472G-0001Fy-74
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 14:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250AbbLBNBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 08:01:24 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33454 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbbLBNBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 08:01:23 -0500
Received: by lfaz4 with SMTP id z4so49416740lfa.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=k+m21UaC7mS9VqgiOJAbCs5xCbsznBwmmBqZ5KXHD/g=;
        b=SpDtCZwZtKejTEtIKxx4GuanRAisFMGnerM09NqeNuSR4QHRTzgKCew6Zr13BeOqab
         GXpBZQm2d8zxTdKNAApaGZKH+kJ4nb+BSMo2G6y+4oIYNNsRSvkXHo8NWRZ0y6LTkZtc
         y71krrbgDb083FxOqTrdcySCGNXH6acWa2VmHpb7eD3bx9w9qcqJWPJ9s+/c1Gymnu9O
         LFoe+BsmtdGQ01fST/wfJw4AG5G+47a7CSKhEZVo9C97zQRtYiYUx4A3RYJkrUceMtNe
         Tv6wWpTYqqNrlV53enhsmDGpx6rmoLLSCcaAqvyYCiZQKrAgVc8fjXtBEdMN98M5FTGk
         zZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=k+m21UaC7mS9VqgiOJAbCs5xCbsznBwmmBqZ5KXHD/g=;
        b=IhqMJ+jj5TrD4frU54cvUm7qtOnjdpD70DdAliKXiS0snNzjof5SjIujO7RW2pbcMv
         E5iTnQjsDfT1tA9PUySqOChfbvMaIjmq/7cIAV4vpRB5+YTkoSgjjkqFcDB2M+YbvP8u
         8OKs3LZIHu3JwwnBOMIMGzk5KRdYngzwKraNdt4Uzk1Ry3S/6i+pgZ7rbi5mvGAt1i13
         DRJpkK2ujOkcjNh7IglywAL2l4npG2jbER0goOfLXWMYir8coH+8cw/mnAF7lCHLiN1E
         gt5asJNP2TaEnQIyiF2fr+pv6WZQAUPmQp10TNvM0iBSkyxmurA1QNv7QtDua4VvTsF8
         V5PQ==
X-Gm-Message-State: ALoCoQnkG8AWnpBKxVT9ybbsVm52HV30k4bXTyXgz0o1RfHH/zBl3RW/J347iG51a+eXc7WVQR/J
X-Received: by 10.25.148.204 with SMTP id w195mr2677191lfd.108.1449061281594;
 Wed, 02 Dec 2015 05:01:21 -0800 (PST)
Received: by 10.25.90.139 with HTTP; Wed, 2 Dec 2015 05:01:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281888>

The git-submodule(1) is inconsistent. In the synopsis, it says:

       git submodule [--quiet] sync [--recursive] [--] [<path>...]

The description of the sync does not mention --recursive, and the
description of --recursive says that it is only available for foreach,
update and status.

The option appears to work, so the documentation should be
updated.

Tested with version 2.6.3.

    /ceder
