From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: git stash doesn't honor --work-tree or =?utf-8?b?R0lUX1dPUktfVFJFRQ==?=
Date: Sun, 1 Dec 2013 19:12:30 +0000 (UTC)
Message-ID: <loom.20131201T200904-80@post.gmane.org>
References: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com> <loom.20131130T221443-682@post.gmane.org> <874n6sddu7.fsf@thomasrast.ch> <CACsJy8BFqqy8T1zwZd7Ly1-sAKGoxh0YfhFBgX6fBMTt_b5Dbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 20:13:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnCS4-0000RQ-W6
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 20:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab3LATMz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 14:12:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:33309 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab3LATMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 14:12:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VnCRo-0000Fm-F8
	for git@vger.kernel.org; Sun, 01 Dec 2013 20:12:52 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 20:12:52 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 20:12:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238594>

Duy Nguyen <pclouds <at> gmail.com> writes:

> It should. At the beginning of cmd_rev_parse(), setup_git_directory()
> is called, which will check and follow all GIT_* or their command lin=
e
> equivalent. I'll look into this some time later.

I think I was wrong and rev-parse --is-inside-work-tree *does* honor
them. It prints 'false'. If it hadn't honored them it would have printe=
d
"fatal: Not a git repository (...)".

=C3=98sse
