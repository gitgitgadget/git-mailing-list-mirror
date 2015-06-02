From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: git-repack keeps running out of memory
Date: Mon, 01 Jun 2015 20:04:22 -0400
Message-ID: <556CF306.6000308@ubuntu.com>
References: <556CA6C8.6000804@ubuntu.com> <xmqqlhg35ky2.fsf@gitster.dls.corp.google.com> <556CAD64.8000208@ubuntu.com> <20150601205854.GA21144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 02:11:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZnn-0006Db-C4
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbbFBAL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:11:27 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:60448 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753437AbbFBAL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 20:11:26 -0400
Received: from [72.238.77.169] ([72.238.77.169:42218] helo=[192.168.1.142])
	by cdptpa-oedge03 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 4F/B0-04997-603FC655; Tue, 02 Jun 2015 00:04:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150601205854.GA21144@peff.net>
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270500>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 06/01/2015 04:58 PM, Jeff King wrote:
> How many processors do you have? The window-memory is per-thread.
> Try with --threads=1.

Ahh, right... 8... that explains it ;)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVbPMBAAoJENRVrw2cjl5R2rkH/0qa9HerYM7Bw5qfcV3zahFz
5g/NGoW3M9IutqqLiyDzAQboj62+TzrEuM/fo7BgZrKYBsA7/4SNdJMmabaUb5Kr
rtW1qfpErIHUQUY0wAxBwXX7gpihB3HTYRsZAX+7Itfae7bw8r3krj/L1Ty2nj3Y
QLIm9uwijiBNpHoF9Jnl6gbklaVFbBBfdGH2uPLzoso5YdlJ0L6o4VDmeD55njjx
30cOLDwInQ4zxdGKBH1SaIXGq+2Vi1txLrzYaaEOA+NW9+Rp7J9Anqcv/IH5yyX/
y9H0yDXXP/3gPwTHvYiRTVWMjAvjxSdc4n4ZgySLBPTruW1utxjPdaTSffm2xsg=
=wza7
-----END PGP SIGNATURE-----
