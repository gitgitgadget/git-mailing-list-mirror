From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 15:36:18 -0500
Organization: MAD House Graphics
Message-ID: <hjvgs1$rep$1@ger.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 21:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naxdj-0006sm-9y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab0A2UkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103Ab0A2UkM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:40:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:34286 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190Ab0A2UkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:40:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NaxdO-0006iE-IF
	for git@vger.kernel.org; Fri, 29 Jan 2010 21:40:06 +0100
Received: from c-71-58-29-3.hsd1.de.comcast.net ([71.58.29.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:40:06 +0100
Received: from scottg.wp-hackers by c-71-58-29-3.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:40:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-58-29-3.hsd1.de.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <ron1-2E17EF.12204629012010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138353>

On 01/29/2010 03:20 PM, Ron1 wrote:
> [ron@mickey]$ git checkout master
> Already on 'master'
> [ron@mickey]$ git checkout master^
> Note: moving to 'master^' which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>    git checkout -b<new_branch_name>
> HEAD is now at 7be05e0... test
> [ron@mickey]$ git branch
> * (no branch)
>    master
> [ron@mickey]$
>
> Huh?!?
>
> This is a test repository which has never been pulled from nor pushed to
> anywhere.  So how is it possible that I have a non-local branch?
>
> Thanks,
> rg
>

I believe what you're seeing is known as a detached head (see 
<http://www.kernel.org/pub/software/scm/git/docs/git-checkout.html> 
though I could be wrong about this.)

I think you may have intended to do git checkout HEAD^ or something 
similar? basically what you did was (I think) checkout (or attempt to 
checkout) the parent commit on master.

this may offer some additional food for thought: 
<http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html#_exploring_history>

-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
