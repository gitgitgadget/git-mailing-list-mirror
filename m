From: Andy Hawkins <andy@gently.org.uk>
Subject: Re: three questions: proper forum? & reverting changes to the
 working directory
Date: Thu, 8 Nov 2012 14:54:30 +0000 (UTC)
Organization: Gently
Message-ID: <slrnk9nht6.rce.andy@atom.gently.org.uk>
References: <A6B9336CDB62BB46B9F8708E686A7EA0115BAA1404@NRHMMS8P02.uicnrh.dom>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 15:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWTZH-0001SC-0K
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 15:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab2KHO6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 09:58:41 -0500
Received: from plane.gmane.org ([80.91.229.3]:55631 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab2KHO6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 09:58:41 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TWTZ9-0001Lc-Re
	for git@vger.kernel.org; Thu, 08 Nov 2012 15:58:47 +0100
Received: from cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com ([81.109.93.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 15:58:47 +0100
Received: from andy by cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 15:58:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209162>

Hi,

In article <A6B9336CDB62BB46B9F8708E686A7EA0115BAA1404@NRHMMS8P02.uicnrh.dom>,
           McKown, John<John.McKown@healthmarkets.com> wrote:

> 1) is this the proper forum for asking general git usage questions, such
> as "how to"?  If not, what is?

I'd say that here is fine. #git on freenode is also a good source of advice.

> 2) I am unsure that I did things the "proper" way. I have a git maintained
> subdirectory.  I made some changes and saved them in the working
> directory, but did not "git add" or "git commit" them.  I then decided
> that I really messed up what I was doing (basically reformatting some
> source code).  So to revert the changes back to what was last committed, I
> did a "git reset --hard HEAD".  I think this is the proper way.  But I
> picked up that command in the section of the documentation which was
> talking about abandoning a "git merge" attempt.  What I did worked, but is
> it the proper way?  If not, what is?

The easiest answer to this is run 'git status'. It'll list the files in
various states, and tell you how to undo the changes.

Andy
