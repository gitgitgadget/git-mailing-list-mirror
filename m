From: Ville Walveranta <walveranta@gmail.com>
Subject: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Fri, 1 Nov 2013 18:19:51 -0500
Message-ID: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 02 00:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcO0R-0006or-KY
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 00:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab3KAXTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 19:19:52 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:34751 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab3KAXTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 19:19:51 -0400
Received: by mail-vb0-f47.google.com with SMTP id m10so104743vbh.20
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MUqeRBNLry3ijvIF/giZ862YUzKzCIREmXwBpcl0tu0=;
        b=hZpOTEGHB8Dv94ta9rpb/iw+xuzUEZGkoQ3AiaaFYcFR1sJZT343BcQVq3JiO7vbty
         o0tbcrDF6+0O4JzL44mmM5G/7yw5ZAxlGrP8VeobnzjJcqQYQSmKyLcF7VrFomriBPGG
         P6yLlHnhBMXugubw3qjwQnEr/I5xnBYv8cvPEW4ftSTExjb+E1YkTllhx3bPzeRO69Y/
         3LGKfxxYRjTT8VJOAYPSNJWucIywuajbZAm+sAIIAhEsiCZHwvYmV2Bm2flcTVzVDJCb
         2jgBLDbTPhkPGkPXzkDugT3ISwWvzVMqRSqg5RUccJgQRkwuHo2nnBkLctqDwFVG9JxL
         Mmjw==
X-Received: by 10.220.174.200 with SMTP id u8mr3487423vcz.6.1383347991094;
 Fri, 01 Nov 2013 16:19:51 -0700 (PDT)
Received: by 10.58.2.133 with HTTP; Fri, 1 Nov 2013 16:19:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237232>

"git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
repository (or any of the parent directories): .git", instead of
"false" when outside of a git directory.  "--is-inside-work-tree"
behaves the same way. Both commands work correctly (i.e. output
"true") when inside a git directory, or inside a work tree,
respectively.

To test, I installed git 1.8.4.2 initially from
https://launchpad.net/~git-core/+archive/ppa for Ubuntu 12.04.3, and
then also compiled it from source, but both seem to behave the same
way. The problem is not yet present in version 1.7.9.5.

Thanks,

Ville Walveranta
