From: Jonathan Watt <jwatt@jwatt.org>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 15:48:10 +0100
Message-ID: <47E66DAA.4080807@jwatt.org>
References: <47E64F71.3020204@jwatt.org>  <alpine.LSU.1.00.0803231401340.4353@racer.site>  <47E658D3.1060104@jwatt.org>  <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>  <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com> <alpine.LSU.1.00.0803231519380.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdRVJ-0008Sy-Qq
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbYCWOsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbYCWOsR
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:48:17 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:51858 "EHLO
	spunkymail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754674AbYCWOsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 10:48:16 -0400
Received: from [192.168.1.6] (ip1-182-173-82.adsl2.versatel.nl [82.173.182.1])
	by spunkymail-a19.g.dreamhost.com (Postfix) with ESMTP id 5EB4C11DC0;
	Sun, 23 Mar 2008 07:48:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <alpine.LSU.1.00.0803231519380.4353@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77913>

Johannes Schindelin wrote:
>> The end result is that HEAD is always the most recent commit to which 
>> your working copy is relative to.  See also 
>> http://www.kernel.org/pub/software/scm/git/docs/glossary.html
>>
>> So, it sounds like we're both saying that in your case, you'd like the
>> HEAD become detached and track the sha1 that it previously pointed to
>> before your push rather than continuing to track the updated branch.
> 
> If you ever propose to detach the HEAD in a remote repository when 
> somebody pushed into the referenced branch, I am totally opposed to that.

The alternative is to leave the working copy in a totally broken state. I'm not
sure why that would be preferable.

> You can play your own games with the update and post-update hooks as much 
> as you want, but please leave official Git alone.  Thankyouverymuch.

My hope here is for a reduction in the pain/time taken out from real work in the
OSS developer world while people are moving to DSCMs - particularly for those
that have to learn/move between both Mercurial and git. Requiring people to be
aware of this gotcha and to use solutions like hooks seems to raise barriers
rather than eliminate them.

Cloning and working with multiple repositories locally is a particularly
Mercurial workflow. I see this issue as a barrier to those who've cut their DSCM
teeth on Mercurial and are trying to use git. Would detaching HEAD really be a
problem in git workflows?

Jonathan
