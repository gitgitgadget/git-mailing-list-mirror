From: =?UTF-8?Q?Jos=c3=a9Quintas?= <jmcquintas@gmail.com>
Subject: Windows 7 - long/short and upper/lower filename
Date: Mon, 3 Aug 2015 18:18:40 -0300
Message-ID: <55BFDAB0.8010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 23:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMN8C-0000hw-3R
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbbHCVSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2015 17:18:44 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34065 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbbHCVSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:18:43 -0400
Received: by qgeu79 with SMTP id u79so98628168qge.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=T6h7Ib6j5nnl9TkStY+vNRMCW7eBUzdffLFS06wv+2M=;
        b=oIXGAvueXWJwtLCeCoYCK9LDpKaipo2hFmkUWkNl8JDv5IJqGePqqGDOu9DdFX07Tw
         e4xsoz3iRrCGtzzWb0Y+g8eIAhHJZG47z588KDVyIyM9OTTuGLc9S09KfcBpk60FBYcT
         1vHTjUL8ezq1Pzz3qoqV4gIJPM1kt0hEoeli9zlcCwm7TTRaTQ6Y9k6W0aW7Gr0AQ2ec
         E5ZExJrgNuDUPsbXLzJiAdcOAKv2k30U3OEns2fRaC8j+aoEm58lucaN3F5+v/sPwm5L
         chusoM0lTMqp+ubu4tVe+o8KOqrhQKSTKGb+j+ZNg/Doe6ZcxDQ9EvYNlpMt3xT3eZxp
         h0JQ==
X-Received: by 10.140.128.65 with SMTP id 62mr755787qha.8.1438636722773;
        Mon, 03 Aug 2015 14:18:42 -0700 (PDT)
Received: from [192.168.1.3] ([177.148.218.127])
        by smtp.googlemail.com with ESMTPSA id l78sm3703480qkh.12.2015.08.03.14.18.40
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 14:18:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275206>

I am using Windows 7 64 bits.

1)

I have a filename called ze_xmlfun.prg
Last week gitgui shows 2 changed files: ZE_XML~1.PRG and ze_xmlfun.prg
At momment I can't update this file, because get a error.
Try delete file, update one name each time, but same error.
Seems that a unique file is considered as 2 files, and this causes erro=
r.

2)

When do a search in history, upper/lower case must be the same as in gi=
t=20
control.
If upper/lower is changed, is considered a new file.
How to configure git to work allways using lower case on Windows?

3)

Is there a plugin or a tool to make this, to new files and to update in=
=20
git repository?


Note: gitgui is a gui tool for git, ok, but once it uses git, may be=20
this feature/change need to be made in git.

Jos=E9 M. C. Quintas
