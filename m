From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: 1.6.0.rc2: Duplicated refs when using git clone --mirror
Date: Thu, 07 Aug 2008 21:59:55 -0300
Message-ID: <489B9A8B.9050807@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 03:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRGLt-0002AK-5W
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 03:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYHHBAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 21:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYHHBAE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 21:00:04 -0400
Received: from smtp-04.mandic.com.br ([200.225.81.151]:41265 "EHLO
	smtp-04.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbYHHBAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 21:00:00 -0400
Received: (qmail 31337 invoked from network); 8 Aug 2008 00:59:57 -0000
Received: from grumari.nitnet.com.br (HELO [192.168.96.4]) (zcncxNmDysja2tXBpdiToZWJlF6Wp6IuYnI=@[200.157.204.13])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-04.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 8 Aug 2008 00:59:56 -0000
User-Agent: Thunderbird 1.5.0.14ubu (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91615>

cesarb@delta:/tmp$ PATH=~/opt/git/bin:$PATH git --version
git version 1.6.0.rc2
cesarb@delta:/tmp$ PATH=~/opt/git/bin:$PATH git clone --mirror 
git://git.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /tmp/git.git/
remote: Counting objects: 80828, done.
remote: Compressing objects: 100% (21488/21488), done.
remote: Total 80828 (delta 58880), reused 79522 (delta 57902)
Receiving objects: 100% (80828/80828), 16.84 MiB | 97 KiB/s, done.
Resolving deltas: 100% (58880/58880), done.
cesarb@delta:/tmp$ cd git.git/
cesarb@delta:/tmp/git.git$ PATH=~/opt/git/bin:$PATH git fetch
warning: Duplicated ref: refs/tags/gitgui-0.10.0
warning: Duplicated ref: refs/tags/gitgui-0.10.1
warning: Duplicated ref: refs/tags/gitgui-0.10.2
warning: Duplicated ref: refs/tags/gitgui-0.6.0
warning: Duplicated ref: refs/tags/gitgui-0.6.1
warning: Duplicated ref: refs/tags/gitgui-0.6.2
warning: Duplicated ref: refs/tags/gitgui-0.6.3
warning: Duplicated ref: refs/tags/gitgui-0.6.4
warning: Duplicated ref: refs/tags/gitgui-0.6.5
warning: Duplicated ref: refs/tags/gitgui-0.7.0
warning: Duplicated ref: refs/tags/gitgui-0.7.0-rc1
warning: Duplicated ref: refs/tags/gitgui-0.7.1
warning: Duplicated ref: refs/tags/gitgui-0.7.2
warning: Duplicated ref: refs/tags/gitgui-0.7.3
warning: Duplicated ref: refs/tags/gitgui-0.7.4
warning: Duplicated ref: refs/tags/gitgui-0.7.5
warning: Duplicated ref: refs/tags/gitgui-0.8.0
warning: Duplicated ref: refs/tags/gitgui-0.8.1
warning: Duplicated ref: refs/tags/gitgui-0.8.2
warning: Duplicated ref: refs/tags/gitgui-0.8.3
warning: Duplicated ref: refs/tags/gitgui-0.8.4
warning: Duplicated ref: refs/tags/gitgui-0.9.0
warning: Duplicated ref: refs/tags/gitgui-0.9.1
warning: Duplicated ref: refs/tags/gitgui-0.9.2
warning: Duplicated ref: refs/tags/gitgui-0.9.3
warning: Duplicated ref: refs/tags/junio-gpg-pub
warning: Duplicated ref: refs/tags/v0.99
warning: Duplicated ref: refs/tags/v0.99.9h
warning: Duplicated ref: refs/tags/v0.99.9i
warning: Duplicated ref: refs/tags/v0.99.9j
warning: Duplicated ref: refs/tags/v0.99.9k
warning: Duplicated ref: refs/tags/v0.99.9l
warning: Duplicated ref: refs/tags/v0.99.9m
warning: Duplicated ref: refs/tags/v0.99.9n
warning: Duplicated ref: refs/tags/v1.0.0
warning: Duplicated ref: refs/tags/v1.0.0a
warning: Duplicated ref: refs/tags/v1.0.0b
warning: Duplicated ref: refs/tags/v1.0.10
warning: Duplicated ref: refs/tags/v1.0.11
warning: Duplicated ref: refs/tags/v1.0.12
warning: Duplicated ref: refs/tags/v1.0.13
warning: Duplicated ref: refs/tags/v1.0.3
warning: Duplicated ref: refs/tags/v1.0.4
warning: Duplicated ref: refs/tags/v1.0.5
warning: Duplicated ref: refs/tags/v1.0.6
warning: Duplicated ref: refs/tags/v1.0.7
warning: Duplicated ref: refs/tags/v1.0.8
warning: Duplicated ref: refs/tags/v1.0.9
warning: Duplicated ref: refs/tags/v1.0rc1
warning: Duplicated ref: refs/tags/v1.0rc2
warning: Duplicated ref: refs/tags/v1.0rc3
warning: Duplicated ref: refs/tags/v1.0rc4
warning: Duplicated ref: refs/tags/v1.0rc5
warning: Duplicated ref: refs/tags/v1.0rc6
warning: Duplicated ref: refs/tags/v1.1.0
warning: Duplicated ref: refs/tags/v1.1.1
warning: Duplicated ref: refs/tags/v1.1.2
warning: Duplicated ref: refs/tags/v1.1.3
warning: Duplicated ref: refs/tags/v1.1.4
warning: Duplicated ref: refs/tags/v1.1.5
warning: Duplicated ref: refs/tags/v1.1.6
warning: Duplicated ref: refs/tags/v1.2.0
warning: Duplicated ref: refs/tags/v1.2.1
warning: Duplicated ref: refs/tags/v1.2.2
warning: Duplicated ref: refs/tags/v1.2.3
warning: Duplicated ref: refs/tags/v1.2.4
warning: Duplicated ref: refs/tags/v1.2.5
warning: Duplicated ref: refs/tags/v1.2.6
warning: Duplicated ref: refs/tags/v1.3.0
warning: Duplicated ref: refs/tags/v1.3.0-rc1
warning: Duplicated ref: refs/tags/v1.3.0-rc2
warning: Duplicated ref: refs/tags/v1.3.0-rc3
warning: Duplicated ref: refs/tags/v1.3.0-rc4
warning: Duplicated ref: refs/tags/v1.3.1
warning: Duplicated ref: refs/tags/v1.3.2
warning: Duplicated ref: refs/tags/v1.3.3
warning: Duplicated ref: refs/tags/v1.4.0
warning: Duplicated ref: refs/tags/v1.4.0-rc1
warning: Duplicated ref: refs/tags/v1.4.0-rc2
warning: Duplicated ref: refs/tags/v1.4.1
warning: Duplicated ref: refs/tags/v1.4.1-rc1
warning: Duplicated ref: refs/tags/v1.4.1-rc2
warning: Duplicated ref: refs/tags/v1.4.1.1
warning: Duplicated ref: refs/tags/v1.4.2
warning: Duplicated ref: refs/tags/v1.4.2-rc1
warning: Duplicated ref: refs/tags/v1.4.2-rc2
warning: Duplicated ref: refs/tags/v1.4.2-rc3
warning: Duplicated ref: refs/tags/v1.4.2-rc4
warning: Duplicated ref: refs/tags/v1.4.2.1
warning: Duplicated ref: refs/tags/v1.4.2.2
warning: Duplicated ref: refs/tags/v1.4.2.3
warning: Duplicated ref: refs/tags/v1.4.2.4
warning: Duplicated ref: refs/tags/v1.4.3
warning: Duplicated ref: refs/tags/v1.4.3-rc1
warning: Duplicated ref: refs/tags/v1.4.3-rc2
warning: Duplicated ref: refs/tags/v1.4.3-rc3
warning: Duplicated ref: refs/tags/v1.4.3.1
warning: Duplicated ref: refs/tags/v1.4.3.2
warning: Duplicated ref: refs/tags/v1.4.3.3
warning: Duplicated ref: refs/tags/v1.4.3.4
warning: Duplicated ref: refs/tags/v1.4.3.5
warning: Duplicated ref: refs/tags/v1.4.4
warning: Duplicated ref: refs/tags/v1.4.4-rc1
warning: Duplicated ref: refs/tags/v1.4.4-rc2
warning: Duplicated ref: refs/tags/v1.4.4.1
warning: Duplicated ref: refs/tags/v1.4.4.2
warning: Duplicated ref: refs/tags/v1.4.4.3
warning: Duplicated ref: refs/tags/v1.4.4.4
warning: Duplicated ref: refs/tags/v1.4.4.5
warning: Duplicated ref: refs/tags/v1.5.0
warning: Duplicated ref: refs/tags/v1.5.0-rc0
warning: Duplicated ref: refs/tags/v1.5.0-rc1
warning: Duplicated ref: refs/tags/v1.5.0-rc2
warning: Duplicated ref: refs/tags/v1.5.0-rc3
warning: Duplicated ref: refs/tags/v1.5.0-rc4
warning: Duplicated ref: refs/tags/v1.5.0.1
warning: Duplicated ref: refs/tags/v1.5.0.2
warning: Duplicated ref: refs/tags/v1.5.0.3
warning: Duplicated ref: refs/tags/v1.5.0.4
warning: Duplicated ref: refs/tags/v1.5.0.5
warning: Duplicated ref: refs/tags/v1.5.0.6
warning: Duplicated ref: refs/tags/v1.5.0.7
warning: Duplicated ref: refs/tags/v1.5.1
warning: Duplicated ref: refs/tags/v1.5.1-rc1
warning: Duplicated ref: refs/tags/v1.5.1-rc2
warning: Duplicated ref: refs/tags/v1.5.1-rc3
warning: Duplicated ref: refs/tags/v1.5.1.1
warning: Duplicated ref: refs/tags/v1.5.1.2
warning: Duplicated ref: refs/tags/v1.5.1.3
warning: Duplicated ref: refs/tags/v1.5.1.4
warning: Duplicated ref: refs/tags/v1.5.1.5
warning: Duplicated ref: refs/tags/v1.5.1.6
warning: Duplicated ref: refs/tags/v1.5.2
warning: Duplicated ref: refs/tags/v1.5.2-rc0
warning: Duplicated ref: refs/tags/v1.5.2-rc1
warning: Duplicated ref: refs/tags/v1.5.2-rc2
warning: Duplicated ref: refs/tags/v1.5.2-rc3
warning: Duplicated ref: refs/tags/v1.5.2.1
warning: Duplicated ref: refs/tags/v1.5.2.2
warning: Duplicated ref: refs/tags/v1.5.2.3
warning: Duplicated ref: refs/tags/v1.5.2.4
warning: Duplicated ref: refs/tags/v1.5.2.5
warning: Duplicated ref: refs/tags/v1.5.3
warning: Duplicated ref: refs/tags/v1.5.3-rc0
warning: Duplicated ref: refs/tags/v1.5.3-rc1
warning: Duplicated ref: refs/tags/v1.5.3-rc2
warning: Duplicated ref: refs/tags/v1.5.3-rc3
warning: Duplicated ref: refs/tags/v1.5.3-rc4
warning: Duplicated ref: refs/tags/v1.5.3-rc5
warning: Duplicated ref: refs/tags/v1.5.3-rc6
warning: Duplicated ref: refs/tags/v1.5.3-rc7
warning: Duplicated ref: refs/tags/v1.5.3.1
warning: Duplicated ref: refs/tags/v1.5.3.2
warning: Duplicated ref: refs/tags/v1.5.3.3
warning: Duplicated ref: refs/tags/v1.5.3.4
warning: Duplicated ref: refs/tags/v1.5.3.5
warning: Duplicated ref: refs/tags/v1.5.3.6
warning: Duplicated ref: refs/tags/v1.5.3.7
warning: Duplicated ref: refs/tags/v1.5.3.8
warning: Duplicated ref: refs/tags/v1.5.4
warning: Duplicated ref: refs/tags/v1.5.4-rc0
warning: Duplicated ref: refs/tags/v1.5.4-rc1
warning: Duplicated ref: refs/tags/v1.5.4-rc2
warning: Duplicated ref: refs/tags/v1.5.4-rc3
warning: Duplicated ref: refs/tags/v1.5.4-rc4
warning: Duplicated ref: refs/tags/v1.5.4-rc5
warning: Duplicated ref: refs/tags/v1.5.4.1
warning: Duplicated ref: refs/tags/v1.5.4.2
warning: Duplicated ref: refs/tags/v1.5.4.3
warning: Duplicated ref: refs/tags/v1.5.4.4
warning: Duplicated ref: refs/tags/v1.5.4.5
warning: Duplicated ref: refs/tags/v1.5.4.6
warning: Duplicated ref: refs/tags/v1.5.5
warning: Duplicated ref: refs/tags/v1.5.5-rc0
warning: Duplicated ref: refs/tags/v1.5.5-rc1
warning: Duplicated ref: refs/tags/v1.5.5-rc2
warning: Duplicated ref: refs/tags/v1.5.5-rc3
warning: Duplicated ref: refs/tags/v1.5.5.1
warning: Duplicated ref: refs/tags/v1.5.5.2
warning: Duplicated ref: refs/tags/v1.5.5.3
warning: Duplicated ref: refs/tags/v1.5.5.4
warning: Duplicated ref: refs/tags/v1.5.5.5
warning: Duplicated ref: refs/tags/v1.5.6
warning: Duplicated ref: refs/tags/v1.5.6-rc0
warning: Duplicated ref: refs/tags/v1.5.6-rc1
warning: Duplicated ref: refs/tags/v1.5.6-rc2
warning: Duplicated ref: refs/tags/v1.5.6-rc3
warning: Duplicated ref: refs/tags/v1.5.6.1
warning: Duplicated ref: refs/tags/v1.5.6.2
warning: Duplicated ref: refs/tags/v1.5.6.3
warning: Duplicated ref: refs/tags/v1.5.6.4
warning: Duplicated ref: refs/tags/v1.5.6.5
warning: Duplicated ref: refs/tags/v1.6.0-rc0
warning: Duplicated ref: refs/tags/v1.6.0-rc1
warning: Duplicated ref: refs/tags/v1.6.0-rc2
warning: Duplicated ref: refs/tags/v0.99.9g
cesarb@delta:/tmp/git.git$

There is no file in refs/; the contents of packed-refs are like:

# pack-refs with: peeled
b7d75e49508ac928677f5cb83f490cf40a7c83d3 refs/tags/v1.6.0-rc2
^1fdf6ee6f81b31b299a8039832f45290faa4583a
ad6137f51f5f67e2558849629332c7443ed01108 refs/tags/v1.6.0-rc1
^8e1db3871c767cb17b5e0eeb7bea8d967821a055
4be80e6b423b9ceffab50e120855806712ab3255 refs/tags/v1.6.0-rc0
^93310a40eb022a0e36e7c618921931d8ffc31fd1
07cca3b30ee2b5d060e44e5b18d7c22929c63d1a refs/tags/v1.5.6.5
^781c1834f5419bdf81bb7f3750170ccd6b809174
[...]
33682a5e98adfd8ba4ce0e21363c443bd273eb77 refs/tags/gitgui-0.10.1
^729ffa50f75a025935623bfc58d0932c65f7de2f
d5aef6e4d58cfe1549adef5b436f3ace984e8c86 refs/tags/gitgui-0.10.0
^3d654be48f65545c4d3e35f5d3bbed5489820930
b7d75e49508ac928677f5cb83f490cf40a7c83d3 refs/tags/v1.6.0-rc2
^1fdf6ee6f81b31b299a8039832f45290faa4583a
ad6137f51f5f67e2558849629332c7443ed01108 refs/tags/v1.6.0-rc1
^8e1db3871c767cb17b5e0eeb7bea8d967821a055
4be80e6b423b9ceffab50e120855806712ab3255 refs/tags/v1.6.0-rc0
^93310a40eb022a0e36e7c618921931d8ffc31fd1
07cca3b30ee2b5d060e44e5b18d7c22929c63d1a refs/tags/v1.5.6.5
^781c1834f5419bdf81bb7f3750170ccd6b809174
[...]
33682a5e98adfd8ba4ce0e21363c443bd273eb77 refs/tags/gitgui-0.10.1
^729ffa50f75a025935623bfc58d0932c65f7de2f
d5aef6e4d58cfe1549adef5b436f3ace984e8c86 refs/tags/gitgui-0.10.0
^3d654be48f65545c4d3e35f5d3bbed5489820930
19a1e065c865db403a41af97b2e9e81f1d01dd9e refs/heads/todo
0e60d74cc02f6a0af58a1f99e54509dafc7c8f6a refs/heads/pu
9c632062aee88de890e8b30d8763f83abe1da113 refs/heads/next
1fdf6ee6f81b31b299a8039832f45290faa4583a refs/heads/master
99ad2efc3f7764a1c21e464412af95a8ffe3b5d6 refs/heads/man
781c1834f5419bdf81bb7f3750170ccd6b809174 refs/heads/maint
b53db3ca58a8a65d8de3b9fa048d410757edc38f refs/heads/html

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
