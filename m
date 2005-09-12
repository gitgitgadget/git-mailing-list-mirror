From: eschvoca <eschvoca@gmail.com>
Subject: local cg-clone doesn't seem to work
Date: Mon, 12 Sep 2005 15:17:57 -0400
Message-ID: <2b05065b050912121721046257@mail.gmail.com>
Reply-To: eschvoca@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Sep 12 21:20:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEtoj-00022J-Oj
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVILTSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVILTSA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 15:18:00 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:49846 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932143AbVILTR6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 15:17:58 -0400
Received: by qproxy.gmail.com with SMTP id f10so122058qba
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 12:17:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oZMlRaBh0sxBjzsHoTdSDuMkSVVVPbAc/orM9jPAQxoUox2ikw3J6C6lbWb45CRRA4z7rwJAbKGrjWpp701RVWnyOai/gG2urPnaqbtIu+sE6HUujqb4DNCeZdRCmTHunHUT2sQkJa3blDEL8mCGWyyygPztt66/jgOWzFldimg=
Received: by 10.64.199.16 with SMTP id w16mr20103qbf;
        Mon, 12 Sep 2005 12:17:57 -0700 (PDT)
Received: by 10.65.44.2 with HTTP; Mon, 12 Sep 2005 12:17:57 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8417>

Hi, I think I've found a bug in cogito.  To reproduce, try this:
 
 mkdir testing
 cd testing
 echo "This is the INSTALL file" > INSTALL
 cg-init  # complete the commit
 
 cd ..
 mkdir testing2
 cd testing2
 cg-clone -s ../testing
 
 Then I get the following error:
 
 defaulting to local storage area
 Using hard links
 cp: missing destination file
 Try `cp --help' for more information.
 cg-pull: unable to get the HEAD branch
 cg-clone: pull failed
 
 I'm a newbie so maybe I'm just doing something dumb.
 
 Thanks in advance for your help.
