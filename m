From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 1/3] poll.h lies in the same folder, so use normal quotes
 for include
Date: Thu, 09 May 2013 03:31:32 +0200
Message-ID: <518AFC74.2040500@cs-ware.de>
References: <518AF79A.5000408@cs-ware.de> <518AF7EA.6020403@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:32:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFiI-0005s3-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab3EIBbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:31:45 -0400
Received: from srv1.79p.de ([213.239.234.118]:33240 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab3EIBbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:31:34 -0400
Received: from [192.168.0.20] (p5B03ACDA.dip0.t-ipconnect.de [91.3.172.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id EB084441600
	for <git@vger.kernel.org>; Thu,  9 May 2013 03:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368063092;
	bh=eYp5d8z+eFHimWddzBdnUVpUVzi7YnHltwCLDZ4JtpA=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=G/fBRROe6xIUfMJCk/PZBC0N+CkMsfbJ04OWVCMcdrmBG1hh8ssEZZDRHk5+4Fizr
	 i76bHVwKGJIQvuYF1vol5OvlIZA/uH5I2waDDUJVQnslm1rVcia16DZmXW4oKAXvJu
	 WE3H5coxJxKC2Vw0MXXKCG8+ZtbT7MJN315y3ApU=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518AF7EA.6020403@cs-ware.de>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223705>

Am 09.05.2013 03:12 schrieb Sven Strickroth:
> Some compilers, like Visual C++ complain when <> is used instead of
> double quotes for non system includes.

I just noticed that this patch isn't necessary for 1.8.3 (since
41f2999180f5a58f2a4214d896359c1587c9024f) any more. Sorry for the noise
- I was still building against 1.8.2.2.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
