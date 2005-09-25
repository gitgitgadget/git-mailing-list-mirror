From: Marco Costalba <mcostalba@yahoo.it>
Subject: scons and $HOME was Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 13:03:36 -0700 (PDT)
Message-ID: <20050925200337.33820.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 22:05:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJcjB-0002dT-8M
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 22:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVIYUDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVIYUDj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 16:03:39 -0400
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:37455 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932283AbVIYUDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 16:03:38 -0400
Received: (qmail 33822 invoked by uid 60001); 25 Sep 2005 20:03:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OM+GX04k1b7eB+r0v9TuBpjVcZfzdjGEjiYbfn4SnfObDvCfIsr1JC8q1ggEFp6MZ6QH1JlpkgIb9D1JRGdCkKbCbH+0lQxfMVewAIir9FnPMoADIAThu9LH8nuhsD+w+jXuvvYbCMAeAYoXWNfY5eh7KMJPVuvxcaa/LpF1nS0=  ;
Received: from [151.42.224.4] by web26301.mail.ukl.yahoo.com via HTTP; Sun, 25 Sep 2005 13:03:36 PDT
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9283>

Josef Weidendorfer wrote:

>On Sunday 25 September 2005 09:07, Marco Costalba wrote:
>
>>>>src/rangeselectbase.h QSettings: error creating /.qt
>>>>QSettings: error creating /.qt
>>
>>...
>>QSettings are there from day one :-<
>>I am not able to let them disappear.....very bad. In any case should be
>>harmless.
>
>
>These errors seam to appear because scons does NOT pass through the $HOME
>environment variable to subprocesses. "moc", which is producing these
>errors, obviously wants to access some config options in $HOME/.qt/.
>
>Somebody knows how to change this?
>

$HOME environment variable is passed to scons in SConstruct with

env['HOME'] = os.environ['HOME']


then moc util is called in qt.py inside scons-mini.tar.bz2

That's where I stopped.....

Anyone that can teach qt.py to pass $HOME to moc and uic tools is greatly appreciated.

Marco



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
