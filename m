From: Colin Walters <walters@verbum.org>
Subject: git-evtag v2016.1
Date: Tue, 08 Mar 2016 10:08:24 -0500
Message-ID: <1457449704.1986312.543056834.5894AE0B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 16:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adJGd-0005qj-EC
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 16:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbcCHPId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 10:08:33 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37332 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932244AbcCHPI0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 10:08:26 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 19A0921362
	for <git@vger.kernel.org>; Tue,  8 Mar 2016 10:08:25 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute2.internal (MEProxy); Tue, 08 Mar 2016 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=MZCnyDaA5/cdKp+PshoV/xZMDMM=; b=fB3RU
	RiyQJgF879zNAamf9x9EiyfWfz53Ne0JdiBbbU1leHEdS5oMGNsNNeL62Ore363j
	J9Ptq+uL+nRscuzl96NcuqXfp9MUcc7Cg8uVhqlAykiM7rKVdn/0gjlPT80UZFTH
	sBNj8qXtbR7alPHGsgEKD9VoHFr0QFF8ms/qks=
Received: by web4.nyi.internal (Postfix, from userid 99)
	id BFEF9107C09; Tue,  8 Mar 2016 10:08:24 -0500 (EST)
X-Sasl-Enc: 60ElEWpYzZEERCp9fNISFH/eE1gQkT4DpfhntTnwNtVD 1457449704
X-Mailer: MessagingEngine.com Webmail Interface - ajax-27987fac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288439>

A while ago, I started a discussion on stronger verification of git
tags:

http://permalink.gmane.org/gmane.comp.version-control.git/264533

Since then I've been maintaining:
https://github.com/cgwalters/git-evtag

Which I think works well.  At some point I'd like to discuss merging
some of the functionality into the git core.  

However it's been useful to have a standalone program so that
I don't have to wait until a new version of git comes out, and it's
also just easier to prototype.

For those interested, a new version of git-evtag is available:

https://github.com/cgwalters/git-evtag/releases/tag/v2016.1
