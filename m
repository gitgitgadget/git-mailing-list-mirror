From: Kevin Ballard <kevin@sb.org>
Subject: Re: Git aliases executed from wrong dir
Date: Wed, 25 Jun 2008 16:49:47 -0700
Message-ID: <E9A68D2F-10AD-4779-AACB-6152A38D37C5@sb.org>
References: <9777229F-27FD-4CB2-A5C7-6CA15733B8D2@sb.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:50:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBelB-0005Fn-Ak
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbYFYXtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbYFYXtt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:49:49 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:45134 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751358AbYFYXts (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 19:49:48 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 46880AF94F
	for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:49:48 -0700 (PDT)
In-Reply-To: <9777229F-27FD-4CB2-A5C7-6CA15733B8D2@sb.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86376>

To clarify, this only appears to affect shell aliases (i.e. ones that  
start with !).

   git config alias.foo 'ls-files'

Works fine from a subdir

   git config alias.foo '!git ls-files'

Doesn't behave right from a subdir.

-Kevin Ballard

On Jun 25, 2008, at 4:44 PM, Kevin Ballard wrote:

> If I create an alias with `git config alias.foo '!pwd'` and then run  
> it from a subdirectory of my repo, it prints out the root of my  
> repo. This prevents the ability to create aliases that take  
> filenames, as they simply won't work if you try and reference a file  
> from a subdirectory.
>
> -- 
> Kevin Ballard
> http://kevin.sb.org
> kevin@sb.org
> http://www.tildesoft.com
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
