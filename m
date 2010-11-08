From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase problems
Date: Mon, 8 Nov 2010 19:33:27 +0100
Message-ID: <FA37BC66-64CF-4A62-80E9-EC45EAE392C4@wincent.com>
References: <loom.20101108T190513-206@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWXR-0006NT-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab0KHSdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:33:47 -0500
Received: from outmail148110.authsmtp.com ([62.13.148.110]:56147 "EHLO
	outmail148110.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720Ab0KHSdq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 13:33:46 -0500
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt7.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id oA8IXdEc087715;
	Mon, 8 Nov 2010 18:33:39 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id oA8IXVKg048100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Nov 2010 18:33:32 GMT
Received: from [192.168.1.6] (83.Red-88-5-247.dynamicIP.rima-tde.net [88.5.247.83])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id oA8IXS2u001946
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 8 Nov 2010 13:33:30 -0500
In-Reply-To: <loom.20101108T190513-206@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: b0c1d3df-eb66-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH ahYdCF1NdwdEHAkR Am4BWFdeU18/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNZQ0RaXp6 UR4aWhhyd0tBfH9z KxRiDXEPXxAsaBMv REhJFGxSM3ppbzJN TUBYdQFSdApNdhpE Yh4dAXkdAzBVNzk1 VxcpODo1MDBEQEAA 
X-Authentic-SMTP: 61633436303433.1014:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160967>

On 08/11/2010, at 19:19, Maaartin wrote:

> I'm using git for a project I'm working on alone (and I really like it), so I 
> could rebase a lot, if I hadn't the following problems.
> 
> There's a file containing the timestamp which gets compiled in, so the 
> executable can show it's version. Sometimes, I need to set it couple of times a 
> day, sometimes only once a week. For each such timestamp I create a tag, so I 
> can track it to the source easily. The timestamp is an important piece of 
> information, so I put the containing file under version control. The downside is 
> that I often get a conflict in this file halting my rebase. Is there a way how 
> to ignore or automatically resolve all conflicts in this file (any resolution 
> strategy is fine, as it will be overwritten anyway).

Rhetorical questions follow; no need for you to answer:

- Why is the timestamp an "important" piece of information?

- Have you considered that, for versioning purposes (ie. knowing _what_ source code was compiled to produce the product), the commit hash or the output of "git describe" may be much more useful than a disconnected timestamp?

- Regardless of whether you use a timestamp, a commit hash, or the output of "git describe", why can't it be inserted at compile time rather than stored in the repo?

- If you are really enamored of timestamps, would extracting the latest commit timestamp out of the repo be enough?

- Do these repeated merge conflicts set off "code smell" alarm bells for you (really, "process smell"), and make you suspect that there might be something wrong with what you are trying to do?

Cheers,
Wincent
