From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Filter log based on paths NOT touched
Date: Mon, 25 Nov 2013 23:34:36 -0500
Message-ID: <529424DC.6030107@ubuntu.com>
References: <5293B0F9.1050200@ubuntu.com> <xmqqeh64xlqw.fsf@gitster.dls.corp.google.com> <CACsJy8DR-ckmZ8Ey9Gh1fhv17_+mRPmeLdj_7LoCnvc9fnnpTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 05:34:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlAMH-0007NG-F1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 05:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3KZEem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 23:34:42 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61918 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab3KZEei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 23:34:38 -0500
X-Authority-Analysis: v=2.0 cv=D/fF24tj c=1 sm=0 a=3SewDSjaRW4vdJyuxQ33ZQ==:17 a=JlIHnqCoHBcA:10 a=4nDecEzL28MA:10 a=S1A5HrydsesA:10 a=DeBnktw0k-IA:10 a=IkcTkHD0fZMA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=82lbTQEwWqYA:10 a=QfKxxUxMAAAA:8 a=9O337dEOID9EkWMQJ1EA:9 a=QEXdDO2ut3YA:10 a=3SewDSjaRW4vdJyuxQ33ZQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 72.238.73.171
Received: from [72.238.73.171] ([72.238.73.171:50863] helo=[192.168.1.6])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id AB/16-20755-CD424925; Tue, 26 Nov 2013 04:34:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACsJy8DR-ckmZ8Ey9Gh1fhv17_+mRPmeLdj_7LoCnvc9fnnpTg@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238370>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 11/25/2013 10:13 PM, Duy Nguyen wrote:
> There's a difference between "skip commits that touch anything
> directory foo even if it also touches something outside of foo" and
> "skip commits that _only_ touches something in foo". Not sure which
> way Phillip wants here. Negative pathspec only supports the latter.
> The former needs a new option in rev-list, because the logic to
> consider a commit not a match if it matches a pathspec is out of
> tree_entry_interesting()'s control.

I'm looking for the latter.  Specifically I'm trying to see what changes to the upstream code a debian package has made so I need to ignore commits that only change things in debian/.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJSlCTcAAoJEJrBOlT6nu75jUQIAJOybMyXE6lr4y4aX6od02Rn
lINvPVC1Xub2E1lsofIB+N4QvZDRWlIJOIcj3GRqirzUcNBaIOUxUW4+UV7KgMQH
wmImS8DdBgrkI8Sompe9B0gqd4lmB2mzTutQfOzdEZ/ZOU50935daYboK//X7zM/
vSmumJpRwNfw1BKyuxVpAQ8Ablo9yUu2cswLKJPSKyQkT9d/AJn07LE5/DKZORQN
RD3r94kToftgTfsQTJbNpPujJ5nVHwVmiC44Qghdquj54l++ai5Xs2wRU3Za3i+O
ts7Tn5Lrw+pFAT5Lnt0v8Yedp7fVgjRhIsNEDIVlgNuHevP/oBOXIxuLJBlCBIE=
=AYYO
-----END PGP SIGNATURE-----
