From: Jussi Peltonen <peltoju@gmail.com>
Subject: Git clone gives zero file permissions
Date: Thu, 24 Apr 2014 11:24:43 +0300
Message-ID: <CACDOErWqjihSYi4r6r8cjfFcbWe+7H0Tihjmkn18Y-szn7cE2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 10:24:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdExg-0004gW-Ml
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 10:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbaDXIYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 04:24:48 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:55255 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbaDXIYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 04:24:44 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so2129048qcr.25
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+qya+gEenW2DOdiYqTdBpwSTHqjoF111N5wJrBHsMp4=;
        b=pFxk7e1puAhP2x3/BFB9AkvBhNXPR8SHrTv6cxiKAQeTDVxcN1Bhe4HyyrZTofFcX9
         JFhWcPBQKz7sq4qMuUyN4eAm9AM6klAlnWf80jH2OXB2NSplmdeuIhYXeuRSfm9Rzy09
         /Ezfe3vxTgM3w9ZKaccCRgLUpi+sKGvswmXSklVElXROMvxGRacXQcP6UhGr7A3D6oaP
         fTMl+oeLhX19uoRk4Et5+uJxOs5xFjwszfvz5lKt7olucB99IuyolN/suKmML4rteW0a
         RAP6wRcz0HJ7Geq/+uak2cDpglMf2l8TihkqqiKFLsmoKVGa+V04X2AdcASo2kDZM1cH
         91Bw==
X-Received: by 10.224.134.194 with SMTP id k2mr534118qat.5.1398327883625; Thu,
 24 Apr 2014 01:24:43 -0700 (PDT)
Received: by 10.96.143.200 with HTTP; Thu, 24 Apr 2014 01:24:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246947>

Hello,

I installed git to my Windows 7 workstation and cloned
"http://git.ipxe.org/ipxe.git" by using the Git GUI.

ipxe-23042014/src tree looks like this in Cygwin bash:

d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 arch
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 bin
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 config
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 core
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 crypto
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 doc
----------+ 1 peltoju Domain Users 62631 Apr 23 09:00 doxygen.cfg
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 drivers
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 hci
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 image
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 include
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 interface
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 libgcc
----------+ 1 peltoju Domain Users  6146 Apr 23 09:00 Makefile
----------+ 1 peltoju Domain Users 38982 Apr 23 09:00 Makefile.housekeeping
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 net
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 tests
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 usr
d---------+ 1 peltoju Domain Users     0 Apr 23 09:00 util

Files have no permissions, same goes with subfolders, e.g.

$ ls -l config/
total 47
----------+ 1 peltoju Domain Users  699 Apr 23 09:00 colour.h
----------+ 1 peltoju Domain Users 6961 Apr 23 09:00 config.c
----------+ 1 peltoju Domain Users  518 Apr 23 09:00 config_ethernet.c
----------+ 1 peltoju Domain Users  584 Apr 23 09:00 config_fc.c
----------+ 1 peltoju Domain Users  474 Apr 23 09:00 config_infiniband.c
----------+ 1 peltoju Domain Users  875 Apr 23 09:00 config_net80211.c
----------+ 1 peltoju Domain Users  478 Apr 23 09:00 config_romprefix.c
----------+ 1 peltoju Domain Users  555 Apr 23 09:00 config_route.c

Any explanation available?


git-gui version 0.19.GITGUI
git version 1.9.0.msysgit.0

- Jussi Peltonen
