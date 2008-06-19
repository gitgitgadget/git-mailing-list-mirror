From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/2 v5] Git.pm: add test suite
Date: Thu, 19 Jun 2008 22:55:36 +0200
Message-ID: <485AC7C8.5040100@gmail.com>
References: <1244a3347b6f15120e57f6b9223a4e2db06479df.1213899000.git.LeWiemann@gmail.com>	<1213907569-6393-1-git-send-email-LeWiemann@gmail.com> <m3lk11m9j7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RAp-0006Cx-9b
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYFSUzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 16:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYFSUzH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:55:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:13143 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYFSUzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 16:55:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so487885fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=5yHfftZizix7bo9OF6FEVsRHn6t3jxKs7ypEINjlMZE=;
        b=trQCaLtEC1m6iWxWErIr141q8kWRCzEbUspuvA2gd14tCpn/oZ15x0evCDPX3ywnyl
         fZj2iRl66oYlEks1XeEXoHaTw4b0Q0ywKZfUiV91BhqDmAVVU9qHB3OiOgLU3uyxYeL/
         oYT0SXpYU/9tUWIKtaEb+BO84g8Yx15eYZdpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=NdLHt0S/a2jj3vKH8W9ACeQKAocGdiOiqdbUStsSCjslP6lOzShzH9QyG1QhfthYH2
         lMN7JCVoo/3kyRHFGQbOBVqNb+qTDFcO8RAeaukYK2LEcQmkknOvijhGUrgrAssJOmmL
         LLvc13c2fhBN6pWpWxsJgwelaiQCYoh74c9HY=
Received: by 10.86.29.19 with SMTP id c19mr2718369fgc.28.1213908904427;
        Thu, 19 Jun 2008 13:55:04 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.94])
        by mx.google.com with ESMTPS id 12sm1882145fgg.0.2008.06.19.13.55.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 13:55:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <m3lk11m9j7.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85528>

Jakub Narebski wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
>>     +use 5.006002;  # Test::More was introduced in 5.6.2
> 
> Isn't "use Test::More" enough, so this line is not strictly
> necessary?

I'd prefer to have a 'wrong Perl version' error instead of 'module not 
found'.  Also it's good to document what we support, to remind me that I 
have to run it with perl5.6.

-- Lea
