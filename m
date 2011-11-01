From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: checking out later commits from rolled back state
Date: Tue, 01 Nov 2011 15:58:58 +0100
Message-ID: <4EB00932.1090604@lyx.org>
References: <1320158207959-6951892.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: photoshop_nerd <JBreuer@consumercredit.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 15:59:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLFnz-0003FK-9u
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 15:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab1KAO7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 10:59:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57859 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab1KAO7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 10:59:05 -0400
Received: by eye27 with SMTP id 27so6278300eye.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 07:59:03 -0700 (PDT)
Received: by 10.14.12.209 with SMTP id 57mr1789116eez.59.1320159543765;
        Tue, 01 Nov 2011 07:59:03 -0700 (PDT)
Received: from [145.94.168.80] (wlan-145-94-168-080.wlan.tudelft.nl. [145.94.168.80])
        by mx.google.com with ESMTPS id 54sm60745746eex.8.2011.11.01.07.59.02
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 07:59:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1320158207959-6951892.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184570>

Op 1-11-2011 15:36, photoshop_nerd schreef:
> Hello, I a m relatively new to git, and my question pertains to moving back
> and forth through the history of my commits.
>
> Here is how I open a previous commit:
>
> 1)$ git log
>
> 2) (get sha1 hash of previous commit)
>
> 3)$ git checkout<hash of my previous commit>
>
> the problem is that once I am working with that commit, git log only shows
> the hash tags up to the time that the commit was made, but not any of the
> later commits. Is there a way to get the hash tags of my later commits when
> I am in that rolled back state?
>

If your are on branch 'master':

git log
git checkout <hash of previous commit>

then

"git log master" will show you the log from the tip of the master branch.

Vincent
