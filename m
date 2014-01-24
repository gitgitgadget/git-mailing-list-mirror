From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 10:01:04 +0100
Message-ID: <20140124090104.GA396@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 10:08:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6ckn-0002tP-QF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 10:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaAXJIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 04:08:30 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:43900 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaAXJHr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 04:07:47 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2014 04:07:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:subject:message-id:mime-version:content-type; s=
	beta; bh=jraUlESO0+hPAkviryb5PJOXqQxqALvWmNcVtVQf0jg=; b=OlKhW8M
	F2N3OgbwVTEWYKlQt5GfZdgWb9hiWxIRYPL+SNBQb2Wq8aSO4GsvLGlFtxyUh0O2
	IVjIuAK74HoBwtXsDtyQc8cz82+uK7uGK5vYzDPLWnqSQc0qGVVA0dwF9KSB+SpG
	nh44xHLjeJNFYbGvalTOJ++/prGOzWWhp9v8=
Received: (qmail 15948 invoked from network); 24 Jan 2014 10:01:04 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 24 Jan 2014 10:01:04 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240997>

I would like to ignore branches that match a certain pattern, e.g.:

markus@x4 gcc % git branch -a
  gcc-4.8
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/aldyh/cilk-in-gomp
...
  remotes/origin/hjl/arch
  remotes/origin/hjl/asan
...
  remotes/origin/hjl/x86/m16
  remotes/origin/ifunc
  remotes/origin/jason/4.6-cxx0x
  remotes/origin/jason/alias-decl
  remotes/origin/jason/comdat-debug
  remotes/origin/lw-ipo
  remotes/origin/master
...

Is it possible to ignore all branches that match "hjl"?

-- 
Markus
