From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Sun, 26 Jul 2009 16:08:08 +0200
Message-ID: <4A6C6348.90607@alum.mit.edu>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 16:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV4RP-0002H5-Kh
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 16:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbZGZOIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 10:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbZGZOIO
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 10:08:14 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59090 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbZGZOIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 10:08:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (p4FC1C88A.dip.t-dialin.net [79.193.200.138])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n6QE89Kx001346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 26 Jul 2009 16:08:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.22) Gecko/20090608 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
In-Reply-To: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124122>

Junio C Hamano wrote:
> * hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
>  - t/t9600: remove exit after test_done
>  - cvsimport: extend testcase about patchset order to contain
>    branches
>  - cvsimport: add test illustrating a bug in cvsps
>  - Add a test of "git cvsimport"'s handling of tags and branches
>  - Add some tests of git-cvsimport's handling of vendor branches
>  - Test contents of entire cvsimported "master" tree contents
>  - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
>  - Start a library for cvsimport-related tests

What needs to happen to get these changes moving again?  The last
relevant comment I can find from you about this subject is from 2009-02-22:

> Thanks, both.  I generally am not very fond of adding tests without
> intention to look into fixes, but if they make outstanding bugs more
> visible, they may have the effect of shaming the original authors
> badly enough to step in in the effort of fixing them  ;-)

No knight in shining armor has shown up to fix these bugs, but there is
still value to documenting them in the form of unit tests.

Michael
