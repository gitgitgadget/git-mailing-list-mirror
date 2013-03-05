From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: v3.4 released
Date: Tue, 5 Mar 2013 12:25:29 +0530
Message-ID: <CAMK1S_jBa4Z=Hb4ii-KQALQkycgwgsoCDbKZO=2w=FSZg8tggw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	gitolite-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Mar 05 07:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCln3-0002qT-Fv
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 07:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab3CEGzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 01:55:31 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:59042 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab3CEGza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 01:55:30 -0500
Received: by mail-we0-f176.google.com with SMTP id s43so5411217wey.7
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=zx466AY0nAMr+fK7t7TI0SaIL4xxLT5sioOMYT8noeU=;
        b=lCwvjB3xMm3fpWrRtATCJVhUAx5fhpCCyuI166hKgVRJ3bt9UiZS8MhilwZP2XbjqC
         hU+d6C9vkljk2eKqiszRTJp7lP1RCe17di6HjFIAMbrbQg5vJzm6EqIDFr9Mkhto0l/1
         S6qeprJRsfNMZaIsVb/CGh1dtxLyILjWsDcHbbAAdKxt2JlX66l94hd8QeXZ+yIIw6Hs
         3PQrTf4iwb5y/g+xLYpNCdI8i+wvnJHa5dPjABtF9ieSDsp3iT5/yKZuUpR14CvlpELk
         /2p5UMM6fRJP9a0kTkKIHEfE7WDl8dsWAGyJG8F+vUIMeH2bqeHXhdd2ad1RedJpW9Yf
         FZPw==
X-Received: by 10.180.94.135 with SMTP id dc7mr16318770wib.11.1362466529268;
 Mon, 04 Mar 2013 22:55:29 -0800 (PST)
Received: by 10.194.153.161 with HTTP; Mon, 4 Mar 2013 22:55:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217432>

mostly minor fixes but the rc file format change is in now.

Also, I souped up the refex-expr a bit; here's a teaser:

  * user u2 is allowed to push either 'doc/' or 'src/' but not both

        repo    foo
            RW+                         =   u1 u2 u3

            RW+ VREF/NAME/doc/                      =   u2
            RW+ VREF/NAME/src/                      =   u2
            -   VREF/NAME/doc/ and VREF/NAME/src/   =   u2

Interested people can take a look at src/VREF/refex-expr for details
https://github.com/sitaramc/gitolite/blob/master/src/VREF/refex-expr

-- 
Sitaram
