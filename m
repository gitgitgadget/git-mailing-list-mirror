From: Antony Male <antony.male@gmail.com>
Subject: Re: Annoying absolute path for "core.worktree" to submodule
Date: Tue, 20 Mar 2012 13:31:18 +0000
Message-ID: <4F6886A6.3010805@gmail.com>
References: <20120320105243.2e8a489b@christian-hammerl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Hammerl <info@christian-hammerl.de>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Mar 20 14:31:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9z9y-0003y5-5D
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 14:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759754Ab2CTNb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 09:31:29 -0400
Received: from honeysuckle.london.02.net ([87.194.255.144]:51121 "EHLO
	honeysuckle.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab2CTNb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 09:31:28 -0400
Received: from [127.0.0.1] (87.194.161.58) by honeysuckle.london.02.net (8.5.140)
        id 4F58EC1A0052AC4C; Tue, 20 Mar 2012 13:31:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120320105243.2e8a489b@christian-hammerl.de>
X-Antivirus: avast! (VPS 120320-0, 20/03/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193511>

On 20/03/2012 9:52 am, Christian Hammerl wrote:
> Hey folks,
>
> I really love the work you are doing on GIT but the last update
> regarding submodules is a bit annoying. Although the path inside the
> ".git" file is stored relative to the submodule's path, the path in
> ".git/modules/path-to-submodule/config" is stored as an absolute path
> for "core.worktree".

What are you referring to as the "last update"? v1.7.8 introduced the 
separate git dir for submodules, and used an absolute path.

This absolute path was changed to a relative path in the patchset at 
[1], which is present in v1.7.10-rc1.


[1]: http://thread.gmane.org/gmane.comp.version-control.git/192173
