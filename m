From: John Tapsell <johnflux@gmail.com>
Subject: git reflog --date
Date: Tue, 21 Oct 2014 09:11:50 +0100
Message-ID: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 10:12:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgUYY-0000GU-GP
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 10:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbaJUIMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 04:12:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33707 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbaJUIMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 04:12:12 -0400
Received: by mail-wi0-f172.google.com with SMTP id bs8so257759wib.11
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WryEmnxn8kfWOXj1DH6LpH9fmIBOjluGyDf8l4vUYDg=;
        b=I2JP0gA2TKO6f/1PZwdQKYkR63XYSlOZFzgbTmwJWa/1FDVbw5t4Dj+rjSKr7RcHAA
         KRWhIr2IElF6WnhDFBiHBvyyd/WcYQ0f4PP+WnJAo2H8uPXVoRCsZeo/sENtUWRaTMQL
         b9UypEhLyAN5tML5ITk+YSwG7IHTNzptwOTxrqXoOPDF/yevdZqWRzZjBrde8+3HP807
         Tr6owoMEN38OXRTA3izZDvdrI/Fr0YLIISgpNg+eziq8Mdy/t8Pb3cnzfD5HSR5629o2
         IbGpa4QjnSb4j+/EmhSORbQoNLP6eqBlTNLP2Bg4P7OQXmZtKjoVD3vlUL4azfA8QG1C
         qYLA==
X-Received: by 10.194.8.73 with SMTP id p9mr40015392wja.87.1413879130482; Tue,
 21 Oct 2014 01:12:10 -0700 (PDT)
Received: by 10.194.103.166 with HTTP; Tue, 21 Oct 2014 01:11:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

  Could we add a default to "--date" so that:

git reflog --date

just works?  (Currently you need to do:   git reflog --date=iso)  It
should probably obey the default in log.date?

Also, could we add this "--date" option to the man page please?  It's
an extremely useful option to know.  At the moment you have to notice
the comment that "all normal log options" are there, and then try to
work it out from there etc.

Thank you,

John

John
