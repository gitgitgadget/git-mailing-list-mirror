From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] completion: fix alias listings with newlines
Date: Thu, 08 Oct 2009 09:54:36 +0200
Message-ID: <4ACD9ABC.4070809@viscovery.net>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com> <4ACC6055.1070204@viscovery.net> <4ACCE417.5080907@gmail.com> <20091008042917.GX9261@spearce.org> <4ACD961D.9080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 10:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvnvN-0000p4-Uz
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 10:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbZJHHzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 03:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbZJHHzR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 03:55:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7682 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbZJHHzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 03:55:17 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mvnpd-0002GF-6d; Thu, 08 Oct 2009 09:54:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8A5894E9; Thu,  8 Oct 2009 09:54:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4ACD961D.9080401@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129680>

Stephen Boyd schrieb:
> Shawn O. Pearce wrote:
>> Or a format string with a language based escape like for-each-ref
>> supports?  Might make it easier to use git config in scripts if we
>> can write things like:
>>
>>   git config --format='$data{%(key)}=%(value);' --perl
> 
> This sounds reasonable, but also like more work ;-)

OTOH, you can simply revert the hunk from 518ef8f (completion: Replace
config --list with --get-regexp, 2009-09-11) that applies here, or even
only reinstate the case statement in the loop body without changing
anything else.

-- Hannes
