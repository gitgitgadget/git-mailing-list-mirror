From: Kyle Rose <krose@krose.org>
Subject: Re: cookbook question
Date: Thu, 28 Feb 2008 18:08:03 -0500
Message-ID: <47C73ED3.6000704@krose.org>
References: <47C704BB.2010707@krose.org> <20080228225838.GA31479@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 00:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUrrm-0005zO-Nl
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 00:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759067AbYB1XIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 18:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbYB1XIF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 18:08:05 -0500
Received: from kai.krose.org ([140.186.190.96]:46667 "EHLO mail.krose.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbYB1XIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 18:08:05 -0500
Received: from [172.16.25.54] (fw01.cmbrmaks.akamai.com [80.67.64.10])
	by mail.krose.org (Postfix) with ESMTP id E476A2AEC084;
	Thu, 28 Feb 2008 18:08:03 -0500 (EST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071229)
In-Reply-To: <20080228225838.GA31479@hashpling.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75474>


> I presume that origin/common contains changes to the common part of
> the config files that you want to apply to both machines. If the two
> machines' configs were originally branched from origin/common and then
> had there custom changes made and committed, you should just be able
> to merge subsequent changes from origin/common and not get conflicts
> unless there are genuinely changes to the parts of the configs that
> have been modified for the individual machines. I don't see a case for
> rebase in your example.
>
>   
The rebase just avoids unnecessary merge records.  What I really want is 
my changes placed on top of whatever the common head is at any one time, 
which by design means I would use rebase.  Aside from the cleanliness of 
the history, I'm not sure there is a real reason to do this.  But I like 
things clean. ;-)

Kyle

