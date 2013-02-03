From: TJ <git@iam.tj>
Subject: [New Feature] git-submodule-move - Easily move submodules
Date: Sun, 03 Feb 2013 22:36:17 +0000
Message-ID: <510EE661.8060600@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 23:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U28B1-0002JJ-9U
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 23:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3BCWgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 17:36:21 -0500
Received: from yes.iam.tj ([109.74.197.121]:33031 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753760Ab3BCWgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 17:36:20 -0500
Received: from [10.254.251.193] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id D9B7B18177
	for <git@vger.kernel.org>; Sun,  3 Feb 2013 22:36:18 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215339>

I've recently had need to re-arrange more than ten submodules within a project and discovered there is apparently no easy way to do it.

Using some suggestions I found on Stack Overflow I eventually figured out the steps required. Because the steps can be
complex I thought it would be handy to have a tool to automate the functionality.

I have put together a reasonably bullet-proof shell script "git-submodule-move" that does the job pretty well. I've put it through quite a bit of testing and trusted it with my own project and it has
performed well.

I've published to github so others can use and improve it.

https://github.com/iam-TJ/git-submodule-move
