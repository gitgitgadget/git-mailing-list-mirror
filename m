From: Sivaram Kannan <siva.devel@gmail.com>
Subject: Git crash in Ubuntu 12.04
Date: Wed, 10 Apr 2013 12:11:46 +0530
Message-ID: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 10 08:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPoj9-0006PE-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933904Ab3DJGlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 02:41:47 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:52058 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3DJGlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:41:46 -0400
Received: by mail-ve0-f180.google.com with SMTP id c13so109775vea.11
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=8GU1oiuWwPFdyD0KiMAQriBNRDfx1f60/yp0UXIPtEQ=;
        b=IYiBsR/rOh+Io751OkXe0suf7DftHOjNLpCt78U4/uWCqKPSgezWaYLAJhhmvT3UOz
         +hsdWFxfeoRbi34cg9hfhYnYJwXjUuyXosWe8KZJdRhkJaN0xozG3Iyy6y95Rq2HKRFB
         5Am7sj4Z8r+Bf1039NWcMf67t3GFFIF2QqvzLqSk2lNvs72pOL+/KtoV0ZFXDH4rZQg7
         f8QwnGUa+KUClXKy3miEVwWchGIxmvLkyohcsnFqHORNWQ5Hr+b7HpvFOOzjUOhiDs6z
         g4eSZWE5ym26OIy2+hshXafsPZsEq7Uf3JQHTCKKt4/85L/TvBi1jsMv6zFGnIkuotOv
         kPAw==
X-Received: by 10.58.85.134 with SMTP id h6mr546038vez.18.1365576106065; Tue,
 09 Apr 2013 23:41:46 -0700 (PDT)
Received: by 10.221.3.131 with HTTP; Tue, 9 Apr 2013 23:41:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220662>

Hi,

I am using git with Gitlab/Gitolite configuration. Git version is
1.7.9.5 in Ubuntu 12.04. There has been a consistent git crash
recently and have attached the /var/crash/_usr_lib_git-core_
git.1001.crash file.

The crash output is pasted in the following link

http://pastebin.com/uAQS81BX

I removed some long binary information at the end of the file as
pastebin does not allow more than 500k pasting. The crash is
consistently happening and I am planning on for a debian deployment of
gitlab.

Please advice what could I do to solve this problem.


./Siva.
