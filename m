From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 03 Oct 2005 11:32:04 -0700
Message-ID: <43417924.7000308@zytor.com>
References: <20050930160353.F025C352B7B@atlas.denx.de> <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net> <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net> <433F52DC.5090906@zytor.com> <pan.2005.10.02.09.55.52.564046@smurf.noris.de> <4340B73B.1090409@zytor.com> <7virwfuqwv.fsf@assigned-by-dhcp.cox.net> <43415C9A.1090502@zytor.com> <Pine.LNX.4.64.0510031028370.31407@g5.osdl.org> <434172FD.7020302@zytor.com> <Pine.LNX.4.64.0510031113500.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 20:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMV79-0008Ls-R1
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 20:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVJCScR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVJCScQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 14:32:16 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:14480 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932524AbVJCScN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 14:32:13 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j93IVwJv016186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2005 11:32:01 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510031113500.31407@g5.osdl.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9644>

Linus Torvalds wrote:
> 
> Is it? The only place umask is mentioned in the man-page is
> 
>        --no-same-permissions
>               apply  user?s  umask  when  extracting files instead of recorded
>               permissions
> 
> but if tar really does honor umask, then hey, that 0777/0666 is fine.
> 
> (Ahh, googling a bit more, it appears that "-p" is default for root, which 
> explains why you'd need the "anti-flag").
> 

Yeah, that assymetry is rather unfortunate.

	-hpa
