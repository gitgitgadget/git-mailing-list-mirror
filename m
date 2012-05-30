From: Nick <oinksocket@letterboxes.org>
Subject: gitk - remembering views
Date: Wed, 30 May 2012 11:27:07 +0100
Message-ID: <4FC5F5FB.2000607@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 12:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZg7p-0002dN-NI
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab2E3K12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 06:27:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54593 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512Ab2E3K12 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 06:27:28 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C2BCA2097C
	for <git@vger.kernel.org>; Wed, 30 May 2012 06:27:27 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 30 May 2012 06:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=letterboxes.org;
	 h=message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=mesmtp; bh=M1YIv56FhfYQqTjwWty9Ybd
	Oq2s=; b=aX3+eJtcWymeo0Xl5xfUXMA7l5hXljYVYtRoF/6ZDRecAKpDo0cRgYa
	wFH6ApDFMF3t8VpEBBnU7TUxIOXhd4fZe3HLdO4ZsBzzti6B+662hUe5eKcBD43a
	E3GJ/ISL42uF8fz7oBJEPAxtqTVYAwoUJhF+xWi8gcGr5k1jKC3Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=M
	1YIv56FhfYQqTjwWty9YbdOq2s=; b=dem8Zgei7uZ+T471QYRV4ljvqjZmIjnPT
	z5OIwK40VurY2zUgD/Z/qN5MFFTQfT62XeGlvqxZ8oturF/BswedhZiSDCZH+CF8
	UDwSTprdvi9D2F5KQuGk2QI6RFL/fSQKVsLY4y9CSY0YI64vkMOeoZMSClheUs7g
	nZKKCV3nMg=
X-Sasl-enc: An17yTdYZETHvMiMx8RgzeuO/gJvPYY2iW6j/3+zcUw5 1338373647
Received: from [192.168.0.103] (unknown [87.194.154.6])
	by mail.messagingengine.com (Postfix) with ESMTPA id 606328E01BA
	for <git@vger.kernel.org>; Wed, 30 May 2012 06:27:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198793>

Hello,

gitk has a feature in which one or more "views" can be created of a repository.
 I find this useful, and I find my self creating the same views over and over
(typically: show all refs, show local refs, show only the current branch).  I
then switch between them when rebasing branches, depending on what I want to know.

Is there any way to get gitk to save these views and even share them between
repositories?  There is a "remember me" checkbox in each view's settings, but so
far as I can tell, that doesn't do anything: when gitk is restarted, the views
are lost.

Thanks,

N
