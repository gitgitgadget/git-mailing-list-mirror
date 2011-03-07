From: loody <miloody@gmail.com>
Subject: how can we git out source code base on git log?
Date: Tue, 8 Mar 2011 01:25:53 +0800
Message-ID: <AANLkTimAPBoHJX0iZOt949xQ8HeGPXRyKfD4CDNJFv7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 18:26:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PweCJ-0004E8-2X
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 18:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab1CGR0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 12:26:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46701 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab1CGR0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 12:26:13 -0500
Received: by eyx24 with SMTP id 24so1554632eyx.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=m7VkqQW6n2J7K3dBnHmHucCcERYa/Q2IGXwlftVScr0=;
        b=a1C5Wr/XwimSbwJXsLtKZRFIJVfLvIIwPC1feDr2PUQUci1ztg/8QvBrvISaS/uvXI
         VwwARmh5Pziszvlgj8OpsuuA6ZYr+g+sQ03MZLavwkJiVXKhubQpn5PhK5jFHTgWlVe3
         08LUW4KmKy1g857oWayNvfnIU3c4bpJlHfERM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hJ6siPMioPRPpNKP/zKEwI87mW/zNQIDYjkn0gsEswIzzGPdantOAYBzWKwCFDzUGP
         J8znTA/ovCtAJXa89m1FDZnOP1JQU2/qPnQ8RhbHI8JpnY7BRxB4GFgXxLFaIl5QEJuC
         FbrCP0r4A1QOMIK/4czDrTPF5ZeIbNmHWfQqo=
Received: by 10.217.3.198 with SMTP id r48mr3527140wes.89.1299518753897; Mon,
 07 Mar 2011 09:25:53 -0800 (PST)
Received: by 10.216.246.11 with HTTP; Mon, 7 Mar 2011 09:25:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168597>

Dear all:
There is a paragraph in faq which told us how to git out some specific tag.

But how could I check out the source at some specific point of time if
I have no idea what the tag is or there is no tag on it.

Below I use uboot for example:

commit 3831530dcb7b71329c272ccd6181f8038b6a6dd0
Author: Mikhail Zolotaryov <lebon@lebon.org.ua>
Date:   Wed Sep 8 17:06:03 2010 +0300
.......
.......

commit b75a2dde47cc0ffb686e21cbf1aea4a45e23df10
Author: Daniel Hobi <daniel.hobi@schmid-telecom.ch>
Date:   Mon Oct 11 18:03:35 2010 +0200
    tools/imls: fix comment in Makefile

Is it possible I can check out the commit as
3831530dcb7b71329c272ccd6181f8038b6a6dd0,?

Meanwhile, is there any command can help me to get the history that
combine tag and commit such that I can know know the closest tag of
some specific commit?

take below for example, I will know ccdd is the closest tag of commit
b75a2dde47cc0ffb686e21cbf1aea4a45e23df10.


commit 3831530dcb7b71329c272ccd6181f8038b6a6dd0
Author: Mikhail Zolotaryov <lebon@lebon.org.ua>
Date:   Wed Sep 8 17:06:03 2010 +0300
.......
.......

Tag: aabb

commit b75a2dde47cc0ffb686e21cbf1aea4a45e23df10
Author: Daniel Hobi <daniel.hobi@schmid-telecom.ch>
Date:   Mon Oct 11 18:03:35 2010 +0200
    tools/imls: fix comment in Makefile
......

Tag: ccdd


-- 
Regards,

miloody
