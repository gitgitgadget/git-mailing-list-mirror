From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb on kernel.org and UTF-8
Date: Tue, 22 Nov 2005 19:42:33 -0800
Message-ID: <4383E529.5000608@zytor.com>
References: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net> <4383BEE4.1060800@zytor.com> <20051123033526.GA24098@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 04:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EelX1-0001qM-F0
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 04:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVKWDmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 22:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVKWDmr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 22:42:47 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52968 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932500AbVKWDmq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 22:42:46 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAN3gc7k005609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Nov 2005 19:42:38 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051123033526.GA24098@vrfy.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12601>

Kay Sievers wrote:
>=20
> Should be fine now. The escapeHTML() garbled the utf8 "=C3=B6", and t=
he
> decode() failed that.
>=20

Indeed, looks much better.

Now if I could only figure out why both Konsole and Firefox seems to us=
e=20
a standalone cedilla to represent U+FFFD, instead of something more=20
logical like an inverted question mark or empty box.

	-hpa
