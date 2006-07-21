From: "Robin Luckey" <robinluckey@gmail.com>
Subject: Easy way to empty working tree?
Date: Thu, 20 Jul 2006 18:28:46 -0700
Message-ID: <761519800607201828m19684b2jc267411ef3b8b9e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 21 03:29:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3jp2-0007Sk-Qe
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 03:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWGUB2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 21:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWGUB2s
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 21:28:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:20463 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030421AbWGUB2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 21:28:47 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1074841ugc
        for <git@vger.kernel.org>; Thu, 20 Jul 2006 18:28:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nM+BZYOCLS3h7NVojy0kc+HbVShYOKGLqDPoBgB1c7ccj1Y6gMImhQ8AeJN2ED8qCzQJWw8PzQXkHIpE5Vajprj626KqBt9pQu1cYWLIhxJH3P8j/Pn1VHxssXgMOeNw9UVoAP0cGFpxBTP6zFwk7ZVsPsQ8cUjHTrJhK/YOE1Y=
Received: by 10.67.93.6 with SMTP id v6mr106993ugl;
        Thu, 20 Jul 2006 18:28:46 -0700 (PDT)
Received: by 10.66.220.13 with HTTP; Thu, 20 Jul 2006 18:28:46 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24040>

I have some very large git repositories that serve mainly as archives,
and it would be nice to clear out the working directories for the
repositories I am not currently working with. I'm not trying to delete
the files from the repository, I just want free up space in idle
repositories.

After mothballing the repository with git-repack -a -d and git clean
-d -x, is there a convenient one-liner to empty the files out the
working directory?

Thanks,
Robin
