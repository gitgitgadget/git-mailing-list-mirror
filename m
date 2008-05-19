From: "Lionel [Over-Blog]" <lionel@over-blog.com>
Subject: Misspelled config directive in manual
Date: Mon, 19 May 2008 19:15:18 +0200
Message-ID: <b4c5a4f30805191015j6405cf07ib439d5e05b7e2e60@mail.gmail.com>
References: <b4c5a4f30805191012v3601eb0ao710e190d133d276d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 19:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy8y3-0008Fl-O9
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 19:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYESRPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 13:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbYESRPU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 13:15:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:23656 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbYESRPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 13:15:19 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1644699wxd.4
        for <git@vger.kernel.org>; Mon, 19 May 2008 10:15:19 -0700 (PDT)
Received: by 10.90.91.9 with SMTP id o9mr10139403agb.35.1211217318793;
        Mon, 19 May 2008 10:15:18 -0700 (PDT)
Received: by 10.90.102.18 with HTTP; Mon, 19 May 2008 10:15:18 -0700 (PDT)
In-Reply-To: <b4c5a4f30805191012v3601eb0ao710e190d133d276d@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: aad116e8afffffc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82435>

Hi all,

This is my first message to this list, well not only to say that I
love this tool, but mainly report a misspelled config directive in the
git-daemon manual (1.5.4.2).

It is said there to set the "uploadarchive" directive in the daemon
section to true. e.g :
[daemon]
        uploadpack = true
        uploadarchive = true
        receivepack = true

But in fact, the program expects "uploadarch" directive as below :

[daemon]
        uploadpack = true
        uploadarch = true
        receivepack = true

I spent some long minutes to figure this out, so it may help a lot if
this is corrected in the next version of the manual.

Regards,

--
Lionel TRESSENS
JFG Networks / over-blog.com
