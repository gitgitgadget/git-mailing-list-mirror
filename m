From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Rework a patch serie
Date: Tue, 27 Jun 2006 08:41:30 +0000 (GMT)
Message-ID: <20060627084130.28886.qmail@web25814.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 27 10:42:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv98u-0004DI-8t
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWF0Ilf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWF0Ile
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:41:34 -0400
Received: from web25814.mail.ukl.yahoo.com ([217.146.176.247]:55415 "HELO
	web25814.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932621AbWF0Ilc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 04:41:32 -0400
Received: (qmail 28888 invoked by uid 60001); 27 Jun 2006 08:41:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=hYXKh0AcAB12qRVlzUk6l7MDZG5ruaiJWFvTP83wUZdGiYjk9EXuJETZR7fGKfmU843WMyIvZbO/0KVwpxWBo5i0hKxg8i8RjYZPWjEq0U7RoEneZ4OWNA0+2skVYly9xYp4dMCsIPym0RCp/4uR59mLIWDl+FkLKMGrzK9EAJU=  ;
Received: from [194.3.162.233] by web25814.mail.ukl.yahoo.com via HTTP; Tue, 27 Jun 2006 08:41:30 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22715>

Hello

Several times I have a topic branch that contains several commits like
this:

            "master"
        o---o
             \                    "topic"
              o---o---o---o---o---o


When I think everything is in a good shape I generate several patches to
submit them. For that, I do:

        $ git checkout topic
        $ git-format-patch -s -k -n master
        001-aaa.patch
        002-bbb.patch
        [...]
        006-fff.patch

Then I submit these patches for reviewing. Unfortunately, they're not perfect,
so after some feedbacks from the communauty it appears that I need to make
small modifications in the second commit in the topic branch for example...

What is the best and fastest way to do that ? Should I create a new topic branch
and cherry pick from the old one ?

Thanks for your advices

Francis
