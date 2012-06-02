From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: i18n: git-submodule message does not appear in git.pot
Date: Sat, 02 Jun 2012 13:35:51 +0200
Message-ID: <4FC9FA97.7020908@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, avarab@gmail.com, worldhello.net@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 02 13:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SamdJ-0002VW-50
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 13:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab2FBLfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 07:35:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36908 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab2FBLfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 07:35:54 -0400
Received: by eaak11 with SMTP id k11so777279eaa.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 04:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=QW7XJdJl1eAzGDepH/6xFgW5B6bJqqGCyZC01Js/dqA=;
        b=ARdOFOBVPQgShaotyjl/JkuKe5crVmxaOiQwhAGnyr7sGDfTlvKlaesjs35WnBJodd
         ymPtX3yvtcp8e9N6sy3FGmzJIWqLb3CU9jCOjLz4UWPaYE0jpwz/xK6evdTAHostzTQb
         S8RkTUsbWhVbrFfzL07JG4QJbeR02a4dKIXuYbYNVfBM4C2cJFO0CgrTCOufosPprxjh
         0n21y05Tmt48qrsZ6nOlYCj9wesMQbb0nlt7/9hzGYOCiFPFnN1C7Sl3unZ+GdmD1jwl
         PNeUfLkNyWszGyXv8p6LnE0OBOZ8yBWhk7gujyUjskXP5qMW0msbTeLeBPTyoWjDDTnh
         3MYw==
Received: by 10.14.99.79 with SMTP id w55mr2851080eef.59.1338636953233;
        Sat, 02 Jun 2012 04:35:53 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id y54sm16377074eef.10.2012.06.02.04.35.51
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jun 2012 04:35:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
X-Gm-Message-State: ALoCoQn5hxnu/Mon6khT1ijCfyI/4blmrDYoOIl+a27KwChPi/jt2gaUj8plVEQvDE5Gu33lhs5Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199042>

In commit b9b9c22f [1] the string "--cached cannot be used with --files" 
is translated using an extra "--" between "gettext" and the string. This 
does not work because in the current git.pot file there is now:

#: git-submodule.sh:713
msgid "--"
msgstr ""

Removing this exta "--" fixes the problem for me (GNU gettext v0.18.1)

[1] b9b9c22f; Aevar Arnfjord Bjarmason; Sat May 21 2011; i18n: 
git-submodule "cached cannot be used" message.

Kind regards,

Vincent
