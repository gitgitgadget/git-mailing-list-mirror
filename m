From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: git rebase --skip stuck in a loop
Date: Thu, 12 Jun 2014 17:01:16 -0400
Message-ID: <539A151C.50307@ubuntu.com>
References: <5397551C.4030709@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 23:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvCAZ-0001Jw-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 23:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaFLVET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 17:04:19 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:18937 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751835AbaFLVET (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 17:04:19 -0400
Received: from [67.78.168.186] ([67.78.168.186:51176] helo=[10.1.1.200])
	by cdptpa-oedge01 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 98/EF-15059-D151A935; Thu, 12 Jun 2014 21:01:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <5397551C.4030709@ubuntu.com>
X-Enigmail-Version: 1.6
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251495>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So nobody has any ideas on what to check for or how to debug this?

On 6/10/2014 2:57 PM, Phillip Susi wrote:
> I'm in the middle of a long rebase and have had no trouble with
> git rebase --skip several times, but now it has become stuck:
> 
> psusi@devserv:~/parted.git$ git rebase --skip Auto-merging
> libparted/arch/linux.c CONFLICT (content): Merge conflict in
> libparted/arch/linux.c
> 
> When you have resolved this problem, run "git rebase --continue". 
> If you prefer to skip this patch, run "git rebase --skip" instead. 
> To check out the original branch and stop rebasing, run "git
> rebase --abort".
> 
> psusi@devserv:~/parted.git$ cat .git/rebase-merge/msgnum 17
> 
> Each time I try to skip, it just keeps trying to reapply this one 
> patch.  Any ideas?
> 
> git version 1.9.1
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTmhUcAAoJEI5FoCIzSKrwkjgIAKOclhuJPiNoWIEv1dBr4DBC
IdwG9hY8lQPCN5Pg8th5CYk3ziX7iZ8+jaHEBaUYX2yehT1deg5WfsxU0uezWphH
JyHMRX4kk7l1PW3/v3bEvZ0WYe77s4GB3m9XegjKwEL8xtGi7srEPsHgWB8gnFzE
hswUMbq5mw9hoIpYnxEs18F2MOfP6i4J3gTilPrmq+hZCQyZrX/IsV5lR6kDXRES
j7b3cr6n2EfUeWxKrwo+tMIBdGAgpMamWlzqM7gMND/YUswv84mD3b9lXjEfjqZf
GfBXJSH/z0KLDKycYrDOZlryLEnx///N6STg2WGm0oo7ehAKn6Mtgi1rR5y/aYs=
=bUQV
-----END PGP SIGNATURE-----
