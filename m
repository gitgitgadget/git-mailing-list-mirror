From: Phillip Susi <psusi@ubuntu.com>
Subject: git rebase --skip stuck in a loop
Date: Tue, 10 Jun 2014 14:57:32 -0400
Message-ID: <5397551C.4030709@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 21:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuRHj-0006wc-RD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 21:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbaFJTAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 15:00:35 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:46838 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752709AbaFJTAe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 15:00:34 -0400
Received: from [67.78.168.186] ([67.78.168.186:58802] helo=[10.1.1.200])
	by cdptpa-oedge01 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 40/CB-15059-C1557935; Tue, 10 Jun 2014 18:57:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Enigmail-Version: 1.6
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251217>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm in the middle of a long rebase and have had no trouble with git rebase --skip several times, but now it has become stuck:

psusi@devserv:~/parted.git$ git rebase --skip
Auto-merging libparted/arch/linux.c
CONFLICT (content): Merge conflict in libparted/arch/linux.c

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

psusi@devserv:~/parted.git$ cat .git/rebase-merge/msgnum
17

Each time I try to skip, it just keeps trying to reapply this one patch.  Any ideas?

git version 1.9.1

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTl1UcAAoJEI5FoCIzSKrwwHIH/38Cm19zg+37zgckLiy/3GhN
3Gmil5kX+3KkIHCxlPz3Ti3xCA5baM7tDzFdDIKcx8N/i8oALgWeAWf1Euy9Ww1K
3etIAMKzO463kmV7UbgSbLz5DpYWSaGo9WiYAC7xklhQV94w1Ainx5Lo4kRv1Wfj
R9TpQgViFnW2gNJv1zw0qHLXk1/h88LlAQsBaaY6I4f/DOLhAte7rGinkTgZtjmo
G/9PUMudQcehG65ITPlNLtoFsM8UHadNMLwJts/B7Yq23XNyRF50IaT8c1A/irSU
mfYqdHCho3D4kq+k0u+t0Z0bj6pfvo4b0khLafrYLrWGHC5K+Z3lE63ysJ/Mdj8=
=LZ9q
-----END PGP SIGNATURE-----
