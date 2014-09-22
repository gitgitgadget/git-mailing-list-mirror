From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: How to compile Git with NDK?
Date: Mon, 22 Sep 2014 14:04:12 -0500
Message-ID: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 21:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW8uI-0007Le-Br
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 21:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaIVTEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 15:04:14 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:39035 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaIVTEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 15:04:13 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq11so4467162vcb.39
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=YpZPpkCDYS11+c2KdwWssOoauD/BJ1H8MVeNwvdaoiw=;
        b=Hbwv1oV8oZZkbO0AIhd3qlbCExIML1p3J+ckQRJttHHAhd0dQohqoCT/RIzhXRTV7r
         FSSBeUDnpKonlfPgRVKV0cuC+yIUN8Ztxqdd4vlDxlBW5MQUv8VKbhkQtTE6LxmjOc8I
         foxFH7OKtUnf7OBYCufiHfgaICKg1js78Is56+3/OqWQyD1WNuv7LygvtqlsVlCRG3So
         iMyrfbqeAGunMv9bpf22j27MqsT7Sz0r7nhsTbhuiC1JNH92XlUTF43oB5w7rmo8zLGG
         6FDXiEpwFu5geWNeqSrwd677z+ydBV3xKtC2qsv2iwhjpy0xI0sHI7KBH9JuIAZ6V4Dx
         2kYA==
X-Received: by 10.52.119.239 with SMTP id kx15mr2718099vdb.70.1411412652848;
 Mon, 22 Sep 2014 12:04:12 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Mon, 22 Sep 2014 12:04:12 -0700 (PDT)
X-Google-Sender-Auth: 9MdOK-SqtThRz7LGFpkTvTdtGRY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257376>

I run the following on Ubuntu:

fe@BLD01:~/code/git$ autoconf
fe@BLD01:~/code/git$ ./configure --prefix=/home/fe/git-arm
--build=x86_64-linux-gnu --host=arm-linux-androideabi
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
checking for arm-linux-androideabi-gcc... arm-linux-androideabi-gcc
checking whether the C compiler works... no
configure: error: in `/home/fe/code/git':
configure: error: C compiler cannot create executables
See `config.log' for more details


I have my NDK's prebuilt GCC 4.8 toolchain on PATH (the bin folder).
Can someone help me cross compile Git using Android NDK toolchain?

Thanks.
