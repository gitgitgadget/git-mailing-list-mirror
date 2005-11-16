From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix git_config_set() for mean cases
Date: Wed, 16 Nov 2005 12:52:04 -0800
Message-ID: <437B9BF4.6020803@zytor.com>
References: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de> <7vhdac738c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:52:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcUGc-0000ex-1k
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbVKPUw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 15:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbVKPUw1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:52:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:9946 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030489AbVKPUw0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:52:26 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAGKq9oa008603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Nov 2005 12:52:09 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdac738c.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12056>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
>=20
>>There were problems when the keys=B4 case didn=B4t match, and also wh=
en the
>>section was in the same line as the key.
>>
>>This patch also adds a test case, so you see that it works now.
>>
>>Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>=20
>=20
> Why do you spell apostrophe with 0xb4 not ASCII 0x27?  Not that
> it matters because I'll apply it with -u flag to git-am to
> convert it to UTF-8 in the log message, but I am just curious.
>=20

Not to mention the fact that it's just plain wrong -- U+00B4 is accute=20
accent, not apostrophe.

	-hpa
