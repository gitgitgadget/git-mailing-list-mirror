From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bug: Problem with CRLF line ending in git-diff with coloring
Date: Fri, 14 Feb 2014 22:19:03 +0100
Message-ID: <52FE8847.8020101@kdbg.org>
References: <20140209110155.GB16189@scotty.home> <20140214164709.GI7560@pille.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 22:19:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQAQ-0001Fh-5y
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbaBNVTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:19:21 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:35938 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753019AbaBNVTT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:19:19 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 4DDABCE1BE
	for <git@vger.kernel.org>; Fri, 14 Feb 2014 22:19:17 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ADD2A13004A;
	Fri, 14 Feb 2014 22:19:04 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7DEF819F3C5;
	Fri, 14 Feb 2014 22:19:03 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140214164709.GI7560@pille.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242147>

Am 14.02.2014 17:47, schrieb Stefan-W. Hahn:
>> It's the right solution. IOW, you should place something like this in
>> your .gitattributes:
>>  *.html whitespace=cr-at-eol
> 
> Sorry, but this is not possible, because I have files of both sorts (mainly
> C/C++) files in my repository and cannot change the files as I wish.

I'm confused. This setting does not change your files, but instructs git
diff and git apply to not report the trailing CR as white-space error.
Didn't you try it?

-- Hannes
