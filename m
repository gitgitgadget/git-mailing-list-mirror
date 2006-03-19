From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit 1.1.1
Date: Sun, 19 Mar 2006 17:53:25 +0100
Message-ID: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Mar 19 17:53:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL19l-00041N-Cd
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 17:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWCSQx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 11:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWCSQx0
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 11:53:26 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:64956 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751355AbWCSQx0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 11:53:26 -0500
Received: by wproxy.gmail.com with SMTP id i21so898281wra
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 08:53:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aC9KSeIM6nsxHaTDHspVy8ihkKAx4ccXpRGAoc0+PW/uihi5dGqfRgjVt4T4aDW8CXJjh4M99aXBAp5pMG+buQ7OOmoDCBGHzumHuTV6cKzZz1Q98Ibogf7a0mWfQMjrG+RSqKsXzJGsakWKsXWmxFAnyROGee3E8opf3QRyn5Y=
Received: by 10.64.201.14 with SMTP id y14mr1108042qbf;
        Sun, 19 Mar 2006 08:53:25 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 08:53:25 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17716>

This is a maintenance release, mainly performance tweaks and small bug fixes.

To install use:

./configure
make
make install-strip

Or check the shipped README for detailed information.

To note are big speed-up in annotation and tree viewer browsing

See http://digilander.libero.it/mcostalba/  for download information.

Changelog
    *  add support for file annotations in multi-branch repos
    * speed-up browsing with tree view open
    * tree view: set in bold the names of modified files
    * use a map instead of a list to speed-up path filtering
    * add support for listing tags in a submenu in mainview context pop-up
    * show StGIT patch names on the status bar (Pavel Roskin)
    * use dark green pluses for applied StGIT patches (Pavel Roskin)
    * more then double annotation speed
    * add support for jumping to branches from pop-up menu
    * remove setting 'Load file names in background'
    * save cache file under ./git directory
    * fix duplicate tags in the pop-up menu (Pavel Roskin)

Have fun
Marco
