From: Samuel Williams <space.ship.traveller@gmail.com>
Subject: Shallow Push?
Date: Wed, 8 Apr 2015 03:08:14 +1200
Message-ID: <CAHkN8V-pK3ngfShmTrAaR5gixhRKbWwDoM21QBVw6hp8AngTkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 17:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfV6z-0001Td-E7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 17:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbbDGPIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 11:08:16 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34371 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbbDGPIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 11:08:15 -0400
Received: by laat2 with SMTP id t2so37404079laa.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nzqJEK6Y+ctas5MpdKxaXe3UZ63MiNS4CMu1y6gs4Ow=;
        b=CmD9tfvbeklBgWM1cQhIRcJLoedy+LN12L8mUjfUmI23TQnsqehwkgYYZW6FL7fZ9G
         DUzHF0WKKi3mWzVXYnzATfRUAc3GL1MIBmWDa6X6V2QT0roDKD4GBzX3EjYvUKcN7gwU
         EDgJtnNAwDaQkBO0d+bEw4wXmsPR8gFL9nxXW7EjYO1jjW2vYaodKhmAXQKbF0Hj2pTR
         FFyncsj423Yf328F0qG/7TttU+YAs7rqRFI3J9QwmxsqxHvfHtfPgOQIeiQBwxLw1PIY
         jakdxX8OSGLoNvAmKJcpeEJI4CBpVo4T8JiMmbJ5nbTWVo+NIhz6RE0LCIJWGAzEVudY
         4v7g==
X-Received: by 10.152.37.202 with SMTP id a10mr19131715lak.0.1428419294236;
 Tue, 07 Apr 2015 08:08:14 -0700 (PDT)
Received: by 10.112.20.106 with HTTP; Tue, 7 Apr 2015 08:08:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266918>

Is it possible to only push what is required to checkout the latest HEAD?
