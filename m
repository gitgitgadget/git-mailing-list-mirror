From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Command specific pager settings
Date: Mon, 4 Oct 2010 00:37:29 -0700
Message-ID: <AANLkTimLt0ERrB5b9p+_7fZBWfK3PHJkydmouiGfnurz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 09:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fcS-0006OX-L9
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab0JDHhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:37:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39708 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0JDHhv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:37:51 -0400
Received: by wyb28 with SMTP id 28so4635893wyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=Aev8dk3mCTZKYC0b84Wktod50JAps6xginmITmltDLw=;
        b=m8q9irUrsk1LpWrKLnBS7xuiplrrNI7g9y6IZxMMK6i3SJFIf1dqcuR6c2FWPVojqE
         NMu4mEnqUJwx2UbztjrZBeD9IzF3heaJoi8xhRK2OKrU69GQ/KgW4D7oZAS3wnjV7DVM
         0x+AtgMGj3hy8jonMjUkqTzV3xI2YIGeITV70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=sz1m1CH8U0n5W3XFctZssNv/OAfMwjrbLFpsx1qZ8KBIRn85Rb4Wj3T5t5MNBiAfxY
         3O5e/wFiKh90YAf+ydjocjV9V8C+SxlSrBAHKcT7PUadiIflMoMTg53VaGsMZNAQzW1w
         HOd7tKCPutRi/dRJuLfkTg8sRa+SYpHXa9AkU=
Received: by 10.227.99.79 with SMTP id t15mr6702565wbn.209.1286177870103; Mon,
 04 Oct 2010 00:37:50 -0700 (PDT)
Received: by 10.216.79.66 with HTTP; Mon, 4 Oct 2010 00:37:29 -0700 (PDT)
X-Google-Sender-Auth: AZfE7l0KG62SnHWJsxLyd4LMGvE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158000>

Hi everyone,

I am a new user of git and I was trying to configure the pager for git
and ran across something. Is it possible to have different command
options to less for different git commands?

I wanted to set my pager to `less -iRS' when looking at patches (so
that would mean commands like `git diff'), but would prefer `less
-iFRS' or even the git default `less -FRSX' for all other things e.g
`git log'.

I looked at core.pager and pager.<cmd> but I couldn't understand how I
could set different pagers for say just one/ a subset of commands (git
diff in my case).

Is this possible? If not, would it be a worthwhile feature request?
Thanks a lot for any pointers.

-- 
Suvayu

Open source is the future. It sets us free.
