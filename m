From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Committing a change from one branch another branch
Date: Thu, 13 Mar 2014 15:26:24 +0530
Message-ID: <CAD6G_RRQVDxQj==-2vAT3WCiYMC=BmZhi__JWi4yy86Uaoa-og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 10:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO2NO-00041Z-6x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 10:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbaCMJ41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 05:56:27 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:48576 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbaCMJ4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 05:56:25 -0400
Received: by mail-yh0-f52.google.com with SMTP id c41so720998yho.39
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qpuQ7dfAH+wJYbtpl4qMTFXuXxyTRjHsaatHOG1rZvw=;
        b=vsTbLNhzHpun+oeUBdm2T9EVIch7X4F/4bjCkEMBETHfKraco2eNcnFVpJfoQ+D8r1
         gukLcdp5yuDsl4+XKxMsLpLhgGdLIsAAL0G/9cBVogPCQtDzzGBKB+E6GnPxS69EGdME
         YZP9D87DhGDNL29PjCzIEXhKMf5V4Nitx2btRn/TuZ+2hQ+/FpWI3t4no1DDZHNkeslo
         p5CluR2l+ElK36MVcE/jsVTTD/nOtSC7zzpyG0fYdO8lMTFQpjdvMsC0fvh60DyQxbLZ
         8GW0nJuekyVnidTdQH1jM/KYDxr5/JOERwiOHivtcO3F60N9OddFfoCzUky051ZlC2AX
         82lA==
X-Received: by 10.236.125.168 with SMTP id z28mr1042249yhh.59.1394704584489;
 Thu, 13 Mar 2014 02:56:24 -0700 (PDT)
Received: by 10.170.34.215 with HTTP; Thu, 13 Mar 2014 02:56:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244026>

Hi,

I have two branches.
- master-b1
- master-b2

Suppose I'm in master-b1 then did a change
on master-b1
$ git add test/init.c
$ git commit -s -m "init.c Changed!"
$ git log
Author: Jagan Teki <jagannadh.teki@gmail.com>
Date:   Thu Mar 13 00:48:44 2014 -0700

init.c Changed!

$ git checkout master-b2
$ git log
Author: Jagan Teki <jagannadh.teki@gmail.com>
Date:   Thu Mar 13 00:48:44 2014 -0700

init.c Changed!

How can we do this, any idea?

-- 
Jagan.
