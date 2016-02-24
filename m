From: Jacob Keller <jacob.keller@gmail.com>
Subject: using git-diff as a diff replacement?
Date: Wed, 24 Feb 2016 14:21:08 -0800
Message-ID: <CA+P7+xq7gobJbbRxm51APMQ8408jyvW64=1y3wo3jz3rjMsDqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:21:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYhoK-0001U8-LS
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758224AbcBXWV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:21:29 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33295 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538AbcBXWV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:21:28 -0500
Received: by mail-io0-f173.google.com with SMTP id z135so69859418iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Jrd7bxcd6yFNts7MEBmIIdjJuV3WyqgzY/6t7FBCad8=;
        b=t4ZEWw+PiRGCaXX3whqGOMyK/RGHB5UR1tNVlxwPbbxgLc8USf0nP/Pot/puuE6Vta
         jizj/OMYmWwqZpCO/fxsXPD9j7DT1+FS2QQ+RUX06U7Hz52oz6eP8r9gTkBLgoixvfMu
         2NTHfbdDbVmdhw36W+a+GEIXYuL8uPHLIRWw/AwmBY8A8Z2RYR+DqwmVE0hiooZXUTf3
         TNG+6OKP7AqLdUUacb4cVptBo5LxGCj/v/mN//rtppPj3jiuMCPTTVmuU49oAdkewma7
         Pgk+4dSYWUL+O30X5JSMpZ5PPWmJlcKpj615ZG7nOkBOSsESK2DMKOU+2UQ5+r8v5XPe
         Au9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Jrd7bxcd6yFNts7MEBmIIdjJuV3WyqgzY/6t7FBCad8=;
        b=XiBmkE/+DqbFcDG1V+C4RZ77i1+R4D9mSrKwCQLZAvwPhNiZcjUetZziIrLqIgKvH1
         Hf7MkFiVr9zxG4+oBXIi4QOJdX226hU6IuG8oQovIpLb5a8Zqtvf+uDF3Kt3IfhWUoTa
         3iQmLW7kSBNBhjZwEzWlBltB0M66IeJXtVT/oMcM5LMk087qcCtVVSOU66XHJnAlSy0g
         lLyIDJk7QV5TYkWmc4yFnf8LiFGczV6sDNTtvXa5Z0je05MCK2eahE6UBHVEKCjq+lj3
         VlT4D7dR9J9uR3WZlEl/aH+UzYlT8BdCJFYczbGc5dl1MLD4B5zi/MGFPY8UrEzDk5jU
         vmZg==
X-Gm-Message-State: AG10YOSNZMH8D1qhiGYhMaeM15V2iRhJY5e+hipEuTGYH+2ZXF2WETLI0Gq0SQ/zN5hRkTQG5UIwEJjct81U7w==
X-Received: by 10.107.156.14 with SMTP id f14mr47853753ioe.0.1456352487565;
 Wed, 24 Feb 2016 14:21:27 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 14:21:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287238>

Hey,

I know that running "git diff <path> <path>" when outside a git
project will result in a normal diff being run. I happen to prefer the
diff algorithm and diff output of "git diff" but there does not seem
to be a way to have this behavior from within a git tree.

Is there a way to pass an option to git-diff which will result in
strict file comparison?

Thanks,
Jake
