From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: git submodule init --recursive?
Date: Thu, 25 Jun 2015 20:04:35 -0500
Message-ID: <CAHd499BbW=yAR_4WFiuq7TvFvYKN84FkQSjGL6AqCoYffOg2LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 03:04:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8I4P-0001xB-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 03:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbbFZBEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 21:04:36 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37109 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbFZBEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 21:04:35 -0400
Received: by igblr2 with SMTP id lr2so3907156igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=hCzjDjY9kQ3a65FQU7ykMUEWrlEucbNkYbjbedCEdJk=;
        b=ZdAj5ky3Zom81RFuJhtDR5SnZpSM59YjiH9vTXt8wDTUvmoP4vNFNmZ2W+X7bGY0fi
         cgF8RyxX9+paKGp3Y1JbxmmtswzXjsSd/qS1Gx6HPuvMBkawbAKXJYmqCxOa145k3CJu
         8apEqoG86HyI5VjwKDYC0scB73ePOAiOGhyFq8dwHACP2lqfKf8+209NtENKllKewJRr
         36KGxUhQkmxcRm/I83orTJq5I05pIJoOQJcpKzRssQO+//m2O1UN5ag7vwbJr3fr/jtX
         1DngJw8UDDNyNi76DdE/Y5SYxEIG/pRy1xMMpFrL+FKrr9PPg9iI5gGvMd8SESk77Hgt
         I81Q==
X-Received: by 10.107.38.139 with SMTP id m133mr50988095iom.51.1435280675221;
 Thu, 25 Jun 2015 18:04:35 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 25 Jun 2015 18:04:35 -0700 (PDT)
X-Google-Sender-Auth: TM0CzseHEvmw_TGRoWb3jmTz4dU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272755>

I have a few nested submodules, all use relative URLs such as:

../mysubmodule.git
../../tools/tool1.git

If I change my parent repo URL, I need to recursively update all
remotes in each submodule. There is no `--recursive` option for `git
submodule init`. What is the recommend method for accomplishing this?

Thanks in advance.
