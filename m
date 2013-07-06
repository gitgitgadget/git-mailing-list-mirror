From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Sat, 06 Jul 2013 17:49:18 +0200
Message-ID: <51D83C7E.8000902@web.de>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com> <1373025947-26495-2-git-send-email-artagnon@gmail.com> <51D82970.5070108@web.de> <20130706143256.GX862789@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Jul 06 17:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvUk1-0001pl-VY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 17:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab3GFPtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 11:49:25 -0400
Received: from mout.web.de ([212.227.15.4]:50935 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab3GFPtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 11:49:24 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LaqwS-1USzX50o7k-00kNle; Sat, 06 Jul 2013 17:49:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130706143256.GX862789@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:Jn3/D8H1wtYDDgBeMXIktRWvxaB0h+s5EXU9b/f9dFkgLPn+OP7
 DinusQBfVQ9KTg+cb53ITQ77baSgaT2i4dwfD62QQD++n4NUS4Z3w+qmf/5SmPuV8L+N9mk
 Em2OX+yZtLad3R3vxOD6IkbovrIypjAFsF8dYAcqatYmVP5VFwQYih6ZIENL27DgoasKST/
 10XrjfQO8yKA+16xiLVuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229704>

On 2013-07-06 16.32, brian m. carlson wrote:
> perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSION\n";'

Mac OS X, 10.6:
(I think this perl we use for git:)
/usr/bin/perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSION\n";'
1.22

(And this is in my path:)
 which perl
/opt/local/bin/perl

perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSION\n";'
Can't locate IO/Socket/SSL.pm in @INC (@INC contains: /sw/lib/perl5 /sw/lib/perl5/darwin /opt/local/lib/perl5/site_perl/5.8.9/darwin-2level /opt/local/lib/perl5/site_perl/5.8.9 /opt/local/lib/perl5/site_perl /opt/local/lib/perl5/vendor_perl/5.8.9/darwin-2level /opt/local/lib/perl5/vendor_perl/5.8.9 /opt/local/lib/perl5/vendor_perl /opt/local/lib/perl5/5.8.9/darwin-2level /opt/local/lib/perl5/5.8.9 .).

/Torsten
