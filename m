From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: FW: question about merge in 1.7.10
Date: Fri, 24 Feb 2012 20:29:31 +0100
Message-ID: <4F47E51B.6080401@in.waw.pl>
References: <1F026B57884A5841B330471696849DE9114503D7@MBX021-W4-CA-5.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Marlene Cote <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S10qD-0005yx-3F
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab2BXTaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 14:30:00 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55079 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2BXT37 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 14:29:59 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S10q5-0003mR-Dz; Fri, 24 Feb 2012 20:29:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <1F026B57884A5841B330471696849DE9114503D7@MBX021-W4-CA-5.exch021.domain.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191448>

On 02/24/2012 03:33 PM, Marlene Cote wrote:
>
> I used merge with -no-commit -no-ff.  So, I assume I won't see any change in behavior, since merge is not performing commits, right?
Hi Marlene,
--no-commit only stops the last step, i.e. making of the commit. The 
tree (working files) is changed before that. So basically after a merge 
with --no-commit, your tree will be dirty and git status will show 
modified files.

zbyszek
