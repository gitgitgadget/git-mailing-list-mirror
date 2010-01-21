From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Wed, 20 Jan 2010 21:33:10 -0500
Message-ID: <20100121023310.GB18213@onerussian.com>
References: <20100121004756.GA18213@onerussian.com>
 <be6fef0d1001201736g9160306g51949a5f36d83e14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 03:33:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXmrb-0001Sq-Dk
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 03:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0AUCdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 21:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952Ab0AUCdO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 21:33:14 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:37280 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0AUCdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 21:33:13 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXmr8-00055Z-Mw; Wed, 20 Jan 2010 21:33:10 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXmr8-00055W-Ff; Wed, 20 Jan 2010 21:33:10 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1001201736g9160306g51949a5f36d83e14@mail.gmail.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: rctay89@gmail.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137619>

$> GIT_CURL_VERBOSE=1 GIT_TRACE=2 ./git clone http://git.debian.org/git/pkg-exppsy/pymvpa.git 
trace: built-in: git 'clone' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
warning: templates not found /home/yoh/share/git-core/templates
Initialized empty Git repository in /home/yoh/proj/misc/git/pymvpa/.git/
trace: run_command: 'remote-http' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
trace: exec: 'git' 'remote-http' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
trace: exec: 'git-remote-http' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
trace: run_command: 'git-remote-http' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
* Couldn't find host git.debian.org in the .netrc file; using defaults
* About to connect() to git.debian.org port 80 (#0)
*   Trying 217.196.43.134... * Connected to git.debian.org (217.196.43.134) port 80 (#0)
> GET /git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.6.6.267.g5b159
Host: git.debian.org
Accept: */*
Pragma: no-cache

* The requested URL returned error: 404
* Closing connection #0
fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

as for smart vs DAV -- don't see any smart alias handling in apache
configuration (I have/had no clue about some smart http in git, just looked at
apache template and saw smart aliases -- is there smth else to check within
webserver config?)

On Thu, 21 Jan 2010, Tay Ray Chuan wrote:

> On Thu, Jan 21, 2010 at 8:47 AM, Yaroslav Halchenko
> <debian@onerussian.com> wrote:
> > $> GIT_TRACE=2 ./git clone http://git.debian.org/git/pkg-exppsy/pymvpa.git
> > trace: built-in: git 'clone' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> > warning: templates not found /home/yoh/share/git-core/templates
> > Initialized empty Git repository in /home/yoh/proj/misc/git/pymvpa/.git/
> > trace: run_command: 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> > trace: exec: 'git' 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> > trace: exec: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> > trace: run_command: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> > fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

> oh, and by the way, could you also run this again with GIT_CURL_VERBOSE=1?
-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
