From: "David Aguilar" <davvid@gmail.com>
Subject: [ANN] git cola: a highly caffeinated git gui
Date: Thu, 31 Jul 2008 23:08:01 -0700
Message-ID: <402731c90807312308l4870382dsb707fafd37f9b1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Aug 01 08:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOnp7-0006Iz-HP
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 08:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYHAGIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 02:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbYHAGIF
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 02:08:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:45681 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbYHAGID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 02:08:03 -0400
Received: by ug-out-1314.google.com with SMTP id h2so455231ugf.16
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=54jh50GIGQMop/rYg0ehpQHoPH7OyamQSShowjhcg3k=;
        b=RMkLcyH4iU+UdkisZvYu5a54TnOJi3df/YwatUIG2T4Bgr9qhm+OlGjhun3BhyETDc
         9eShazpJxTmSP6tpfR1kJcqq03kRKb7LsnnnTCgADmOa8Ts3OYNLSwIkVqXe5jydpt7O
         61LY6YZn+VvjDNGOn3cJGjoVHW2Zb9HKPSHpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ldOX7KAC2PX8JrxrT3ZAZ0q8YaH0X8NxdmWowJ4cb61H5JuBgPjj4OtzgDwI330M+x
         QIm9qo8aeCgeKu0iqM6G/v+0wFEkWxORviAxxJfmYDx6MJg0DUo9nMLqUc9yfaxI7f02
         pLHiGbVjytxjkjPkpcSaKaN5uoYq/oBq0LHc4=
Received: by 10.66.222.6 with SMTP id u6mr3386115ugg.21.1217570881600;
        Thu, 31 Jul 2008 23:08:01 -0700 (PDT)
Received: by 10.66.241.12 with HTTP; Thu, 31 Jul 2008 23:08:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91029>

Greetings!

The latest version of git cola is available for download from the
usual interwebs:

    http://cola.tuxfamily.org/
    http://gitorious.org/projects/git-cola/

git cola is a highly functional git gui licensed under the gpl.
It's written in Python/Qt4.  In addition to its native platform
(Linux/Unix), cola also runs on OSX and Windows.

Although tarballs, .rpms and .deb packages are available, building it
from source is very easy.

On debian it's as simple as:

    sudo apt-get install simplejson python-qt4 pyqt4-dev-tools python-pyinotify
    git clone git://gitorious.org/git-cola/mainline.git cola
    cd cola && ./configure && make && make install

Like git gui, it allows you to do very fine-grained commits.  It has a
bunch of other random useful stuff, so I figured it was about time to
announce it here.  It has inotify support on Linux, which is why
there's no rescan button in cola.

Hopefully the code isn't too rotten ;-)


CAVEATS:

i18n/l10n is incomplete.  I used the latest .po files from git-gui,
but obviously there are a number of strings in git cola that don't
have translations.  If there is an interest in cola from the user
community then I will need some advice on how to handle this
situation.  I don't like having stolen the .po's from git-gui (sorry
Shawn!) but it did prove that the infrastucture for "LANG=ja git cola"
is working correctly.

cola works by parsing git commands.  It's pretty fast despite the
process overhead, though it'll probably be a bit slower on windows.  I
have no idea what cr/lf issues exist (if any), though I've tried to be
careful about it.


enjoy,

p.s. if you happen to prefer dark color themes you can run: git cola
--style=dark

-- 
 David
