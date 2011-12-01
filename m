From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: mini-wierdness with "git am"
Date: Thu, 01 Dec 2011 10:38:26 -0500
Message-ID: <4ED79F72.4000003@sohovfx.com>
References: <CAKCZoVb5-JfzTXK9pUoem_0oQHrSLkrxQZUOZGTX3GGgebPGwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 16:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW90M-000433-Hn
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 16:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab1LAP4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 10:56:52 -0500
Received: from smtp04.beanfield.com ([76.9.193.173]:51925 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab1LAP4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 10:56:50 -0500
X-Greylist: delayed 1093 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2011 10:56:50 EST
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1RW8iQ-0005ha-OI
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta04.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1RW8iQ-0005ha-OI; Thu, 01 Dec 2011 10:38:26 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <CAKCZoVb5-JfzTXK9pUoem_0oQHrSLkrxQZUOZGTX3GGgebPGwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186175>

On 11/30/2011 06:12 PM, Aghiles wrote:
> At this point, my repository is back to ORIG_HEAD!
> Meaning that it reverted my preivous "git reset --hard HEAD~1".
>   

This behavior seems to have been fixed in v1.7.3.5 and later. The new
behavior will skip the reverting, and only perform the clean up.

http://article.gmane.org/gmane.comp.version-control.git/164045
