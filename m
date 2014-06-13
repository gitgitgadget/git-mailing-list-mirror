From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: git rebase --skip stuck in a loop
Date: Thu, 12 Jun 2014 21:16:34 -0400
Message-ID: <539A50F2.40206@ubuntu.com>
References: <5397551C.4030709@ubuntu.com> <539A151C.50307@ubuntu.com> <20140613010256.GD368384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 03:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvG6j-0001PG-1i
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 03:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbaFMBQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 21:16:36 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:53735 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750908AbaFMBQf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 21:16:35 -0400
X-Greylist: delayed 15317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2014 21:16:35 EDT
Received: from [72.238.67.160] ([72.238.67.160:41596] helo=[192.168.1.100])
	by cdptpa-oedge02 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id D8/A4-24736-2F05A935; Fri, 13 Jun 2014 01:16:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140613010256.GD368384@vauxhall.crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251509>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 06/12/2014 09:02 PM, brian m. carlson wrote:
> On Thu, Jun 12, 2014 at 05:01:16PM -0400, Phillip Susi wrote:
>> So nobody has any ideas on what to check for or how to debug
>> this?
> 
> I'm assuming this works in the general case, because we have tests
> for it.  Do you perhaps have a repository and a set of reproduction
> steps we could use to try to reproduce this?
> 
> If you can get that information, I'm interested in trying to fix
> it.

I don't have a set of reproduction steps, but I do still have the repo
that is in this stuck state if there is any data you might want me to
pull out of it ( .git/rebase-apply? ).

I had spoken to another Ubuntu dev who said that he had this happen to
him once too and he just did an abort and tried again and the problem
went away, so it seems hard to reproduce, which is why I have
preserved the problem to try and analyze it.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTmlDyAAoJEI5FoCIzSKrwN0IH/R6ny2h1XLv3Rj2Aed6C8xzU
+XsiNo6RYG9++Jk3vr705CVnmWx+4lwhr7E6jW9ValdDKEYjamypeQUyqrWSokiH
IajIMc4BNowGW7Eg1uRV8KQfb1P+QtmxBMwumOnOYk9zPfA9JcmlPVT6g5LrKy9N
6TMIlCMY1v0WPKZhseYYWHayP8PHF8KqSVuGIAZoPKPQdOQjNAOLW+PPbxiQKCcB
PrspPx+hNk4NUUm8156BdJO+xEGQpSYIY384yo0dEfvh3QHB4z/wTv84/9APxEQO
rV+67fW1psrFX+GkUolL9WFCBOeZRk3nykYJRravSOuOJKBa9laGAmiJT/EjWYI=
=DONL
-----END PGP SIGNATURE-----
