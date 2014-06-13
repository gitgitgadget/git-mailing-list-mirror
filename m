From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: git rebase --skip stuck in a loop
Date: Fri, 13 Jun 2014 10:15:49 -0400
Message-ID: <539B0795.70907@ubuntu.com>
References: <5397551C.4030709@ubuntu.com> <539A151C.50307@ubuntu.com> <20140613010256.GD368384@vauxhall.crustytoothpaste.net> <539A50F2.40206@ubuntu.com> <20140613073446.GF7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvSGp-00042t-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 16:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaFMOPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 10:15:51 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:17590 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750901AbaFMOPv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 10:15:51 -0400
Received: from [67.78.168.186] ([67.78.168.186:58987] helo=[10.1.1.200])
	by cdptpa-oedge03 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id E4/9D-16046-5970B935; Fri, 13 Jun 2014 14:15:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140613073446.GF7908@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251599>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 6/13/2014 3:34 AM, Jeff King wrote:
> Thanks for saving the stuck state.
> 
> If it's possible to share the whole repo, it might be worth seeing
> (then we can all just run "git rebase --continue" ourselves). If
> it's too big or is confidential, just tarring up .git/rebase-apply
> and making it available is probably a good first step.

It's the debian parted repo, so nothing confidential.  Here it is:

https://drive.google.com/file/d/0ByOQJBpP4bDXXy13YlN0aE5Fcnc/edit?usp=sharing


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTmweVAAoJEI5FoCIzSKrwI84H/2Di1d5MeQpcg/I02nF7sd/f
gICGclFE8MPuTnKYfpYf4/SbSnB9+Znp+9OhQA0frYIblWHWEnUzwhINrDHvqApK
hCsuNGb5iHgy8ohZVGqH8B4ew8x4Ru3pwy9VYV2Wc1Z33curDIohx6qi4LCIrlaB
StzWgq3h8hV+3QB5zcD9MfAfdKkz1u5bIMlT9VYofYwctYERVk2DyaAj8eKBGyWo
6dWYuZDoQfO3Hnd/uGqWbdHrPiDoSQqYPbHNWNOnX24w+IKDv2Xe9bcHro+9A+Jg
PF+QXo4IS1E7CwevExe7gGKK3KdrD9SMixW7hHAbVVnpDIsvw485EL0xsZfmFJk=
=ncor
-----END PGP SIGNATURE-----
