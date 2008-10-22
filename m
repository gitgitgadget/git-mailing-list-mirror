From: kenneth johansson <ken@kenjo.org>
Subject: git archive
Date: Wed, 22 Oct 2008 08:42:01 +0000 (UTC)
Message-ID: <gdmp0p$92r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 10:43:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZJW-0000ST-UB
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYJVImV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYJVImV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:42:21 -0400
Received: from main.gmane.org ([80.91.229.2]:56685 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbYJVImU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:42:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KsZIB-000847-S4
	for git@vger.kernel.org; Wed, 22 Oct 2008 08:42:11 +0000
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 08:42:11 +0000
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 08:42:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98849>

I was going to make a tar of the latest stable linux kernel. 
Done it before but now I got a strange problem. 

>git archive --format=tar v2.6.27.2
fatal: Not a valid object name

this is the output from some other command on the same bare repository.

>git tag | grep 2.6.27.2
v2.6.27.2

>git cat-file -p v2.6.27.2
object 6bcd6d778419101dd96cbbdf03eeab8d779b1d66
type commit
tag v2.6.27.2
tagger Greg Kroah-Hartman <gregkh@suse.de> Sat Oct 18 10:58:00 2008 -0700

This is the v2.6.27.2 stable release
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj6I6sACgkQMUfUDdst+ylcigCg0/e3kQZwAqLp6wPuPqdWl7nL
X0wAnjuNPJG1OqZfhMiAGccLx0QGvMQz
=INvo
-----END PGP SIGNATURE-----

>git cat-file -p 6bcd6d778419101dd96cbbdf03eeab8d779b1d66
tree a717af81e5a2e8a7ee36f3b80aa077965f570197
parent 6505670551fa3deeb6e5d7cab6983514384c7220
author Greg Kroah-Hartman <gregkh@suse.de> 1224352642 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> 1224352642 -0700

Linux 2.6.27.2


>git archive --format=tar a717af81e5a2e8a7ee36f3b80aa077965f570197
fatal: not a tree object

>git cat-file -t a717af81e5a2e8a7ee36f3b80aa077965f570197
tree
