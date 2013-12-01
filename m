From: Ingy dot Net <ingy@ingy.net>
Subject: GIT_DIR not auto ignored
Date: Sat, 30 Nov 2013 23:06:11 -0800
Message-ID: <CAHJtQJ77drefyhjrs_C8bEq14ZiSNf6Boztqx+JYx51dRtrd-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 08:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn16v-0007Q8-II
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 08:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981Ab3LAHGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 02:06:13 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:61905 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab3LAHGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Dec 2013 02:06:12 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so8869639wgg.0
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 23:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=TaKqaW0DXJSN+4EylpT+BGuZGiLtLD6EiVjMk6GO0r4=;
        b=h7DvsvS/SqZHe7PsMTe5tA28SpG9DHkHBbVlLf2aryc9xBFoenXpSOOGgo+EGPco2M
         /j91z/eYMXF95KfbIYsOqvGdwSOFIjwT4kiIf5d3mlU3HcTBli39etE1jwkynVZ7+3gy
         t4N7D1xtv1AKHKHsUwMzvs2a2fh8I3OHTd7MvYXh3ezv8CQ6Xy7Cfq/YBUvIZU1csInw
         cI4ZQ9A5EEDpF6TdMclRJyQeq+4r599ItUZTG9YAWxUHy1FQYYPFe8TkO372ezaOnVOF
         m0BVc0OrRzWYCQP28UWcvMtup9buK574dDZyh+R1p8+6a6/dB8siLJRXhm83cKrB8Cza
         6IJA==
X-Gm-Message-State: ALoCoQnk/7s1HHRHnuv0UxNE0uXLE657mDXRv8DGCJWEmw0MAPLH5qvlOmOAY5EDWxeJbxBpgvel
X-Received: by 10.181.12.20 with SMTP id em20mr13319840wid.0.1385881571597;
 Sat, 30 Nov 2013 23:06:11 -0800 (PST)
Received: by 10.227.40.198 with HTTP; Sat, 30 Nov 2013 23:06:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238578>

Greetings,

I found this probable bug:
https://gist.github.com/anonymous/01979fd9e6e285df41a2

Cheers, Ingy d=F6t Net
