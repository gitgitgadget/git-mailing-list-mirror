From: Peter Eisentraut <peter@eisentraut.org>
Subject: log.decorate=auto not documented
Date: Wed, 27 Aug 2014 10:46:42 -0400
Message-ID: <53FDEF52.3030101@eisentraut.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 16:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMeUs-0002Sz-6H
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935007AbaH0Oqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 10:46:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47206 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933802AbaH0Oql (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 10:46:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway2.nyi.internal (Postfix) with ESMTP id 2BB472037E
	for <git@vger.kernel.org>; Wed, 27 Aug 2014 10:46:40 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 27 Aug 2014 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=z
	jmk3DdMPyJ0EKbsCdCyZiFmNVw=; b=iKoC4xWaowwHecQOMqTcITKjGCFjHd58q
	PMihO+8PnNHOy/Rd/uYUD5XwJRDr9bAHAe+HBfuQk9O1aT5xhoOq1mNhUheV0UBw
	1jlMsmFttrv2D0RuwPSQ5RkCpSpA64qJWxd9eD23ptMjF3oxaI/l/dpgoBXVFF5I
	AS7DxTt/v0=
X-Sasl-enc: AsggVnwVwc/y/cgCc6ASqtKmIpG/Rs/vlhzdLuzVXS7g 1409150800
Received: from jesse.mybdev.com (unknown [204.145.120.11])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0BB33C00910
	for <git@vger.kernel.org>; Wed, 27 Aug 2014 10:46:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256000>

The log.decorate=auto value, which is mentioned in the release notes of
Git 2.1, is not documented in either git-config.txt or git-log.txt.

It should also be documented that "auto" corresponds to "short".
