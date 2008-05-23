From: Kevin Ballard <kevin@sb.org>
Subject: Re: gitignore: negating path patterns
Date: Thu, 22 May 2008 17:23:54 -0700
Message-ID: <5BBB5607-DF95-4C06-BE6C-C3D7AF475FBF@sb.org>
References: <g11cvn$ndr$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri May 23 02:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzL5T-0006vk-JO
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 02:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692AbYEWAX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758837AbYEWAX4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 20:23:56 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:54102 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758511AbYEWAXz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 May 2008 20:23:55 -0400
Received: from [10.100.18.156] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 2B52EEEF87;
	Thu, 22 May 2008 17:23:55 -0700 (PDT)
In-Reply-To: <g11cvn$ndr$1@ger.gmane.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82673>

On May 21, 2008, at 7:52 AM, Michael J Gruber wrote:

> Hi there
>
> It seems that negating path patterns in gitignore doesn't work, or I
> don't understand it (or both). With the attached script, git status
> (1.5.5.1) reports "dir/a" as new and "dir/b" as untracked. I would
> rather expect it to report "dir/c" as untracked also.
>
> It seems that "!b" matches to include "dir/b" (reverting the exclusion
> "*" as expected), whereas "!dir/" does not match to include "dir/c".
>
> What's going on here?

"dir/" will not match anything, because paths are compared without  
trailing slashes. Try "!dir".

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
