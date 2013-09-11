From: Breck Yunits <breck7@gmail.com>
Subject: Specifying a private key when connecting to a remote SSH repo
Date: Wed, 11 Sep 2013 16:19:00 -0700
Message-ID: <CAOgHByvTtNDho50B+pECMeXkq=3FF8EheFbP4iQbKYTiAPTwYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 01:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJtgq-0003GM-6n
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 01:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474Ab3IKXTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 19:19:04 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49997 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466Ab3IKXTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 19:19:01 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so10614903ieb.9
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2QB8cqiLUubpgbswj62QywEzF2nfA2jxA1Rgp+j2aXc=;
        b=fsgG2GvfsFgUUPo+/0E+7BvYV914pxQav2tbgxEcEllSTlc80eFjtE+YDspJSi2/ey
         vrTlTAhRcKHXmUd2lUIqwDHWqO+LPjGfxAlzEStqCZAlOzCBc2EAqXxHD1Ll/K//M6t4
         FXNVJf1BZmPlvnTg1nzTnOW8/B+JUe+pby+8+MItx0b+KwyWTFpY1YhybIvMeud6N1vC
         0PxT5Jq0El7HRyaLDnp1hqi2SeAcx2s+bX3GSt5MqFlOwabpq2Ct89DxHuz9o4UZQ4OV
         PkQGnnfM1JMBYaSOjipJU4+BCqOAoiQ/1pol77IK5BxdMymP4RZXBpqcnowbqK2OXUC6
         8puA==
X-Received: by 10.50.138.165 with SMTP id qr5mr1052042igb.25.1378941540987;
 Wed, 11 Sep 2013 16:19:00 -0700 (PDT)
Received: by 10.50.57.229 with HTTP; Wed, 11 Sep 2013 16:19:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234612>

It would be very helpful if you could specify the path to the private
key to use for ssh remotes just like in ssh.

```
git push origin master -i 'path_to_key'
```

Althought there are workarounds involving ssh config, if you have a
server that has hundreds of git repos, each with the own private key,
those workarounds become unusable.

This is a very popular request with thousands of comments about it, for example:

http://superuser.com/questions/232373/tell-git-which-private-key-to-use

http://stackoverflow.com/questions/3496037/how-to-specify-which-ssh-key-to-use-within-git-for-git-push-in-order-to-have-git

Thoughts?

Thanks!

Breck Yunits
breck7@gmail.com
