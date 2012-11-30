From: Tomas Neme <lacrymology@gmail.com>
Subject: Bug report: probiem with across-branch git-diff
Date: Fri, 30 Nov 2012 18:13:12 -0300
Message-ID: <CA+8r0=ziTMRzBqE0EPTohL_7c0-Dv_ZahXS6xWiTmFEgW9J=KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 22:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeXu9-0002mO-IR
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 22:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031797Ab2K3VNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 16:13:33 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:65460 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031669Ab2K3VNc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 16:13:32 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so612199pad.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ooVXXjZdEKI/x2LMJYCZhM80dTMKZ90MRafXNW1NyU8=;
        b=ijpInZDS1jxwMgRzu+l+EZ4QLZU9YSlNvUObFWW93e7dk/6Xwj5O783PJJ4qysMP4s
         nVgcwuTobP6HB+O3w26Bs8V2b5U6zMw4PDuI43wfA63uNHqtb2OssJi2mtMXd+HRpa8P
         FCy1YCGV1T1H5HlX+Tw73NnKveQ3TiqnCXgExlrzEO2cCSnoS12vM1XjkQ2zY6mVWuO2
         i/a1pBWMXhGHykjlgoqnVwIPibsHsp+yigeyNF4gI/vjFEmT6XrHDOXNB6/zplk/KDio
         Evqk8uu6/mWr1rm/zV2TJPK+454DnuskdLmxjdwL7An5K3Engqw+v0EBmFxiuc1QInyO
         Ngrw==
Received: by 10.68.254.137 with SMTP id ai9mr8923145pbd.21.1354310012403; Fri,
 30 Nov 2012 13:13:32 -0800 (PST)
Received: by 10.68.5.164 with HTTP; Fri, 30 Nov 2012 13:13:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210945>

(env)lacrymology@Roller:boilerplate$ git rev-parse
test_project:boilerplate/apps/custom_zinnia/models/blog.py
9e93aa98ad2aeb8094dd3206b02e7bd835ce6899

lacrymology@Roller:boilerplate$ git diff
boilerplate/apps/custom_zinnia/abstract_models.py
test_project:boilerplate/apps/custom_zinnia/models/blog.py
fatal: Path 'boilerplate/apps/custom_zinnia/models/blog.py' exists,
but not 'boilerplate/apps/custom_zinnia/models/blog.py'.
Did you mean 'test_project:boilerplate/apps/custom_zinnia/models/blog.py'
aka 'test_project:./boilerplate/apps/custom_zinnia/models/blog.py'?

blog.py doesn't exist in the current branch. Current branch descends
from test_project, and abstract_models.py it's actually the same file
`git mv`'ed

--
"The whole of Japan is pure invention. There is no such country, there
are no such people" --Oscar Wilde

|_|0|_|
|_|_|0|
|0|0|0|

(\__/)
(='.'=)This is Bunny. Copy and paste bunny
(")_(") to help him gain world domination.
