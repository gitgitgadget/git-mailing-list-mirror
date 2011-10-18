From: Howard Miller <howardsmiller@gmail.com>
Subject: Repo seems broken after deleting submodule
Date: Tue, 18 Oct 2011 12:05:18 +0100
Message-ID: <CAHVO_90oR1xx625CTQ5s1BGrDAyvkeHciWBw7tr3-QfiP+Y+KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 13:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG7Us-0008HD-2b
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 13:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1JRLFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 07:05:20 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34220 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1JRLFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 07:05:19 -0400
Received: by qyk27 with SMTP id 27so348683qyk.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gHMnJ+fGO24Ei9yRuKQKKYqqPEcOIfrMKajfvaK0nQA=;
        b=ASrLrqa1PA+TYkWTmOPAlwQkrGMEk/tbjqoQ47u+gdrhddkn1rD50PBlH8DxTcSQsa
         KcJyWbxeGOCRe4oX5ULsXIkleWoS5H8mt+NTddoX8ZMxJL/8s59DU5jT/YEy4qw1J6ed
         tLtwEEmeBHtNmhD+WqrX/vhzKtBjgWQyC45pY=
Received: by 10.229.61.69 with SMTP id s5mr389921qch.232.1318935918524; Tue,
 18 Oct 2011 04:05:18 -0700 (PDT)
Received: by 10.229.211.73 with HTTP; Tue, 18 Oct 2011 04:05:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183879>

I included a submodule in my project then decided I didn't like
submodules and deleted it again. I followed the advice of delting
.gitmodules, the bit from .git/config and then git rm'ing the
submodule. Seemed to work. I then copied files with the same directory
name into where the submodule was. However, I can't add them.

Doing git add /path/to/old/submodule - does nothing, files are not
staged, no error messages no nothing.
If I try to git rm /path/to/old/submodule - it just says 'did not
match any files'.

I'm a bit stuck... any suggestions for things I can try much appreciated.
