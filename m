From: Jonathan Watt <jwatt@jwatt.org>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 14:19:15 +0100
Message-ID: <47E658D3.1060104@jwatt.org>
References: <47E64F71.3020204@jwatt.org> <alpine.LSU.1.00.0803231401340.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:20:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQ7Q-0002Lc-19
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758351AbYCWNTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759073AbYCWNTb
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:19:31 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:49335 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758322AbYCWNTa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 09:19:30 -0400
X-Greylist: delayed 2409 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Mar 2008 09:19:30 EDT
Received: from [192.168.1.6] (ip1-182-173-82.adsl2.versatel.nl [82.173.182.1])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 96BE97FAA;
	Sun, 23 Mar 2008 06:19:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <alpine.LSU.1.00.0803231401340.4353@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77890>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 23 Mar 2008, Jonathan Watt wrote:
> 
>> There seems to be a problem with git-push when the working copy of the 
>> directory being pushed to came from the magic revision HEAD, but not 
>> when the working copy came from some other revision.
> 
> http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
> 
> Sidenote: I am constantly amazed how people have no problem accepting that 
> a CVS-Server has no working directory, but all of a sudden think that a 
> Git-server should have one, and auto-update it.

Hi Dscho. I think you've misread my email. (Or not read it. ;-)) I do not expect
git-push to update the working copy of the repository being pushed to. In fact
my complaint would be more that it *does* appear to modify the working copy
(well, not so much modify the working copy as get confused about which revision
the working copy came from) when the working copy came from HEAD.

Jonathan
