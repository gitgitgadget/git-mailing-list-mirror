From: Douglas Tan <douglas@getgosu.com>
Subject: Propagating config to clones/pulls
Date: Tue, 7 Sep 2010 16:56:57 +0800
Message-ID: <A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 11:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osu5B-00044E-4J
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 11:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab0IGJDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 05:03:04 -0400
Received: from mail.getgosu.com ([67.110.176.227]:57343 "EHLO mail.getgosu.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab0IGJDB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 05:03:01 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2010 05:03:01 EDT
Received: from [10.10.13.18] (unknown [10.10.13.18])
	by mail.getgosu.com (Postfix) with ESMTPSA id A148B22C18
	for <git@vger.kernel.org>; Tue,  7 Sep 2010 04:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=getgosu.com;
	s=default; t=1283847962;
	bh=45NEywuKwb1wtZzV1yhXNWy5kph6n8ATtV2XhWIibOY=;
	h=From:Content-Type:Content-Transfer-Encoding:Subject:Date:
	 Message-Id:To:Mime-Version;
	b=UihrDyTEQHE3zJQFaAtenqG6pKU82YZa35eXaxKnI/++OUbzgzA8GfxmuPsEQek9Y
	 zfGZe56ce2TxD5cLuLee7quHIKHDCSJRt7Ll4vYHUlE8q+y93ppMtOwgL8UJamDtuo
	 bl5+pkOwSlnigQIyKZ/8S6PrNZ3RvOj+zi7KRoC4=
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155690>

I have some config settings that I'll like to make default for anyone cloning/pulling from the central remote bare repository. I've tried to do this by editing the config file in the bare repository on the server but the change doesn't appear when cloning. How can I go about pushing default config settings to anyone cloing or pulling from the repository?