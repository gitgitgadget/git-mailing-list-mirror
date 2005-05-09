From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: History messup
Date: Mon, 09 May 2005 12:34:43 -0700
Message-ID: <427FBB53.1000801@zytor.com>
References: <1115657971.19236.33.camel@tglx>	 <1115659677.16187.393.camel@hades.cambridge.redhat.com>	 <1115660903.19236.39.camel@tglx>  <427FB3A7.8050906@zytor.com> <1115665598.12012.422.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 21:29:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVDvK-0000qH-QC
	for gcvg-git@gmane.org; Mon, 09 May 2005 21:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVEITfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 15:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEITfQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 15:35:16 -0400
Received: from terminus.zytor.com ([209.128.68.124]:47802 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261486AbVEITfL
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 15:35:11 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49JYnHV030595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 12:34:49 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115665598.12012.422.camel@baythorne.infradead.org>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> 
> Of course it isn't. But neither is the meaning "a committer" or 
> "an author" or even "a date".
> 
> Including some kind of repo-specific identifier with each commit would
> help us to make sense of the history, just as those other fields do.
> 

I'm particularly thinking of when you copy and clone directories, you 
have to define your semantics more specifically.  When do you want to 
*copy* this ID, and when do you want to make sure a new one is created?

One possible answer to that is to have .git/repoid and have it 
auto-created (from /dev/urandom) if it doesn't exist, but I also observe 
that at least two people (davem and pavel) have managed to clone "Linus' 
kernel tree" as their description on http://www.kernel.org/git/ ...

	-hpa
