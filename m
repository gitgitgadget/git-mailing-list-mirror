From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Mon, 09 May 2005 15:20:56 -0700
Message-ID: <427FE248.7040403@zytor.com>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>	<20050509212842.GC15712@pasky.ji.cz> <7iu0lc129m.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>,
	darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Tue May 10 00:14:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGVr-0006e9-D0
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVEIWVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 18:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVEIWVV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 18:21:21 -0400
Received: from terminus.zytor.com ([209.128.68.124]:28099 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261547AbVEIWVS
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 18:21:18 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49MKuUv001628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 15:20:58 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7iu0lc129m.fsf@lanthane.pps.jussieu.fr>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Juliusz Chroboczek wrote:
> Ahoj,
> 
> 
>>FWIW, Cogito does not lock at all yet - this is one of the things which
>>should be fixed soon.
> 
> 
> I see.  Let me know if you decide to use a different name for the lock
> file so I can switch to using the same one as yours.
> 

Are you using flock(), or some other contraption that breaks if a 
process dies unexpectedly?

	-hpa
