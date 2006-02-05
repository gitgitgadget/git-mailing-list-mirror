From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sat, 04 Feb 2006 17:58:29 -0800
Message-ID: <43E55BC5.4010400@zytor.com>
References: <20060203114133.GA11499@kvasir.watson.ibm.com> <7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net> <20060205003741.GB29021@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Sun Feb 05 02:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5ZAu-0006Mz-EO
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 02:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWBEB6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 20:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWBEB6p
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 20:58:45 -0500
Received: from terminus.zytor.com ([192.83.249.54]:10946 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964858AbWBEB6p
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 20:58:45 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k151wTJV031049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Feb 2006 17:58:30 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Amos Waterland <apw@us.ibm.com>
In-Reply-To: <20060205003741.GB29021@kvasir.watson.ibm.com>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15615>

Amos Waterland wrote:
> 
> If your TERM is set to `emacs' then that is fine.  If it is set to
> `dumb' however, that seems a bit strange.  A dumb terminal is usually
> understood to be one that does not have the ability to interpret control
> sequences.
> 
> The reason I sent the patch is that people get a rather unpleasant
> introduction to git when vi splatters control characters all over their
> emacs session when they do their first commit.  I agree that people
> probably should have their EDITOR set to emacsclient though, so if you
> want to just leave the code as is that's cool with me.
> 

Sounds more like an unpleasant introduction to emacs.

	-hpa
