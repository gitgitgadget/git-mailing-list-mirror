From: Gregory Petrosyan <gregory.petrosyan@gmail.com>
Subject: non-ascii filenames issue
Date: Sun, 5 Apr 2009 13:36:40 +0400
Message-ID: <20090405093640.GA9803@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 11:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOny-0005S9-Ay
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbZDEJgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbZDEJgq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:36:46 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:36231 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbZDEJgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:36:46 -0400
Received: by fxm2 with SMTP id 2so1490609fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=mAtrt/yGAPmJf6s3umz1TgKxVRzv9J0OZ2UFs8W0sjs=;
        b=Nzq0ZJqZ+XE6ysPGxUgpANKiQboZD6RWK6p8mV8N7o/h6wk2ZuCXlfnIb58LMQ6+kL
         S9t6QXgLsxvPEibjyEiScuJ8COGy/lTMLsxt0JWbMZZabYScXR5uV1jKAJhWEmRntlCB
         1dq4LFaNBFAUeZGJvZN6qFwVAVXyVfuIPesno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=nFSxs3T24e7ukZeB3JnlTURfHbMB/2yZRby/GEgPXPwuIgTS3sCZ+nx2eN8K/7saEu
         lIRGqJQHlhEwHcxHHZqqKic3O3ehpOu+wzcue/69ErUGIyeCgU9UFOOzZp2Q+UZ0aSFQ
         OYf0LSKSLSYvPQs7Pob+BFEPYQ86nmZhgTo04=
Received: by 10.103.228.7 with SMTP id f7mr1378790mur.130.1238924203173;
        Sun, 05 Apr 2009 02:36:43 -0700 (PDT)
Received: from home ([78.111.87.153])
        by mx.google.com with ESMTPS id y37sm5159648mug.23.2009.04.05.02.36.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 02:36:42 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115642>

gregory@home:~$ git --version
git version 1.6.2.2.404.ge96f3
gregory@home:~$ mkdir git-test
gregory@home:~$ cd git-test
gregory@home:~/git-test$ touch =D1=84=D0=B0=D0=B9=D0=BB
gregory@home:~/git-test$ ls -a
=2E  ..  =D1=84=D0=B0=D0=B9=D0=BB
gregory@home:~/git-test$ git init
Initialized empty Git repository in /home/gregory/git-test/.git/
gregory@home:~/git-test$ git add .
gregory@home:~/git-test$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#  new file:   "\321\204\320\260\320\271\320\273"
#
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 "=D1=84=D0=B0=D0=B9=D0=BB" should be here instead

This is on Ubuntu Jaunty beta, with latest git built from source.
Please CC me, I am not subscribed.

	Gregory
