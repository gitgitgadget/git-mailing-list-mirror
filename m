From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 11:49:54 +0100
Message-ID: <4D89D052.5030801@drmicha.warpmail.net>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Lh1-0003XJ-Lt
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 11:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab1CWKx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 06:53:27 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57730 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755882Ab1CWKx0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 06:53:26 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6A5612099A;
	Wed, 23 Mar 2011 06:53:26 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 23 Mar 2011 06:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HJKt/rKygKKPWvQDjgb6MFCqy8M=; b=XZ6Slslr2X5tTRwmzyOiW5frDvYaKkZVooeOZXeBITLyjXlcNtXz+in0WaImBbrY731eU3ZWqKUtV4YuLIcx1bawC6S3m9lopCk9Vskz3l0m6cqH2RnZqGp5tpzxhf0ZYZG74EUB5XcquKe5OaDeDGMjb0PVFLrcwOSHotLsbus=
X-Sasl-enc: OS8U9Fuot7Gtfr1jfo5b+RzIjBVTfxrVk2cBwCoT46XD 1300877606
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E92B44007D4;
	Wed, 23 Mar 2011 06:53:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169815>

John Tapsell venit, vidit, dixit 23.03.2011 11:33:
> Hi,
> 
>   Could someone add a feature to  ls-files  to list all the files in
> the repository, but relative to the current path?  It would be useful
> for many different aliases, such as "git locate".

That is in the works, we just have to decide between two suggested
notations:

git ls-files :
git ls-files :/

Michael
