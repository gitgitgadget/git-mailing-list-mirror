From: Federico Lucifredi <flucifredi@acm.org>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 17:49:51 -0400
Message-ID: <48ADE2FF.4080704@acm.org>
References: <48ACB29C.7000606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWI4l-0004w3-2O
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbYHUVvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754708AbYHUVvK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:51:10 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:38293 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbYHUVvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:51:09 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 17:51:09 EDT
Received: (qmail 7637 invoked from network); 21 Aug 2008 21:44:28 -0000
Received: from unknown (HELO [164.99.130.55]) (federico@[130.57.22.201])
          (envelope-sender <flucifredi@acm.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <hpa@zytor.com>; 21 Aug 2008 21:44:28 -0000
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48ACB29C.7000606@zytor.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93217>

Hello HP,
  I have seen this in (funnily enough) a project I manage myself, which 
has subcommands structured similarly to Git.

  I have looked at options, but so far the current behavior (man 
foo-bar) seems the best option for foo's subcommand bar. The 
alternative, also acceptable, is a large page with subsections for each 
command. Sections (man 1) are used for chapter-like page groupings, not 
for subsections on a single command - those would have to be implemented 
as an additional layer.

  But, as another participant in the thread has commented, that would 
not port to other platforms very quickly (although it would get to Linux 
and OS-X promptly, and may eventually make its way into other platforms).

  I am open to ideas, but so far the two options above are better than 
anything else that has been so far suggested...

  Best -F

H. Peter Anvin wrote:
> Given the recent change of "git-foo" to "git foo", it would be really 
> nice if one could type, for example:
> 
>     man git clone
> 
> and actually get the man page for the git clone command.  There are 
> quite a few other pieces of software which also could benefit from that 
> kind of indirection.
> 
> Right now the above command shows the man page git(1) followed by 
> clone(2), which I believe has be classified as utterly useless behaviour...
> 
>     -hpa


-- 

_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - http://www.lucifredi.com
