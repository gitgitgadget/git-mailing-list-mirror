From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t6041-bisect-submodule.sh tar -z not portable
Date: Mon, 9 May 2016 18:58:38 +0200
Message-ID: <CALR6jEi19WAKvs=UKivh_Gz=UhnkLcJR_a2QHikL4kz+3H84VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:03:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azoW4-0001BU-KC
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbcEIQ6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:58:40 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34687 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcEIQ6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:58:40 -0400
Received: by mail-yw0-f175.google.com with SMTP id j74so255496105ywg.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=RJ6IKvcK7TSSjdKhAMhuldKSK9/lmDwvkBOBZw3A21Q=;
        b=ol0hvdzxUYrJzZ+dz/oWk5Vt/IUHSQsx2erlYVnFb0KLKQUwQ+kSlYr/h1WPuv0qep
         3kV/0jV7YCtTn07aj12aukfrHnd8gzOFGQd+WsLBFn/xTuClQmLM+rZC19px+ao6Xsoh
         U+x5+Pil6uzUYoI2cNc5PWrtUlEmjcUBaRD++gv+gR+xGlDU6Bu4OZRDULBqpobxpdPJ
         NXGLWMZZovBxYvvQCCQJZDhpmthWdXC/SbyfDiz8Gc3uWIGX4PGKqZ6dYlT8r2MZC3Sw
         ug/M4YCyaV5j1J5utTxlkGJxFW6QHZIrnNG54wfIXzxFEjkymvV7Sn4D5+3lB8yulU0w
         7wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RJ6IKvcK7TSSjdKhAMhuldKSK9/lmDwvkBOBZw3A21Q=;
        b=PQp+pFThCDQNLEO5PhIXH0XvRvaWLeW56zMG8LOFKtw4voHBGlDU+rgQU+YbG21DGG
         LnmfiV9gV+vTCsD7JLhbM/X4ySv4uZIre1lVoybPD/bRsWZXolxhgqbx9SAKOTgaWsYk
         iIrNxFADnLF+nG1V4rYROqAwcszQ1nnim3Mesr3qMy0jTrB500pEgyEam4rIZJuybaQ+
         L3E940OKcLYhpGEgFdQaaQFpcmsuWIIS/0E0u70feWLWB39K8UeKrHTGthn5YWSRyiwk
         WH/ExTYuoNv5LOmtkOQDq76CBI0Y7OMy8ERdHPVHzZEgl2Wr0l2u8NDlOV8ijpYYVpLu
         s4ZQ==
X-Gm-Message-State: AOPr4FVL1Wm8Q2eRL1uOui4eitt8zsYR67Xg10LVG/tHTHb+1j6tlc6ay3tA3o5n7Kqhe9tpeCOjhRV6oW3NpQ==
X-Received: by 10.129.92.132 with SMTP id q126mr19992923ywb.156.1462813118996;
 Mon, 09 May 2016 09:58:38 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 9 May 2016 09:58:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294017>

Hi,

similar to t3513, in t6041 tar is used with the -z flag which is not portable
and should be removed the same way as in t3513.

Regards,
Armin
