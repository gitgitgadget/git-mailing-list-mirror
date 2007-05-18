From: "Christian MICHON" <christian.michon@gmail.com>
Subject: GIT_DIR used to work with git-1.4.4.4
Date: Fri, 18 May 2007 16:24:44 +0200
Message-ID: <46d6db660705180724n43dfeebakf5725a04e5b10673@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 18 16:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp3O0-0001ss-GM
	for gcvg-git@gmane.org; Fri, 18 May 2007 16:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbXEROYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbXEROYq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 10:24:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:48967 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbXEROYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 10:24:45 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1350769nza
        for <git@vger.kernel.org>; Fri, 18 May 2007 07:24:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EHlRD4j1urLXFL15j3vq3okiURHpkE74tvXDN2trACqvgaQFTPD1NKAE8i5Jc0/YJpJxfIXKCwjyeDEZarcCedfzVF2cVJRw9DgE2GE+8BnPIl1JNnz387/lcX7251cc3bDmCQyCS0ByYkfBB662wH6DCADgXZdpFNPxJ6xbEPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tYVUzPwUxPbWdV5unIPQ81NChXaS7Corg9irUAqpGtap31ZyOYIahHfMeskKEqlMFOcAgQmokeoif5ozxYEHaZNZiHgcTfsccOyF1HIHSNBKmeGGRUPHP5TqNa+T/NFPZcQliOqdAS4U5BLEyrm/lwxoMBwcN4P/CU128d/tlg0=
Received: by 10.114.58.1 with SMTP id g1mr863503waa.1179498284219;
        Fri, 18 May 2007 07:24:44 -0700 (PDT)
Received: by 10.115.16.20 with HTTP; Fri, 18 May 2007 07:24:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47611>

sorry if I created too much (user) noise around this issue, but
this is mostly why as a user I refrained using git-1.5.x

I sometimes have a scm work flow where I'd like to have my
GIT_DIR sitting on another file system, so therefore not in
the current working directory.

I used to be able to do this in git-1.4.4.4:
(it's a rather useless example, I know)

mkdir /home/xian/vault
export GIT_DIR=/home/xian/vault
mkdir /tmp/xianwork
cd /tmp/xianwork
touch a b
git init-db
git add .

This was truly working, and now using git-1.5.1.4, it's not.

Instead I get: "fatal: add must be run in a work tree"

from the source code, I understand what to change if I
want to get the old behavior.

My questions are:
- is this new behavior truly needed ?
- is there another way to do this using newer work flow ?
( I know already about the symbolic .git link trick )

Thanks in advance for any useful tips.

-- 
Christian
