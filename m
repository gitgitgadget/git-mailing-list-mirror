From: Peng Yu <pengyu.ut@gmail.com>
Subject: How to unignore files in certain directories?
Date: Wed, 25 Jul 2012 10:48:52 -0500
Message-ID: <CABrM6wk+acut6EaoK=_GuQw3w9vhn_4ONoF21cj1GtEtHFWBKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 17:49:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su3pg-0001i8-1l
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2GYPsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 11:48:54 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42351 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968Ab2GYPsx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2012 11:48:53 -0400
Received: by lahd3 with SMTP id d3so662238lah.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3t3h4VK61JxXWysCxryo7K8BfhbjD36Nkg6OOnhIAWQ=;
        b=JQGqY0V2JNBX7vKbcZyYKYw0V2pwD6qNgxtxPA+R/CXUzCHdBhqLPMKOucQLx4DTfl
         BA7lbucGLbAKKTKWpVMhaJs8Pzub7NlMOXR0J+oI8I5R92B7u71leg0G5FV5nm6FOK+w
         ukn0/KJUe/QMy/9xl1X1DfPNQqm9dISmslERmATCYsaaM4s0mpgVhA9ZgpDR56dh5RKr
         SMeSJVOGrUyz+QR+Na+R2Jsjbkk7GG8s2+EgrMgDp7eO0nMT8YCk6oQXfsthFs2whYFU
         dvJUO5ZW04mWw3D3BSnB+boX286di71NRHViY6MsjjAEWI13gRgDvaZ5ILd6qHROVoAO
         zgxg==
Received: by 10.152.112.138 with SMTP id iq10mr3034623lab.13.1343231332452;
 Wed, 25 Jul 2012 08:48:52 -0700 (PDT)
Received: by 10.112.49.228 with HTTP; Wed, 25 Jul 2012 08:48:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202167>

Hi,

I have the following in .gitignore to ignore *.txt files.

*.txt

But I want to keep the *.txt files in, for example, data/ and all its
subdirectories. I don't know should the the correct way to unignore
these *.txt files. Could anybody show me the command that I should add
to .gitignore? Thanks!

-- 
Regards,
Peng
